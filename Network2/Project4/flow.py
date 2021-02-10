"""
Project4 

Author   : Maryam Saeedmehr
Std. NO. : 9629373

* How to establish it?
Just Run:

~$ python flow.py

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
	
	def Put(self,data):
		ret=self.rest_call(data,'PUT')
		return ret[0]==200

	def remove(self,objtype,data):
		ret=self.rest_call(data,'DELETE')
		return ret[0]==200
	
	def rest_call(self,data,action):
		path='restconf/config/opendaylight-inventory:nodes'
		header={
			'Cantent-type':'application/json',
			'Accept':'application/json'
		}
		body=json.dumps(data)
		Conn=httplib.HTTPConnection(self.server,8181)
		Conn.request(action,path,body,header)
		response=Conn.getresponse()
		ret=(response.status,response.reason,response.read())
		print ret
		Conn.close()
		return ret

pusher=StaticEntryPusher('127.0.0.1')

# -------------------------------------------------------------------
# path : Host1 -> openflow1 -> openflow2 -> Host2
flow1={
	"node":"openflow:1",
	"id": "1",
	"table_id": "1",
	"barrier": "false",
	"flow-name": "flow1",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.1/32",
		"ipv4-destination": "10.0.0.3/32",
		"in-port": "1",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "3"
	                }]
	        }
	    }]
	}
}

flow2={
	"node":"openflow:2",
	"id": "2",
	"table_id": "1",
	"barrier": "false",
	"flow-name": "flow2",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.1/32",
		"ipv4-destination": "10.0.0.3/32",
		"in-port": "3",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "2"
	                }]
	        }
	    }]
	}
}

# path : Host1 -> openflow1 -> openflow5 -> openflow3 -> Host5
flow3={
	"node":"openflow:1",
	"id": "3",
	"table_id": "2",
	"barrier": "false",
	"flow-name": "flow3",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.1/32",
		"ipv4-destination": "10.0.0.5/32",
		"in-port": "1",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "2"
	                }]
	        }
	    }]
	}
}

flow4={
	"node":"openflow:5",
	"id": "4",
	"table_id": "1",
	"barrier": "false",
	"flow-name": "flow4",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.1/32",
		"ipv4-destination": "10.0.0.5/32",
		"in-port": "1",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "3"
	                }]
	        }
	    }]
	}
}

flow5={
	"node":"openflow:3",
	"id": "5",
	"table_id": "1",
	"barrier": "false",
	"flow-name": "flow5",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.1/32",
		"ipv4-destination": "10.0.0.5/32",
		"in-port": "5",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "2"
	                }]
	        }
	    }]
	}
}

# path : Host2 -> openflow2 -> openflow3 -> Host4
flow6={
	"node":"openflow:2",
	"id": "6",
	"table_id": "2",
	"barrier": "false",
	"flow-name": "flow6",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.2/32",
		"ipv4-destination": "10.0.0.4/32",
		"in-port": "1",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "4"
	                }]
	        }
	    }]
	}
}

flow7={
	"node":"openflow:3",
	"id": "7",
	"table_id": "2",
	"barrier": "false",
	"flow-name": "flow7",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.2/32",
		"ipv4-destination": "10.0.0.4/32",
		"in-port": "3",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "1"
	                }]
	        }
	    }]
	}
}

# path : Host2 -> openflow2 -> Host3
flow8={
	"node":"openflow:2",
	"id": "8",
	"table_id": "3",
	"barrier": "false",
	"flow-name": "flow8",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.2/32",
		"ipv4-destination": "10.0.0.3/32",
		"in-port": "1",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "2"
	                }]
	        }
	    }]
	}
}

# path : Host4 -> openflow3 -> Host5
flow9={
	"node":"openflow:3",
	"id": "9",
	"table_id": "3",
	"barrier": "false",
	"flow-name": "flow9",
	"strict": "false",
	"idle-timeout": "34",
	"priority": "2",
	"hard-timeout": "12",
	"cookie_mask": "255",
	"match": {
		"ipv4-source": "10.0.0.4/32",
		"ipv4-destination": "10.0.0.5/32",
		"in-port": "1",
		"ethernet-match": {
            "ethernet-type": {
                "type": "2048"
            }
        }
	},
	"cookie": "5",
	"instructions": {
		"instruction": [{
	        "order": "0",
	        "apply-actions": {
	            "action": [{
	                     "output-node-connector": "2"
	                }]
	        }
	    }]
	}
}

# -------------------------------------------------------------------
pusher.Put(flow1)
pusher.Put(flow2)
pusher.Put(flow3)
pusher.Put(flow4)
pusher.Put(flow5)
pusher.Put(flow6)
pusher.Put(flow7)
pusher.Put(flow8)
pusher.Put(flow9)