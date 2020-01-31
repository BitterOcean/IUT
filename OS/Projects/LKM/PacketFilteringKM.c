/*
*     Packet Filtering Kernel Module
*
*     Create By : Maryam Saeedmehr
*     Stu.NO :‌ 9629373
*
*     Created On : Tue Jan 7, 18:10
*     Language : C
*/

#include <linux/init.h>           // Macros used to mark up functions e.g. __init __exit
#include <linux/module.h>         // Core header for loading LKMs into the kernel
#include <linux/device.h>         // Header to support the kernel Driver Model
#include <linux/kernel.h>         // Contains types, macros, functions for the kernel
#include <linux/fs.h>             // Header for the Linux file system support
#include <linux/uaccess.h>        // Required for the copy to user function
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/skbuff.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include <linux/icmp.h>
#include <linux/ip.h>
#include <linux/inet.h>
#include <linux/time.h>

#define  DEVICE_NAME "packetfilter" ///< The device will appear at /dev/ebbchar using this value
#define  CLASS_NAME  "pktfltr" ///< The device class -- this is a character device driver
#define  ADDRESSES 20

MODULE_LICENSE("GPL");///< The license type -- this affects available functionality
MODULE_AUTHOR("Maryam Saeedmehr");///< The author -- visible when you use modinfo
MODULE_DESCRIPTION("A simple packet dropper for the operating systems course homework");///< The description -- see modinfo
MODULE_VERSION("1.0");///< A version number to inform users

static int            majorNumber;///< Stores the device number -- determined automatically
static char           message[256] = {0};///< Memory for the string that is passed from userspace
static short          size_of_message;///< Used to remember the size of the string stored
static int            configType = 0;
static int            numberReads=0;
static int            numberOpens = 0;///< Counts the number of times the device is opened
static struct class*  packetFilterClass  = NULL; ///< The device-driver class struct pointer
static struct device* packetFilterDevice = NULL; ///< The device-driver device struct pointer
static int            packetFilterNet;
static struct sk_buff *sock_buff;
static struct iphdr   *ip_header;
static struct udphdr  *udp_header;
static struct tcphdr  *tcp_header;

static char           file_from_user[ADDRESSES+2][25];

static int     device_open(struct inode *, struct file *);
static int     device_release(struct inode *, struct file *);
static ssize_t device_write(struct file *, const char *, size_t, loff_t *);

static struct file_operations fops =
{
  .open = device_open,
  .write = device_write,
  .release = device_release,
};

unsigned int   packet_hook(unsigned int hooknum,
                           struct sk_buff *skb,
                           const struct net_device *in,
                           const struct net_device *out,
                           int(*okfn)(struct sk_buff *));

static struct nf_hook_ops packet_filter __read_mostly =
{
  .pf = NFPROTO_IPV4,
  .priority = NF_IP_PRI_FIRST,
  .hooknum =NF_INET_LOCAL_IN,
  .hook = (nf_hookfn *) packet_hook
};

static int __init packet_filter_init(void)
{
    majorNumber = register_chrdev(0, DEVICE_NAME, &fops);
    if (majorNumber<0)
    {
        printk(KERN_ALERT "Registering char device failed with %d\n", majorNumber);
        return majorNumber;
    }
    printk(KERN_INFO "Registering char device has successfully done with major number %d\n", majorNumber);

    // Register the device class
    packetFilterClass = class_create(THIS_MODULE, CLASS_NAME);
    if (IS_ERR(packetFilterClass))
    {
        // Check for error and clean up if there is
        unregister_chrdev(majorNumber, DEVICE_NAME);
        printk(KERN_ALERT "Failed to register device class\n");
        return PTR_ERR(packetFilterClass);// Correct way to return an error on a pointer
    }
    printk(KERN_INFO "Device class registered successfully\n");

    // Register the device driver
    packetFilterDevice = device_create(packetFilterClass, NULL, MKDEV(majorNumber, 0), NULL, DEVICE_NAME);
    printk(KERN_INFO "Device created successfully with major number %d\n", majorNumber);
    if (IS_ERR(packetFilterDevice))
    {
        // Clean up if there is an error
        class_destroy(packetFilterClass);// Repeated code but the alternative is goto statements
        unregister_chrdev(majorNumber, DEVICE_NAME);
        printk(KERN_ALERT "Failed to create the device\n");
        return PTR_ERR(packetFilterDevice);
    }

    packetFilterNet = nf_register_net_hook(&init_net,&packet_filter);// Record in net filtering
    printk(KERN_INFO "Network registered correctly\n");
    if(packetFilterNet)
    {
        printk(KERN_ALERT"Faild to register a record in netfilter\n");
        class_destroy(packetFilterClass);// Repeated code but the alternative is goto statements
        unregister_chrdev(majorNumber, DEVICE_NAME);
        device_destroy(packetFilterClass, MKDEV(majorNumber, 0));// remove the device
        nf_unregister_net_hook(&init_net,&packet_filter);// UnRecord in net filtering
        return packetFilterNet;
    }
    printk(KERN_INFO "Kernel module created successfully\n"); // Made it! device was initialized
    return 0;
}

static void __exit  packet_filter_exit(void)
{
    nf_unregister_net_hook(&init_net,&packet_filter);// UnRecord in net filtering
    device_destroy(packetFilterClass, MKDEV(majorNumber, 0));// remove the device
    class_unregister(packetFilterClass);// unregister the device class
    class_destroy(packetFilterClass);// remove the device class
    unregister_chrdev(majorNumber, DEVICE_NAME);
    printk(KERN_INFO "Module has unloaded\n");
}

