import os.path
import pymysql
import tornado.escape
import tornado.httpserver
import tornado.ioloop
import tornado.options
import os
from binascii import hexlify
import tornado.web
from tornado.options import define, options
from time import gmtime, strftime
pymysql.install_as_MySQLdb()

define("port", default=1100, help="run on the given port", type=int)
define("mysql_host", default="127.0.0.1", help="database host")
define("mysql_port", default="3306", help="database port")
define("mysql_database", default="tickets", help="database name")
define("mysql_user", default="maryam", help="database user")
define("mysql_password", default="7731", help="database password")

database = pymysql.connect(
            host=options.mysql_host,
            db=options.mysql_database,
            user=options.mysql_user,
            passwd=options.mysql_password
        )
db = database.cursor(pymysql.cursors.DictCursor)

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            # GET METHOD :
            (r"/signup/([^/]+)/([^/]+)/([^/]+)/([^/]+)/([^/]+)", signup),  # http://localhost/signup?username=amirmnoohi&password=1104&role=normal
            (r"/signup/([^/]+)/([^/]+)/([^/]+)", signup),  # http://localhost/signup?username=amirmnoohi&password=1104&role=normal&firstname=amirm&lastname=noohi
            (r"/login/([^/]+)/([^/]+)", login),  # http://api.softserver.org:1104/login?username=amirmnoohi&password=1104
            (r"/logout/([^/]+)/([^/]+)", logout),  # http://api.softserver.org:1104/logout?username=amirmnoohi&password=1104
            (r"/sendticket/([^/]+)/([^/]+)/([^/]+)", sendticket),  # http://localhost/sendticket?token=7a3c48f7c7939b7269d01443a431825f&subject=network&body=Hi How Are You?
            (r"/getticketcli/([^/]+)", getticketcli),  # http://localhost/getticketcli?token=7a3c48f7c7939b7269d01443a431825f
            (r"/closeticket/([^/]+)/([^/]+)", closeticket),  # http://localhost/closeticket?token=7a3c48f7c7939b7269d01443a431825f&id=1
            (r"/getticketmod/([^/]+)", getticketmod),   # http://localhost/getticketmod?token=7a3c48f7c7939b7269d01443a431825f
            (r"/restoticketmod/([^/]+)/([^/]+)/([^/]+)", restoticketmod),  # http://localhost/restoticketmod?token=7a3c48f7c7939b7269d01443a431825f&id=1&body=where Are You?
            (r"/changestatus/([^/]+)/([^/]+)/([^/]+)", changestatus),  # http://localhost/changestatus?token=7a3c48f7c7939b7269d01443a431825f&id=1&status=in progress
            (r"/isnull/([^/]+)", isnull),
            (r"/authcheck/([^/]+)", authcheck),
            # POST METHOD :
            (r"/signup", signup),  # http://localhost/signup
            (r"/login", login),  # http://api.softserver.org:1104/login
            (r"/logout", logout),  # http://api.softserver.org:1104/logout
            (r"/sendticket", sendticket),  # http://localhost/sendticket
            (r"/getticketcli", getticketcli),  # http://localhost/getticketcli
            (r"/closeticket", closeticket),  # http://localhost/closeticket
            (r"/getticketmod", getticketmod),  # http://localhost/getticketmod
            (r"/restoticketmod", restoticketmod),  # http://localhost/restoticketmod
            (r"/changestatus", changestatus),  # http://localhost/changestatus
            (r"/isnull", isnull),
            (r"/authcheck", authcheck),
            # OTHER
            (r".*", defaulthandler),
        ]
        settings = dict()
        super(Application, self).__init__(handlers, **settings)

