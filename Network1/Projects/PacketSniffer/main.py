import socket
import struct
import textwrap
import time

PCAP_GLOBAL_HEADER_FMT = '@ I H H i I I I '

# Global Header Values
PCAP_MAGICAL_NUMBER = 2712847316
PCAP_MJ_VERN_NUMBER = 2
PCAP_MI_VERN_NUMBER = 4
PCAP_LOCAL_CORECTIN = 0
PCAP_ACCUR_TIMSTAMP = 0
PCAP_MAX_LENGTH_CAP = 65535
PCAP_DATA_LINK_TYPE = 1


class Pcap:
    def __init__(self, filename, link_type=PCAP_DATA_LINK_TYPE):
        self.pcap_file = open(filename, 'wb')  # 4 + 2 + 2 + 4 + 4 + 4 + 4
        self.pcap_file.write(struct.pack('@ I H H i I I I ', PCAP_MAGICAL_NUMBER, PCAP_MJ_VERN_NUMBER, PCAP_MI_VERN_NUMBER, PCAP_LOCAL_CORECTIN, PCAP_ACCUR_TIMSTAMP, PCAP_MAX_LENGTH_CAP, link_type))

    def write_list(self, data=[]):
        for i in data:
            self.write(i)
        return

    def write(self, data):
        ts_sec, ts_usec = map(int, str(time.time()).split('.'))
        length = len(data)
        self.pcap_file.write(struct.pack('@ I I I I', ts_sec, ts_usec, length, length))
        self.pcap_file.write(data)

    def close(self):
        self.pcap_file.close()


class HTTP:
    def __init__(self, raw_data):
        try:
            self.data = raw_data.decode('utf-8')
        except:
            self.data = raw_data


def main():
    File = Pcap('Temp.pcap')
    conn = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(3))
    while True:
        raw_data, addr = conn.recvfrom(65536)
        dest_mac, src_mac, eth_proto, data = ethernet_frame(raw_data)
        print('\nEthernet Frame:')
        print('\t -' + 'Destination: {}, Source: {}, Protocol: {}'.format(dest_mac, src_mac, eth_proto))
        File.write(raw_data)
        File.pcap_file.flush()

        # 8 for IPv4
        if eth_proto == 8:
            (version, header_length, ttl, proto, src, target, data) = ipv4_packet(data)
            print('\t - ' + 'IPv4 packet:')
            print('\t\t - ' + 'Version: {}, Header Length: {}, TTL: {}'.format(version, header_length, ttl))
            print('\t\t - ' + 'Protocol: {}, Source: {}, Target: {}'.format(proto, src, target))

            # ICMP
            if proto == 1:
                icmp_type, code, checksum, data = icmp_pack(data)
                print('\t - ' + 'ICMP packet:')
                print('\t\t - ' + 'Type: {}, Code: {}, Checksum: {}'.format(icmp_type, code, checksum))
                print('\t - ' + 'Data:')
                print(format_multi_line('\t\t\t', data))

            # TCP
            elif proto == 6:
                (src_port, dest_port, sequence, acknowledgement, flag_urg, flag_ack, flag_psh, flag_rst, flag_syn, flag_fin, data) = tcp_segment(data)
                print('\t - ' + 'TCP Segment: ')
                print('\t\t - ' + 'Source Port: {} , Destination Port : {}'.format(src_port, dest_port))
                print('\t\t - ' + 'Sequence: {} , Acknowledgement : {}'.format(sequence, acknowledgement))
                print('\t\t - ' + 'Flags: ')
                print('\t\t\t - ' + 'URG: {}, ACK: {}, PSH: {}, RST: {}, SYN: {}, FIN: {}'.format(flag_urg, flag_ack, flag_psh, flag_rst, flag_syn, flag_fin))

                if len(data) > 0:
                    # HTTP
                    if src_port == 80 or dest_port == 80:
                        print('\t\t - ' + 'HTTP Data:')
                        try:
                            http = HTTP(data)
                            http_info = str(http.data).split('\n')
                            for line in http_info:
                                print('\t\t\t - ' + str(line))
                        except:
                            print(format_multi_line('\t\t\t - ', data))

                    else:
                        print('\t\t - ' + 'TCP Data:')
                        print(format_multi_line('\t\t\t - ', data))

            # UDP
            elif proto == 17:
                src_port, dest_port, length, data = udp_segment(data)
                print('\t - ' + 'UDP Segment: ')
                print('\t\t - ' + 'Source Port: {}, Destination Port: {}, Length: {}'.format(src_port, dest_port, length))

            # Other
            else:
                print('\t - ' + 'Data : ')
                print(format_multi_line('\t\t ', data))

        else:
            print('\t - ' + 'Data: ')
            print(format_multi_line('\t\t', data))

    File.close()


# unpack ethernet frame
def ethernet_frame(data):
    dest_mac, src_mac, proto = struct.unpack('! 6s 6s H', data[:14])
    return get_mac_addr(dest_mac), get_mac_addr(src_mac), socket.htons(proto), data[14:]


# return properly formatted MAC address (ie AA:BB:CC:DD:EE:FF)
def get_mac_addr(bytes_addr):
    bytes_str = map('{:02x}'.format, bytes_addr)
    return ':'.join(bytes_str).upper()


# Unpacks IPv4 packet
def ipv4_packet(data):
    version_header_length = data[0]
    version = version_header_length >> 4
    header_length = (version_header_length & 15) * 4
    ttl, proto, src, target = struct.unpack('! 8x B B 2x 4s 4s', data[:20])
    return version, header_length, ttl, proto, ipv4(src), ipv4(target), data[header_length:]


# return properly formatted IPv4 address (ie 127.0.0.1)
def ipv4(addr):
    return '.'.join(map(str, addr))


# Unpacks ICMP packet
def icmp_pack(data):
    icmp_type, code, checksum = struct.unpack('! B B H', data[:4])
    return icmp_type, code, checksum, data[4:]


# Unpacks TCP segments
def tcp_segment(data):
    (src_port, dest_port, sequence, acknowledgement, offset_reserved_flag) = struct.unpack('! H H L L H', data[:14])
    offset = (offset_reserved_flag >> 12) * 4
    flag_urg = (offset_reserved_flag & 32) >> 5
    flag_ack = (offset_reserved_flag & 16) >> 4
    flag_psh = (offset_reserved_flag & 8) >> 3
    flag_rst = (offset_reserved_flag & 4) >> 2
    flag_syn = (offset_reserved_flag & 2) >> 1
    flag_fin = offset_reserved_flag & 1
    return src_port, dest_port, sequence, acknowledgement, flag_urg, flag_ack, flag_psh, flag_rst, flag_syn, flag_fin, data[offset:]


# Unpacks UDP segments
def udp_segment(data):
    src_port, dest_port, length = struct.unpack('! H H 2x H', data[:8])
    return src_port, dest_port, length, data[8:]


def http_header(packet):
    http_packet = str(packet)
    if http_packet.find('GET'):
        return GET_print(packet)


def GET_print(packet1):
    return "".join(packet1.sprintf("{Raw:%Raw.load%}\n").split(r"\r\n"))


def format_multi_line(pre, string, size=80):
    size -= len(pre)
    if isinstance(string, bytes):
        string = ''.join(r'\x{:02x}'.format(byte) for byte in string)
        if size % 2:
            size -= 1
    return '\n'.join([pre+line for line in textwrap.wrap(string, size)])


main()
