import socket
import threading

def handle(client , address):
    while True:
        data = client.recv(2048)
        if data:
            print('Received from client: %s' % data)
            client.send(data)
    client.close()


BACKOLG = 5
sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
#don't miss this line or you wouldn't retest this script over and over
sock.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
server_address = ('localhost',10100)

print('Server running on %s:%d' % server_address)

sock.bind(server_address)
sock.listen(BACKOLG)
while True:
    client , address = sock.accept()
    #print('Request from the ip: %s' % address[0])
    threading._start_new_thread(handle,(client,address))