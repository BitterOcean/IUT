"""
Project4 Custom Topology

Author 	 : Maryam Saeedmehr
Std. NO. : 9629373

* How to establish it?
Just Run:

~$ sudo mn --custom mesh.py --topo sample --controller=remote,ip=127.0.0.1,port=6633

to connect ODL to mininet
"""
from mininet.topo import Topo

class myTopo(Topo):

	def __init__(self):

		Topo.__init__(self)

		#hosts definition
		Host1 = self.addHost('h1')
		Host2 = self.addHost('h2')
		Host3 = self.addHost('h3')
		Host4 = self.addHost('h4')
		Host5 = self.addHost('h5')
		
		#switches definition
		Switch1 = self.addSwitch('s1')
		Switch2 = self.addSwitch('s2')
		Switch3 = self.addSwitch('s3')
		Switch4 = self.addSwitch('s4')
		Switch5 = self.addSwitch('s5')
		

		#links definition
		self.addLink(Host1,Switch1)
		self.addLink(Host2,Switch2)
		self.addLink(Host3,Switch2)
		self.addLink(Host4,Switch3)
		self.addLink(Host5,Switch3)

		self.addLink(Switch1,Switch5)
		self.addLink(Switch1,Switch2)

		self.addLink(Switch2,Switch3)
		self.addLink(Switch2,Switch4)
		self.addLink(Switch2,Switch5)

		self.addLink(Switch3,Switch4)
		self.addLink(Switch3,Switch5)

		self.addLink(Switch4,Switch5)


topos = {'sample':(lambda: myTopo())}
