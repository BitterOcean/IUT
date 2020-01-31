# Ticketing System


This is Ticketing System using Tornado Web server.

Author : Maryam Saeedmehr

Language : Python Both 2.7 - 3.6.5




# **PreRequirements**

For This Project You Need below Requirements :
- pyhon
- mysql

```shell
$ apt install python mysql
```

# **Requirement**

For runnig code.py file You Need to install below pakcage for python  :

- tornado 
- pymysql


```shell
$ pip install tornado
$ pip install PyMySQL
```

# **install**
## Step0 : Cloning

First of All Clone the Project : 

```shell
$ git clone https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver.git
```

## Step1 : Connect to MySQL and create a database

Connect to MySQL as a user that can create databases and users:

```shell
$ mysql -u root
```
    
Create a database named "tickets":
    
```shell
mysql> CREATE DATABASE tickets;
```
    
Allow the "maryam" user to connect with the password "7731":
    
```shell
mysql> GRANT ALL PRIVILEGES ON tickets.* TO 'maryam'@'localhost' IDENTIFIED BY '7731';
```

## Step2 : Create the tables in your new database

You can use the provided bankdb.sql file by running this command:

```shell
$ mysql --user=maryam --password=7731 --database=tickets < dataBase.sql
```

You can run the above command again later if you want to delete the
contents of the tickets and start over after testing.

Then now you Must Put Database information in code.py from line 13 - 16

## Step3 : Run the Supporting_System project


With the default user, password, and database you can just run:

```shell
$ python code.py
```

# **Usage**

Now For Sending Requests You Have 2 Options :
1. Postman
2. Our Client Code

## POSTMAN :
Download and install <a href="https://www.getpostman.com/apps" target="_blank">**Postman**</a>. 

In our Project We Support Both POST & GET Method for Requesting

You Can See Example Below : 

### GET :


![Server-get](https://user-images.githubusercontent.com/49061503/55613300-a3bd0080-579f-11e9-9c3c-e3ba3ba4c679.gif)



### POST :


![Server-post](https://user-images.githubusercontent.com/49061503/55613678-850b3980-57a0-11e9-9054-2b7ceb01674b.gif)


## OUR CLIENT CODE:

run this in the terminal

```shell 
$ pip3 install requests
$ python3 client-[METHOD].py
```

### GET :


![client-get](https://user-images.githubusercontent.com/49061503/55613796-cbf92f00-57a0-11e9-97b2-402ae3886506.gif)



### POST :


This section is exactly the same as the above.
Obviously they are different in the background. :)

# **Files**

- <a href="https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver/blob/master/dataBase.sql">`/dataBase.sql`</a> : This is Database File
- <a href="https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver/blob/master/server.py">`/server.py`</a> : This is main python File
- <a href="https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver/blob/master/get.pcapng">`/get.pcapng`</a> : Wireshark Full Sniffed Packets for GET method
- <a href="https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver/blob/master/post.pcapng">`/post.pcapng`</a> : Wireshark Filtered Packets for POST method
- <a href="https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver/blob/master/client-get.py">`/client-get.py`</a> : This is Client Code With GET Method
- <a href="https://github.com/MaryamSaeedmehr/TicketingSystem-tornadowebserver/blob/master/client-post.py">`/client-post.py`</a> : This is Client Code With POST Method



# **Support**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
