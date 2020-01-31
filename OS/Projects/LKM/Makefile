obj-m+=PacketFilteringKM.o

all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
	$(CC) App_PacketFiltering.c -o App_pktfltr
clean:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
	rm App_pktfltr
