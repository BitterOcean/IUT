"""
Project3 Question1 Flow Table Entries

Author   : Maryam Saeedmehr
Std. NO. : 9629373

* How to establish it?
Just Run:

~$ python entity.py

"""
import httplib
import json

class StaticEntryPusher(object):
	def __init__(self,server):
		self.server = server

	def get(self,data):
		ret=self.rest_call({}, 'GET')
		return json.loads(ret[2])
	
	def Set(self,data):
		ret=self.rest_call(data,'POST')
		return ret[0]==200
	
	def remove(self,objtype,data):
		ret=self.rest_call(data,'DELETE')
		return ret[0]==200
	
	def rest_call(self,data,action):
		path='/wm/staticentrypusher/json'
		header={
			'Cantent-type':'application/json',
			'Accept':'application/json'
		}
		body=json.dumps(data)
		Conn=httplib.HTTPConnection(self.server,8080)
		Conn.request(action,path,body,header)
		response=Conn.getresponse()
		ret=(response.status,response.reason,response.read())
		print ret
		Conn.close()
		return ret

pusher=StaticEntryPusher('127.0.0.1')

# -------------------------------------------------------------------
# Tunnel 1 from h1 to h9
# H1 -> S1 -> S2 -> S13 -> S12 -> S11 -> H9
Entity1={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity1",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.09",
	"ip_tos":"1",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"push_mpls=0x8847,set_field=mpls_label->1,output=1"
}
Entity2={
	"switch":"00:00:00:00:00:00:00:02",
	"name":"Entity2",
	"eth_type":"0x8847",
	"mpls_label":"1",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->1,output=2"
}
Entity3={
	"switch":"00:00:00:00:00:00:00:0d",
	"name":"Entity3",
	"eth_type":"0x8847",
	"mpls_label":"1",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->1,output=1"
}
Entity4={
	"switch":"00:00:00:00:00:00:00:0c",
	"name":"Entity4",
	"eth_type":"0x8847",
	"mpls_label":"1",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->1,output=1"
}
Entity5={
	"switch":"00:00:00:00:00:00:00:0b",
	"name":"Entity5",
	"eth_type":"0x8847",
	"mpls_label":"1",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"pop_mpls=0x0800,output=3"
}
# Tunnel 2 from h1 to h9
# H1 -> S1 -> S3 -> S4 -> S5 -> S7 -> S8 -> S10 -> S11 -> H9
Entity6={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity6",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.09",
	"ip_tos":"2",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"push_mpls=0x8847,set_field=mpls_label->2,output=2"
}
Entity7={
	"switch":"00:00:00:00:00:00:00:03",
	"name":"Entity7",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->2,output=2"
}
Entity8={
	"switch":"00:00:00:00:00:00:00:04",
	"name":"Entity8",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->2,output=2"
}
Entity9={
	"switch":"00:00:00:00:00:00:00:05",
	"name":"Entity9",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->2,output=3"
}
Entity10={
	"switch":"00:00:00:00:00:00:00:07",
	"name":"Entity10",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->2,output=3"
}
Entity11={
	"switch":"00:00:00:00:00:00:00:08",
	"name":"Entity11",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->2,output=3"
}
Entity12={
	"switch":"00:00:00:00:00:00:00:0a",
	"name":"Entity12",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->2,output=3"
}
Entity13={
	"switch":"00:00:00:00:00:00:00:0b",
	"name":"Entity13",
	"eth_type":"0x8847",
	"mpls_label":"2",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"pop_mpls=0x0800,output=3"
}
# -------------------------------------------------------------------
# Tunnel 1 from h4 to h7
# H4 -> S5 -> S7 -> H7
Entity14={
	"switch":"00:00:00:00:00:00:00:05",
	"name":"Entity14",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.04",
	"ipv4_dst":"10.0.0.07",
	"ip_tos":"3",
	"priority":"32768",
	"in_port":"4",
	"active":"true",
	"actions":"push_mpls=0x8847,set_field=mpls_label->3,output=3"
}
Entity15={
	"switch":"00:00:00:00:00:00:00:07",
	"name":"Entity15",
	"eth_type":"0x8847",
	"mpls_label":"3",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"pop_mpls=0x0800,output=4"
}
# Tunnel 2 from h4 to h7
# H4 -> S5 -> S6 -> S7 -> H7
Entity16={
	"switch":"00:00:00:00:00:00:00:05",
	"name":"Entity16",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.04",
	"ipv4_dst":"10.0.0.07",
	"ip_tos":"4",
	"priority":"32768",
	"in_port":"4",
	"active":"true",
	"actions":"push_mpls=0x8847,set_field=mpls_label->4,output=2"
}
Entity17={
	"switch":"00:00:00:00:00:00:00:06",
	"name":"Entity17",
	"eth_type":"0x8847",
	"mpls_label":"4",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->4,output=2"
}
Entity18={
	"switch":"00:00:00:00:00:00:00:07",
	"name":"Entity18",
	"eth_type":"0x8847",
	"mpls_label":"4",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"pop_mpls=0x0800,output=4"
}
# -------------------------------------------------------------------
# Tunnel 1 from h8 to h11
# H8 -> S9 -> S10 -> S11 -> S12 -> S13 -> H11
Entity19={
	"switch":"00:00:00:00:00:00:00:09",
	"name":"Entity19",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.08",
	"ipv4_dst":"10.0.0.11",
	"ip_tos":"5",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"push_mpls=0x8847,set_field=mpls_label->5,output=2"
}
Entity20={
	"switch":"00:00:00:00:00:00:00:0a",
	"name":"Entity20",
	"eth_type":"0x8847",
	"mpls_label":"5",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->5,output=3"
}
Entity21={
	"switch":"00:00:00:00:00:00:00:0b",
	"name":"Entity21",
	"eth_type":"0x8847",
	"mpls_label":"5",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->5,output=2"
}
Entity22={
	"switch":"00:00:00:00:00:00:00:0c",
	"name":"Entity22",
	"eth_type":"0x8847",
	"mpls_label":"5",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->5,output=2"
}
Entity23={
	"switch":"00:00:00:00:00:00:00:0d",
	"name":"Entity23",
	"eth_type":"0x8847",
	"mpls_label":"5",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"pop_mpls=0x0800,output=3"
}
# Tunnel 2 from h8 to h11
# H8 -> S9 -> S8 -> S7 -> S5 -> S4 -> S3 -> S1 -> S2 -> S13 -> H11
Entity24={
	"switch":"00:00:00:00:00:00:00:09",
	"name":"Entity24",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.08",
	"ipv4_dst":"10.0.0.11",
	"ip_tos":"6",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"push_mpls=0x8847,set_field=mpls_label->6,output=1"
}
Entity25={
	"switch":"00:00:00:00:00:00:00:08",
	"name":"Entity25",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=1"
}
Entity26={
	"switch":"00:00:00:00:00:00:00:07",
	"name":"Entity26",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=1"
}
Entity27={
	"switch":"00:00:00:00:00:00:00:05",
	"name":"Entity27",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=1"
}
Entity28={
	"switch":"00:00:00:00:00:00:00:04",
	"name":"Entity28",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=1"
}
Entity29={
	"switch":"00:00:00:00:00:00:00:03",
	"name":"Entity29",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=1"
}
Entity30={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity30",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=1"
}
Entity31={
	"switch":"00:00:00:00:00:00:00:02",
	"name":"Entity31",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"set_field=mpls_label->6,output=2"
}
Entity32={
	"switch":"00:00:00:00:00:00:00:0d",
	"name":"Entity32",
	"eth_type":"0x8847",
	"mpls_label":"6",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"pop_mpls=0x0800,output=3"
}
# -------------------------------------------------------------------
pusher.Set(Entity1)
pusher.Set(Entity2)
pusher.Set(Entity3)
pusher.Set(Entity4)
pusher.Set(Entity5)
pusher.Set(Entity6)
pusher.Set(Entity7)
pusher.Set(Entity8)
pusher.Set(Entity9)
pusher.Set(Entity10)
pusher.Set(Entity11)
pusher.Set(Entity12)
pusher.Set(Entity13)
pusher.Set(Entity14)
pusher.Set(Entity15)
pusher.Set(Entity16)
pusher.Set(Entity17)
pusher.Set(Entity18)
pusher.Set(Entity19)
pusher.Set(Entity20)
pusher.Set(Entity21)
pusher.Set(Entity22)
pusher.Set(Entity23)
pusher.Set(Entity24)
pusher.Set(Entity25)
pusher.Set(Entity26)
pusher.Set(Entity27)
pusher.Set(Entity28)
pusher.Set(Entity29)
pusher.Set(Entity30)
pusher.Set(Entity31)
pusher.Set(Entity32)