static int device_open(struct inode *inodep, struct file *filep){
    numberOpens++;
    printk(KERN_INFO "Device has been opened %d time(s)\n", numberOpens);
    return 0;
}

static int device_release(struct inode *inodep, struct file *filep){
    printk(KERN_INFO "Device successfully closed\n");
    return 0;
}

static ssize_t device_write(struct file *filep, const char *buffer, size_t len, loff_t *offset)
{
    copy_from_user(message, buffer, len);// appending received string with its length
    size_of_message = strlen(message);
    if (numberReads == 0)
    {
        configType = 1;
        if (message[0] == 'b')
        {
            configType = 0;
        }
        printk(KERN_INFO "Config type : %d\n", configType);
    }
    else
    {
        strcpy(file_from_user[numberReads-1], message);
        printk(KERN_INFO "File from user : %s\n", file_from_user[numberReads-1]);
    }
    numberReads++;
    printk(KERN_INFO "Received %zu characters from the user %s numberReads : %d\n", len, message, numberReads);
    return len;
}

unsigned int packet_hook(unsigned int hooknum,
                         struct sk_buff *skb,
                         const struct net_device *in,
                         const struct net_device *out,
                         int(*okfn)(struct sk_buff *))
{
    int flag = 0 ;
    int i = 0;
    char source_string[16], tmp[20];
    unsigned int source_port;
    unsigned int source_address;
    struct timespec curr_tm;
    getnstimeofday(&curr_tm);
    printk(KERN_INFO "PACKET in packet hook");
    sock_buff = skb;
    ip_header = (struct iphdr *)skb_network_header(sock_buff);
    source_address= (unsigned int)ip_header->saddr;
    snprintf(source_string,16,"%pI4",&source_address);

    if(ip_header->protocol==17)
    {
        udp_header= (struct udphdr *)((__u32 *)ip_header+ ip_header->ihl);// this fixed the problem
        source_port = htons((unsigned short int) udp_header->source);// sport now has the source port
        sprintf(tmp,"%s:%d\n",source_string,source_port);
        printk(KERN_INFO "(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Packet recieved",
                          (curr_tm.tv_sec / 3600) % (24),
                          (curr_tm.tv_sec / 60) % (60),
                          (curr_tm.tv_sec) % (60),
                          (curr_tm.tv_nsec) / (1000));
        if(numberReads)
        {
            for (; i < numberReads ; i++)
            {
                if(!strcmp(tmp,file_from_user[i]))
                {
                    flag = 1;
                    break;
                }
            }
            if(configType)
            {
                if (flag)
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it due to being in whitelist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_ACCEPT;
                }
                else
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and dropped it due to not being in whitelist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_DROP;
                }
            }
            else
            {
                if(flag)
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and dropped it duo to being in blacklist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_DROP;
                }
                else
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it duo to not being in blacklist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_ACCEPT;
                }
            }
        }
        else
        {
            printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it due to no list!\n",
                              (curr_tm.tv_sec / 3600) % (24),
                              (curr_tm.tv_sec / 60) % (60),
                              (curr_tm.tv_sec) % 60,
                              (curr_tm.tv_nsec) / 1000);
            return NF_ACCEPT;
        }
    }
    else if(ip_header->protocol == 6)
    {
        tcp_header= (struct tcphdr *)((__u32 *)ip_header+ ip_header->ihl); //this fixed the problem
        source_port = htons((unsigned short int) tcp_header->source); //sport now has the source port
        sprintf(tmp,"%s:%d\n",source_string,source_port);
        printk(KERN_INFO "(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Packet recieved",
                          (curr_tm.tv_sec / 3600) % (24),
                          (curr_tm.tv_sec / 60) % (60),
                          (curr_tm.tv_sec) % 60,
                          (curr_tm.tv_nsec) / 1000);
        if(numberReads)
        {
            for (; i < numberReads ; i++)
            {
                if(!strcmp(tmp,file_from_user[i]))
                {
                    flag = 1;
                    break;
                }
            }
            if(configType)
            {
                if (flag)
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it due to being in whitelist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_ACCEPT;
                }
                else
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and dropped it due to not being in whitelist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_DROP;
                }
            }
            else
            {
                if(flag)
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and dropped it duo to being in blacklist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_DROP;
                }
                else
                {
                    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it duo to not being in blacklist\n",
                                      (curr_tm.tv_sec / 3600) % (24),
                                      (curr_tm.tv_sec / 60) % (60),
                                      (curr_tm.tv_sec) % 60,
                                      (curr_tm.tv_nsec) / 1000);
                    return NF_ACCEPT;
                }
            }
        }
        else
        {
            printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it due to no list!\n",
                              (curr_tm.tv_sec / 3600) % (24),
                              (curr_tm.tv_sec / 60) % (60),
                              (curr_tm.tv_sec) % 60,
                              (curr_tm.tv_nsec) / 1000);
            return NF_ACCEPT;
        }
    }

    if(!sock_buff)
    {
        printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and dropped it due to that if\n",
                          (curr_tm.tv_sec / 3600) % (24),
                          (curr_tm.tv_sec / 60) % (60),
                          (curr_tm.tv_sec) % 60,
                          (curr_tm.tv_nsec) / 1000);
        return NF_DROP;
    }

    printk(KERN_INFO"(TIME: %.2lu:%.2lu:%.2lu:%.6lu) Got a new Packet and accepted it due to that idk\n",
                      (curr_tm.tv_sec / 3600) % (24),
                      (curr_tm.tv_sec / 60) % (60),
                      (curr_tm.tv_sec) % 60,
                      (curr_tm.tv_nsec) / 1000);
    return NF_ACCEPT;
}

module_init(packet_filter_init);
module_exit(packet_filter_exit);
