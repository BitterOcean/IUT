import socket

sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server_address = ('localhost',10100)
print('Connecting to %s port %s' % server_address)

try:
    sock.connect(server_address)
    msg = input('client> ')
    while msg != 'exit':
        sock.sendall(msg.encode('utf-8'))
        data = sock.recv(2048)
        print('Received: %s' % data.decode('utf-8'))
        msg = input('client> ')
except socket.gaierror as e:
    print('Socket error: %s' % str(e))
except Exception as e:
    print(e)
finally:
    sock.close()