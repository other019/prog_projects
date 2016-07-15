import socket

def listen():
    s = socket.socket(socket.AF_INET,socket.SOCK_RAW,socket.IPPROTO_ICMP)
    s.setsockopt(socket.SOL_IP, socket.IP_HDRINCL, 1)
    msg=""
    while 1:
        data, addr = s.recvfrom(1508)
        #print "%r" % data[-40:-24]
        msg+=data[-40:-24]
        print msg


if __name__=='__main__':
    listen()