class BaseHandler(tornado.web.RequestHandler):
    @staticmethod
    def check_user(user):
        resuser = db.execute("SELECT * from users where username = %s", (user,))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_api(token):
        resuser = db.execute("SELECT * from users where api = %s", (token,))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_auth(username, password):
        resuser = db.execute("SELECT * from users where username = %s and password = %s", (username, password,))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_user_status_api(token):
        resuser = db.execute("SELECT * from users where api = %s and status = %s", (token, "on",))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_user_status_username(user):
        resuser = db.execute("SELECT * from users where username = %s and status = %s", (user, "on",))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_IsBoss(token):
        resuser = db.execute("SELECT * from users where api = %s and role = %s", (token, "boss",))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_ticket_id(i):
        resuser = db.execute("SELECT * from ticket where id = %s", (i,))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_ticket_status(status):
        if status == "open" or status == "close" or status == "waiting":
            return True
        else:
            return False

    @staticmethod
    def check_ticket_IsClose(i):
        resuser = db.execute("SELECT * from ticket where id = %s and status = %s", (i, "close"))
        if resuser:
            return True
        else:
            return False

    @staticmethod
    def check_IsYourTicket(i, t):
        resuser = db.execute("SELECT * from ticket where id = %s and api = %s", (i, t,))
        if resuser:
            return True
        else:
            return False

    def user_format(self):
        db.execute("UPDATE users set username = SUBSTRING(username,\
                    CASE WHEN LEFT(username, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(username) - CASE WHEN LEFT(username, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(username, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE users set password = SUBSTRING(password,\
                    CASE WHEN LEFT(password, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(password) - CASE WHEN LEFT(password, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(password, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE users set role = SUBSTRING(role,\
                    CASE WHEN LEFT(role, 1) = '''' THEN 2 ELSE 1 END, \
                       LENGTH(role) - CASE WHEN LEFT(role, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(role, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE users set api = SUBSTRING(api,\
                    CASE WHEN LEFT(api, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(api) - CASE WHEN LEFT(api, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(api, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE users set api = SUBSTRING(api,\
                            CASE WHEN LEFT(api, 1) = 'b' THEN 2 ELSE 1 END, \
                           LENGTH(api) - CASE WHEN LEFT(api, 1) = 'b' \
                           THEN 1 ELSE 0 END )")

        db.execute("UPDATE users set api = SUBSTRING(api,\
                            CASE WHEN LEFT(api, 1) = '''' THEN 2 ELSE 1 END, \
                           LENGTH(api) - CASE WHEN LEFT(api, 1) = '''' \
                           THEN 1 ELSE 0 END - CASE WHEN RIGHT(api, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE users set status = SUBSTRING(status,\
                    CASE WHEN LEFT(status, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(status) - CASE WHEN LEFT(status, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(status, 1) = '''' THEN 1 ELSE 0  END)")

        database.commit()

    def ticket_format(self):
        db.execute("UPDATE ticket set api = SUBSTRING(api,\
                    CASE WHEN LEFT(api, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(api) - CASE WHEN LEFT(api, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(api, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE ticket set subject = SUBSTRING(subject,\
                    CASE WHEN LEFT(subject, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(subject) - CASE WHEN LEFT(subject, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(subject, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE ticket set body = SUBSTRING(body,\
                    CASE WHEN LEFT(body, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(body) - CASE WHEN LEFT(body, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(body, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE ticket set status = SUBSTRING(status,\
                    CASE WHEN LEFT(status, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(status) - CASE WHEN LEFT(status, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(status, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE ticket set date = SUBSTRING(date,\
                    CASE WHEN LEFT(date, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(date) - CASE WHEN LEFT(date, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(date, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE ticket set res_body = SUBSTRING(res_body,\
                    CASE WHEN LEFT(res_body, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(res_body) - CASE WHEN LEFT(res_body, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(res_body, 1) = '''' THEN 1 ELSE 0  END)")

        db.execute("UPDATE ticket set res_date = SUBSTRING(res_date,\
                    CASE WHEN LEFT(res_date, 1) = '''' THEN 2 ELSE 1 END, \
                   LENGTH(res_date) - CASE WHEN LEFT(res_date, 1) = '''' \
                   THEN 1 ELSE 0 END - CASE WHEN RIGHT(res_date, 1) = '''' THEN 1 ELSE 0  END)")

        database.commit()

class defaulthandler(BaseHandler):
    def get(self):
        output = {"message": "Wrong Command", "code": "404"}
        self.write(output)

    def post(self, *args, **kwargs):
        output = {"message": "Wrong Command", "code": "404"}
        self.write(output)

class signup(BaseHandler):
    def get(self, *args):
        if not self.check_user(args[0]):
            api_token = str(hexlify(os.urandom(16)))
            db.execute('''INSERT INTO users (role, username, password, status, api) 
                        VALUES 
                        ("%s", "%s", "%s", "%s", "%s")''',
                    (args[2], args[0], args[1], "off", api_token))

            database.commit()
            self.user_format()
            output = {
                        "message": "Signed Up Successfully",
                        "code": "200"
            }
            self.write(output)
        else:
            output = {
                "message": "User Exist",
                "code": "203"
            }
            self.write(output)

    def post(self, *args, **kwargs):
        username = self.get_argument('username')
        password = self.get_argument('password')
        role = self.get_argument('role')
        if not self.check_user(username):
            api_token = str(hexlify(os.urandom(16)))
            db.execute('''INSERT INTO users (role, username, password, status, api)
                 VALUES ("%s", "%s", "%s", "%s", "%s")''',
                (role, username, password, "off", api_token))

            database.commit()
            self.user_format()
            output = {
                "message": "Signed Up Successfully",
                "code": "200"
            }
            self.write(output)
        else:
            output = {
                "message": "User Exist",
                "code": "203"
            }
            self.write(output)

