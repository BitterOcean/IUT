# PacketFilteringKernelModule[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule)

This is a Kernel Module for Packet Filtering 

Author : Maryam Saeedmehr

Language : C

## **Cloning**

First of All Clone the Project : 

```shell
$ git clone https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule.git
```

## **Building & Cleaning Module**

- To build this module, type:
```shell
$ make
```
- To clean up the module, type:
```shell
$ make clean
```

## **Loading & Unloading Module**

- To install the module, type:
```shell
$ sudo insmod PacketFilteringKM.ko
```
- To remove the module, type:
```shell
$ sudo rmmod PacketFilteringKM
```
- To verify the module is actually loaded or unloaded, type:
```shell
$ dmesg | tail
```
- To run the App_pktfltr
```shell
$ sudo ./App_pktfltr
```

## **Module Information**

- Module to Get Rules from User
- Just read : <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/PacketFilteringDocumentation.pdf">`/PacketFilteringDocumentation.pdf`</a>

## **Theory**

Netfilter is a packet filtering subsystem in the Linux kernel stack and has been there since kernel 2.4.x. Netfilter's core consists of five hook functions declared in linux/netfilter_ipv4.h. Although these functions are for IPv4, they aren't much different from those used in the IPv6 counterpart. The hooks are used to analyze packets in various locations on the network stack. This situation is depicted below:
```
  [INPUT]--->[1]--->[ROUTE]--->[3]--->[4]--->[OUTPUT]
                       |            ^
                       |            |
                       |         [ROUTE]
                       v            |
                      [2]          [5]
                       |            ^
                       |            |
                       v            |
                    [INPUT*]    [OUTPUT*]
                    
[1]  NF_IP_PRE_ROUTING (Right after the packets have been received. )
[2]  NF_IP_LOCAL_IN (Packets addressed to the network stack. )
[3]  NF_IP_FORWARD (Packets that should be forwarded. )
[4]  NF_IP_POST_ROUTING (Packets that have been routed and are ready to leave)
[5]  NF_IP_LOCAL_OUT (Packets from our own network stack)
[*]  Network Stack
```

Our hook function will return one of the following codes:
1. NF_ACCEPT: accept the packet (continue network stack trip)
2. NF_DROP: drop the packet (don't continue trip)

After we write our hook function, we have to register its options with the nf_hook_ops struct located in linux/netfilter.h.
```
struct nf_hook_ops
{
        struct list_head list;
        nf_hookfn *hook;
        int pf;
        int hooknum;
        int priority;
};

[1] list_head struct is used to keep a linked list of hooks
[2] nf_hookfn* struct member is the name of the hook function that we define
[3] pf integer member is used to identify the protocol family; it's PF_INET for IPv4
[4] hooknum (int) is for the hook we want to use
[5] priority (int) specifies in linux/netfilter_ipv4.h, but for our situation we want NF_IP_PRI_FIRST
```

The rest of the code is pretty self explanatory. In-line comments are provided for assistance.


## **Enjoy It**

![PacketFilteringKM](https://user-images.githubusercontent.com/49061503/71977958-65bda300-322f-11ea-8dfb-f38a827d7895.gif)


## **Files**

- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/App_PacketFiltering.c">`/App_PacketFiltering.c`</a> : This is an application interfacing user and module( user mood and kernel mood )
- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/Makefile">`/Makefile`</a> : This file is used to make or clean the codes
- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/PacketFilteringDocumentation.pdf">`/PacketFilteringDocumentation.pdf`</a> : This is the documentation of the project in Percian
- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/PacketFilteringKM.c">`/PacketFilteringKM.c`</a> : This the Kernel Module ( main file! )
- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/config.txt">`/config.txt`</a> : This is a Config file ( as an Example :smile: )
- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/HW_Practical_2.pdf">`/W_Practical_2.pdf`</a> : This is the HomeWork file
- <a href="https://github.com/MaryamSaeedmehr/PacketFilteringKernelModule/blob/master/LICENSE">`/LICENSE`</a> : The license of this project


## **Support**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## **License**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
