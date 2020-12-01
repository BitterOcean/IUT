"""
Project2 Question3 Flow Table Entries

Author : Maryam Saeedmehr
Std. NO. : 9629373

* How to establish it?
Just Run:

~$ python Q3_entity.py

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

# route from h2 to h8
# H2 -> S1 -> S4 -> S8 -> H8
Entity1={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity1",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"5",
	"active":"true",
	"actions":"output=3"
}
Entity2={
	"switch":"00:00:00:00:00:00:00:04",
	"name":"Entity2",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}
Entity3={
	"switch":"00:00:00:00:00:00:00:08",
	"name":"Entity3",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}

# route from h2 to h9
# H2 -> S1 -> S4 -> S9 -> H9
Entity4={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity4",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.09",
	"priority":"32768",
	"in_port":"5",
	"active":"true",
	"actions":"output=3"
}
Entity5={
	"switch":"00:00:00:00:00:00:00:04",
	"name":"Entity5",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.09",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=3"
}
Entity6={
	"switch":"00:00:00:00:00:00:00:09",
	"name":"Entity6",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.09",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}

# route from h2 to h7
# H2 -> S1 -> S3 -> S7 -> H7
Entity7={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity7",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.07",
	"priority":"32768",
	"in_port":"5",
	"active":"true",
	"actions":"output=2"
}
Entity8={
	"switch":"00:00:00:00:00:00:00:03",
	"name":"Entity8",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.07",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}
Entity9={
	"switch":"00:00:00:00:00:00:00:07",
	"name":"Entity9",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.02",
	"ipv4_dst":"10.0.0.07",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=3"
}

# route from h1 to h5
# H1 -> S1 -> S2 -> S6 -> H5
Entity10={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity10",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.05",
	"priority":"32768",
	"in_port":"4",
	"active":"true",
	"actions":"output=1"
}
Entity11={
	"switch":"00:00:00:00:00:00:00:02",
	"name":"Entity11",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.05",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=3"
}
Entity12={
	"switch":"00:00:00:00:00:00:00:06",
	"name":"Entity12",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.05",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}

# route from h1 to h12
# H1 -> S1 -> S2 -> S5 -> S11 -> H12
Entity13={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity13",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.12",
	"priority":"32768",
	"in_port":"4",
	"active":"true",
	"actions":"output=1"
}
Entity14={
	"switch":"00:00:00:00:00:00:00:02",
	"name":"Entity14",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.12",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}
Entity15={
	"switch":"00:00:00:00:00:00:00:05",
	"name":"Entity15",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.12",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}
Entity16={
	"switch":"00:00:00:00:00:00:00:0b",
	"name":"Entity16",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.12",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}

# route from h1 to h14
# H1 -> S1 -> S2 -> S5 -> S12 -> H15
Entity17={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity17",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.14",
	"priority":"32768",
	"in_port":"4",
	"active":"true",
	"actions":"output=1"
}
Entity18={
	"switch":"00:00:00:00:00:00:00:02",
	"name":"Entity18",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.14",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}
Entity19={
	"switch":"00:00:00:00:00:00:00:05",
	"name":"Entity19",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.14",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=3"
}
Entity20={
	"switch":"00:00:00:00:00:00:00:0c",
	"name":"Entity20",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.01",
	"ipv4_dst":"10.0.0.14",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}

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