class login(BaseHandler):
    def get(self, *args):
        if self.check_auth(args[0], args[1]):
            db.execute("SELECT * from users where username = %s and password = %s", (args[0], args[1],))
            user = db.fetchall()
            db.execute("UPDATE users set status = %s where username = %s", ("on", args[0],))
            database.commit()
            output = {
                "message": "Logged in Successfully",
                "code": "200",
                "token": user[0]["api"]
                }
            self.write(output)
        else:
            output = {
                "message": "Wrong Username or password",
                "code": "203"
            }
            self.write(output)

    def post(self, *args, **kwargs):
        username = self.get_argument('username')
        password = self.get_argument('password')
        if self.check_auth(username, password):
            db.execute("SELECT * from users where username = %s and password = %s", (username, password,))
            user = db.fetchall()
            db.execute("UPDATE users set status = %s where username = %s", ("on", username,))
            database.commit()
            output = {
                "message": "Logged in Successfully",
                "code": "200",
                "token": user[0]["api"]
                }
            self.write(output)
        else:
            output = {
                "message": "Wrong Username or password",
                "code": "203"
            }
            self.write(output)

class logout(BaseHandler):
    def get(self, *args):
        if self.check_auth(args[0], args[1]):
            if self.check_user_status_username(args[0]):
                db.execute("UPDATE users set status = %s where username = %s", ("off", args[0],))
                database.commit()
                output = {
                    "message": "Logged Out Successfully",
                    "code": "200"
                }
                self.write(output)
            else:
                output = {
                    "message": "You Were Not Logged In Before",
                    "code": "203"
                }
                self.write(output)
        else:
            output = {
                "message": "Wrong Username or password",
                "code": "203"
            }
            self.write(output)

    def post(self, *args, **kwargs):
        username = self.get_argument('username')
        password = self.get_argument('password')
        if self.check_auth(username, password):
            if self.check_user_status_username(username):
                db.execute("UPDATE users set status = %s where username = %s", ("off", username,))
                database.commit()
                output = {
                    "message": "Logged Out Successfully",
                    "code": "200"
                }
                self.write(output)
            else:
                output = {
                    "message": "You Were Not Logged In Before",
                    "code": "203"
                }
                self.write(output)
        else:
            output = {
                "message": "Wrong Username or password",
                "code": "203"
            }
            self.write(output)

