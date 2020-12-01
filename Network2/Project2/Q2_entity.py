"""
Project2 Question2 Flow Table Entries

Author : Maryam Saeedmehr
Std. NO. : 9629373

* How to establish it?
Just Run:

~$ python Q2_entity.py

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

# route from h9 to h8
# H9 -> S3 -> S1 -> S4 -> S6 -> S7 -> S8 -> H8
Entity1={
	"switch":"00:00:00:00:00:00:00:03",
	"name":"Entity1",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.09",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=2"
}
Entity2={
	"switch":"00:00:00:00:00:00:00:01",
	"name":"Entity2",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.09",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"3",
	"active":"true",
	"actions":"output=4"
}
Entity3={
	"switch":"00:00:00:00:00:00:00:04",
	"name":"Entity3",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.09",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=6"
}
Entity4={
	"switch":"00:00:00:00:00:00:00:06",
	"name":"Entity4",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.09",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"5",
	"active":"true",
	"actions":"output=3"
}
Entity5={
	"switch":"00:00:00:00:00:00:00:07",
	"name":"Entity5",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.09",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"1",
	"active":"true",
	"actions":"output=3"
}
Entity6={
	"switch":"00:00:00:00:00:00:00:08",
	"name":"Entity6",
	"eth_type":"0x0800",
	"ipv4_src":"10.0.0.09",
	"ipv4_dst":"10.0.0.08",
	"priority":"32768",
	"in_port":"2",
	"active":"true",
	"actions":"output=1"
}

pusher.Set(Entity1)
pusher.Set(Entity2)
pusher.Set(Entity3)
pusher.Set(Entity4)
pusher.Set(Entity5)
pusher.Set(Entity6)