class sendticket(BaseHandler):
    def get(self, *args):
        if self.check_api(args[0]) and self.check_user_status_api(args[0]):
            date = str(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
            db.execute(
                '''INSERT INTO ticket (api, subject, body, status, date)
                values (%s,%s,%s,%s,%s) ''',
                (args[0], args[1], args[2], "open", date))
            database.commit()
            self.ticket_format()
            db.execute("SELECT * from ticket where api = %s and date = %s", (args[0], date,))
            ticket_id = db.fetchall()
            output = {
                "message": "Ticket Sent Successfully",
                "id": ticket_id[0]["id"],
                "code": "200"
            }
            self.write(output)
        elif self.check_api(args[0]):
            output = {"message": "This User Is Not Logged In", "code": "404"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

    def post(self,  *args, **kwargs):
        token = self.get_argument('token')
        subject = self.get_argument('subject')
        body = self.get_argument('body')
        if self.check_api(token) and self.check_user_status_api(token):
            date = str(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
            db.execute(
                '''INSERT INTO ticket (api, subject, body, status, date)
                values (%s,%s,%s,%s,%s)''',
                (token, subject, body, "open", date))

            database.commit()
            self.ticket_format()
            db.execute("SELECT * from ticket where api = %s and date = %s", (token, date,))
            ticket_id = db.fetchall()
            output = {
                "message": "Ticket Sent Successfully",
                "id": ticket_id[0]["id"],
                "code": "200"
            }
            self.write(output)
        elif self.check_api(token):
            output = {"message": "This User Is Not Logged In", "code": "404"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

class getticketcli(BaseHandler):
    def get(self, *args):
        if self.check_api(args[0]) and self.check_user_status_api(args[0]):
            db.execute("SELECT * from ticket where api = %s", (args[0],))
            res = db.fetchall()
            output = {"tickets": "There Are -" + str(len(res)) + "- Ticket", "code": "200"}
            for i in range(len(res)):
                output['block ' + str(i)] = res[i]
                del(output['block ' + str(i)]["api"])
            self.write(output)
        elif self.check_api(args[0]):
            output = {"message": "This User Is Not Logged In", "code": "404"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)
    def post(self, *args, **kwargs):
        token = self.get_argument('token')
        if self.check_api(token) and self.check_user_status_api(token):
            db.execute("SELECT * from ticket where api = %s", (token,))
            res = db.fetchall()
            output = {"tickets": "There Are -" + str(len(res)) + "- Ticket", "code": "200"}
            for i in range(len(res)):
                output['block ' + str(i)] = res[i]
                del (output['block ' + str(i)]['api'])
            self.write(output)
        elif self.check_api(token):
            output = {"message": "This User Is Not Logged In", "code": "404"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

class closeticket(BaseHandler):
    def get(self, *args):
        if self.check_api(args[0]):
            if self.check_ticket_id(args[1]):
                if self.check_IsYourTicket(args[1], args[0]):
                    db.execute("UPDATE ticket set status = %s where id = %s", ("close", int(args[1]),))
                    database.commit()
                    output = {"message": "Ticket With id -" + args[1] + "- Closed Successfully", "code": "200"}
                    self.write(output)
                else:
                    output = {"message": "Ticket With id -" + args[1] + "- Is Not Yours", "code": "203"}
                    self.write(output)
            else:
                output = {"message": "Ticket With id -" + args[1] + "- Not Found", "code": "404"}
                self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)
    def post(self, *args, **kwargs):
        token = self.get_argument('token')
        id = self.get_argument('id')
        if self.check_api(token):
            if self.check_ticket_id(id):
                if self.check_IsYourTicket(id, token):
                    db.execute("UPDATE ticket set status = %s where id = %s", ("close", int(id),))
                    database.commit()
                    output = {"message": "Ticket With id -" + id + "- Closed Successfully", "code": "200"}
                    self.write(output)
                else:
                    output = {"message": "Ticket With id -" + id + "- Is Not Yours", "code": "203"}
                    self.write(output)
            else:
                output = {"message": "Ticket With id -" + id + "- Not Found", "code": "404"}
                self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

class getticketmod(BaseHandler):
    def get(self, *args):
        if self.check_api(args[0]) and self.check_IsBoss(args[0]):
            db.execute("SELECT * from ticket")
            res = db.fetchall()
            output = {"tickets": "There Are -" + str(len(res)) + "- Ticket", "code": "200"}
            for i in range(len(res)):
                output['block ' + str(i)] = res[i]
                del (output['block ' + str(i)]['api'])
            self.write(output)
        elif self.check_api(args[0]):
            output = {"message": "You Are Not The BOSS", "code": "203"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)
    def post(self, *args, **kwargs):
        token = self.get_argument('token')
        if self.check_api(token) and self.check_user_status_api(token):
            db.execute("SELECT * from ticket")
            res = db.fetchall()
            output = {"tickets": "There Are -" + str(len(res)) + "- Ticket", "code": "200"}
            for i in range(len(res)):
                output['block ' + str(i)] = res[i]
                del (output['block ' + str(i)]['api'])
            self.write(output)
        elif self.check_api(token):
            output = {"message": "You Are Not The BOSS", "code": "203"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

class restoticketmod(BaseHandler):
    def get(self, *args):
        if self.check_api(args[0]) and self.check_IsBoss(args[0]):
            if self.check_ticket_id(args[1]) and not self.check_ticket_IsClose(args[1]):
                date = str(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
                db.execute("UPDATE ticket set res_body = %s where id = %s", (args[2], int(args[1]),))
                db.execute("UPDATE ticket set res_date = %s where id = %s", (date, int(args[1]),))
                db.execute("UPDATE ticket set status = %s where id = %s", ("close", int(args[1]),))
                database.commit()
                output = {"message": "Response to Ticket With id -" + args[1] + "- Sent Successfully", "code": "200"}
                self.write(output)
            elif self.check_ticket_id(args[1]):
                output = {"message": "Ticket With id -" + args[1] + "- Is Closed Before", "code": "203"}
                self.write(output)
            else:
                output = {"message": "Ticket With id -" + args[1] + "- Not Found", "code": "404"}
                self.write(output)
        elif self.check_api(args[0]):
            output = {"message": "You Are Not The BOSS", "code": "203"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

    def post(self, *args, **kwargs):
        token = self.get_argument('token')
        id = self.get_argument('id')
        body = self.get_argument('body')
        if self.check_api(token) and self.check_IsBoss(token):
            if self.check_ticket_id(id) and not self.check_ticket_IsClose(id):
                date = str(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
                db.execute("UPDATE ticket set res_body = %s where id = %s", (body, int(id),))
                db.execute("UPDATE ticket set res_date = %s where id = %s", (date, int(id),))
                db.execute("UPDATE ticket set status = %s where id = %s", ("close", int(id),))
                database.commit()
                output = {"message": "Response to Ticket With id -" + id + "- Sent Successfully", "code": "200"}
                self.write(output)
            elif self.check_ticket_id(id):
                output = {"message": "Response to Ticket With id -" + id + "- Is Closed Before", "code": "203"}
                self.write(output)
            else:
                output = {"message": "Ticket With id -" + id + "- Not Found", "code": "404"}
                self.write(output)
        elif self.check_api(token):
            output = {"message": "You Are Not The BOSS", "code": "203"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

class changestatus(BaseHandler):
    def get(self, *args):
        if self.check_api(args[0]) and self.check_IsBoss(args[0]):
            if self.check_ticket_id(args[1]):
                if self.check_ticket_status(args[2]):
                    db.execute("UPDATE ticket set status = %s where id = %s", (args[2], int(args[1]),))
                    database.commit()
                    output = {"message": "Status Ticket With id -" + args[1] + "- Changed Successfully", "code": "200"}
                    self.write(output)
                else:
                    output = {"message": "Bad Status", "code": "503"}
                    self.write(output)
            else:
                output = {"message": "Ticket With id -" + args[1] + "- Not Found", "code": "404"}
                self.write(output)
        elif self.check_api(args[0]):
            output = {"message": "You Are Not The BOSS", "code": "203"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)
    def post(self, *args, **kwargs):
        token = self.get_argument('token')
        id = self.get_argument('id')
        status = self.get_argument('status')
        if self.check_api(token) and self.check_IsBoss(token):
            if self.check_ticket_id(id):
                if self.check_ticket_status(status):
                    db.execute("UPDATE ticket set status = %s where id = %s", (status, int(id),))
                    database.commit()
                    output = {"message": "Status Ticket With id -" + id + "- Changed Successfully", "code": "200"}
                    self.write(output)
                else:
                    output = {"message": "Bad Status", "code": "503"}
                    self.write(output)
            else:
                output = {"message": "Ticket With id -" + id + "- Not Found", "code": "404"}
                self.write(output)
        elif self.check_api(token):
            output = {"message": "You Are Not The BOSS", "code": "203"}
            self.write(output)
        else:
            output = {"message": "This Token Is Not Valid", "code": "203"}
            self.write(output)

class isnull(BaseHandler):
    def get(self, *args):
        if self.check_ticket_id(args[0]):
            res = db.execute("SELECT * from ticket where id = %s and res_body is null ", (args[0],))
            if res:
                output = {"status": "True"}
                self.write(output)
            else:
                output = {"status": "False"}
                self.write(output)
    def post(self, *args, **kwargs):
        id = self.get_argument('id')
        if self.check_ticket_id(id):
            res = db.execute("SELECT * from ticket where id = %s and res_body is null ", (id,))
            if res:
                output = {"status": "True"}
                self.write(output)
            else:
                output = {"status": "False"}
                self.write(output)

class authcheck(BaseHandler):
    def get(self, *args):
        res = db.execute("SELECT * from users where api = %s and role = %s", (args[0], "boss",))
        if res:
            output = {"status": "True"}
            self.write(output)
        else:
            output = {"status": "False"}
            self.write(output)
    def post(self, *args, **kwargs):
        token = self.get_argument('token')
        res = db.execute("SELECT * from users where api = %s and role = %s ", (token, "boss"))
        if res:
            output = {"status": "True"}
            self.write(output)
        else:
            output = {"status": "False"}
            self.write(output)

def main():
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.current().start()


if __name__ == "__main__":
    main()
