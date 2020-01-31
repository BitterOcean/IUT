from __future__ import print_function
import requests
import os
import time
import sys
import platform

CMD = USERNAME = PASSWORD = ROLE = API = ""
HOST = "127.0.0.1"
PORT = "1100"


def __authgetcr__():
    return "http://"+HOST+":"+PORT+"/"+CMD+"/"+USERNAME+"/"+PASSWORD


def __api__():
    return "http://" + HOST + ":" + PORT + "/" + CMD + "/" + API


def __id__(i):
    return "http://" + HOST + ":" + PORT + "/" + "isnull" + "/" + str(i)


def clear():
    if platform.system() == 'Windows':
        os.system('cls')
    else:
        os.system('clear')


def __role_checker__():
    if ROLE == "boss" or ROLE == "normal":
        return True
    else:
        return False


def show_func_boss():
    global CMD, USERNAME, PASSWORD, API
    while True:
        clear()
        print("USERNAME : "+USERNAME+"\n"+"API : " + API)
        print("""What Do You Prefer To Do :
                    1. Send ticket
                    2. Get ticket
                    3. Response to a ticket 
                    4. Change a ticket's status
                    5. Logout
                    6. Exit
                    """)
        state = sys.stdin.readline()
        if state[:-1] == '1':
            clear()
            while True:
                print("Subject : ")
                SUBJECT = sys.stdin.readline()[:-1]
                print("Body : ")
                BODY = sys.stdin.readline()[:-1]
                CMD = "sendticket"
                r1 = requests.get(__api__() + "/" + SUBJECT + "/" + BODY).json()
                if r1["code"] == "200":
                    clear()
                    print("TICKET SENT SUCCESSFULLY...")
                    time.sleep(2)
                else:
                    print(r1["code"] + " " + r1["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '2':
            clear()
            while True:
                CMD = "getticketmod"
                r2 = requests.get(__api__()).json()
                if r2["code"] == "200":
                    newstr = ''.join((ch if ch in '0123456789' else ' ') for ch in r2["tickets"])
                    tickNum = [int(i) for i in newstr.split()]
                    if tickNum[0]:
                        print(r2["tickets"])
                        print()
                        for i in range(tickNum[0]):
                            ri = requests.get(__id__(r2["block " + str(i)]["id"])).json()
                            print("SUBJECT : ", end=' ')
                            print(r2["block " + str(i)]["subject"])
                            print("ID:", end="")
                            print(r2["block " + str(i)]["id"], end=" ")
                            print("USER : ", end="")
                            print(r2["block " + str(i)]["body"] + "     " + r2["block " + str(i)]["date"], end="    ")
                            print("status : " + r2["block " + str(i)]["status"])
                            if ri["status"] == "False":
                                print("     YOU : ", end="")
                                print(r2["block " + str(i)]["res_body"] + "   " + r2["block " + str(i)]["res_date"])
                            print()
                        print("Press Any Key To Continue ...")
                        sys.stdin.readline(1)
                    else:
                        print("You Have No Ticket Yet")
                        time.sleep(2)
                else:
                    print(r2["code"] + " " + r2["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '3':
            clear()
            while True:
                print("Please enter the id of the ticket you want to response to it : ")
                i = sys.stdin.readline()[:-1]
                print("Body : ")
                BODY = sys.stdin.readline()[:-1]
                CMD = "restoticketmod"
                r1 = requests.get(__api__() + "/" + i + "/" + BODY).json()
                if r1["code"] == "200":
                    clear()
                    print("YOUR RESPONSE TICKET SENT SUCCESSFULLY...")
                    time.sleep(2)
                else:
                    print(r1["code"] + " " + r1["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '4':
            clear()
            while True:
                CMD = "changestatus"
                print("Please enter the id of the ticket you want to change its status : ")
                i = sys.stdin.readline()[:-1]
                print("Status : ")
                s = sys.stdin.readline()[:-1]
                r3 = requests.get(__api__() + "/" + i + "/" + s).json()
                if r3["code"] == "200":
                    print(r3["message"])
                    time.sleep(2)
                else:
                    print(r3["code"] + " " + r3["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '5':
            clear()
            while True:
                print("USERNAME : ")
                USERNAME = sys.stdin.readline()[:-1]
                print("PASSWORD : ")
                PASSWORD = sys.stdin.readline()[:-1]
                CMD = "logout"
                r4 = requests.get(__authgetcr__()).json()
                if r4['code'] == '200':
                    clear()
                    print(r4["message"])
                    time.sleep(2)
                    return
                else:
                    clear()
                    print("USERNAME AND PASSWORD IS INCORRECT\nTRY AGAIN ...")
                    time.sleep(2)
                break
        elif state[:-1] == '6':
            return
        else:
            print("Wrong Choose Try Again")


def show_func_normal():
    global CMD, USERNAME, PASSWORD, API
    while True:
        clear()
        print("USERNAME : " + USERNAME + "\n" + "API : " + API)
        print("""What Do You Prefer To Do :
                        1. Send ticket
                        2. Get ticket
                        3. Close a ticket
                        4. Logout
                        5. Exit
                        """)
        state = sys.stdin.readline()
        if state[:-1] == '1':
            clear()
            while True:
                print("Subject : ")
                SUBJECT = sys.stdin.readline()[:-1]
                print("Body : ")
                BODY = sys.stdin.readline()[:-1]
                CMD = "sendticket"
                r1 = requests.get(__api__() + "/" + SUBJECT + "/" + BODY).json()
                if r1["code"] == "200":
                    clear()
                    print("TICKET SENT SUCCESSFULLY...")
                    time.sleep(2)
                else:
                    print(r1["code"] + " " + r1["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '2':
            clear()
            while True:
                CMD = "getticketcli"
                r2 = requests.get(__api__()).json()
                if r2["code"] == "200":
                    newstr = ''.join((ch if ch in '0123456789' else ' ') for ch in r2["tickets"])
                    tickNum = [int(i) for i in newstr.split()]
                    if tickNum[0]:
                        print(r2["tickets"])
                        print()
                        for i in range(tickNum[0]):
                            ri = requests.get(__id__(r2["block " + str(i)]["id"])).json()
                            print("SUBJECT : ", end=' ')
                            print(r2["block " + str(i)]["subject"])
                            print("ID:", end="")
                            print(r2["block " + str(i)]["id"], end=" ")
                            print("YOU : ", end="")
                            print(r2["block " + str(i)]["body"] + "     " + r2["block " + str(i)]["date"], end="    ")
                            print("status : " + r2["block " + str(i)]["status"])
                            if ri["status"] == "False":
                                print("     BOSS : ", end="")
                                print(r2["block " + str(i)]["res_body"] + "   " + r2["block " + str(i)]["res_date"])
                            print()
                        print("Press Any Key To Continue ...")
                        sys.stdin.readline(1)
                    else:
                        print("You Have No Ticket Yet")
                        time.sleep(2)
                else:
                    print(r2["code"] + " " + r2["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '3':
            clear()
            while True:
                CMD = "closeticket"
                print("Please enter the id of the ticket you want to close it : ")
                i = sys.stdin.readline()[:-1]
                r3 = requests.get(__api__() + "/" + i).json()
                if r3["code"] == "200":
                    print(r3["message"])
                    time.sleep(2)
                else:
                    print(r3["code"] + " " + r3["message"])
                    time.sleep(2)
                break
        elif state[:-1] == '4':
            clear()
            while True:
                print("USERNAME : ")
                USERNAME = sys.stdin.readline()[:-1]
                print("PASSWORD : ")
                PASSWORD = sys.stdin.readline()[:-1]
                CMD = "logout"
                r4 = requests.get(__authgetcr__()).json()
                if r4['code'] == '200':
                    clear()
                    print(r4["message"])
                    time.sleep(2)
                    return
                else:
                    clear()
                    print("USERNAME AND PASSWORD IS INCORRECT\nTRY AGAIN ...")
                    time.sleep(2)
                break
        elif state[:-1] == '5':
            return
        else:
            print("Wrong Choose Try Again")


def main():
    global CMD, USERNAME, PASSWORD, API, ROLE
    while True:
        clear()
        print("""WELCOME TO Our SUPPORTING SYSTEM
          Please Choose What You Want To Do :
          1. signin
          2. signup
          3. exit
          """)
        status = sys.stdin.readline()
        if status[:-1] == '1':
            clear()
            while True:
                print("USERNAME : ")
                USERNAME = sys.stdin.readline()[:-1]
                print("PASSWORD : ")
                PASSWORD = sys.stdin.readline()[:-1]
                CMD = "login"
                r = requests.get(__authgetcr__()).json()
                if r["code"] == "200":
                    clear()
                    print("USERNAME AND PASSWORD IS CORRECT\nLogging You in ...")
                    API = r['token']
                    CMD = "authcheck"
                    role = requests.get(__api__()).json()
                    if role["status"] == "True":
                        show_func_boss()
                    else:
                        show_func_normal()
                    break
                else:
                    clear()
                    print("USERNAME AND PASSWORD IS INCORRECT\nTRY AGAIN ...")
                    time.sleep(2)

        elif status[:-1] == '2':
            clear()
            while True:
                print("To Create New Account Enter The Authentication")
                print("USERNAME : ")
                USERNAME = sys.stdin.readline()[:-1]
                print("PASSWORD : ")
                PASSWORD = sys.stdin.readline()[:-1]
                print("ROLE (boss/normal): ")
                ROLE = sys.stdin.readline()[:-1]
                while not __role_checker__():
                    print("""Wrong Input!
                              Try Again...
                            """)
                    print("ROLE (boss/normal): ")
                    ROLE = sys.stdin.readline()[:-1]
                CMD = "signup"
                clear()
                r = requests.get(__authgetcr__() + "/" + ROLE).json()
                if str(r["code"]) == "200":
                    print("Your Acount Is Created\n" + "Your Username :" + USERNAME + "\nYour Password : " + PASSWORD)
                    print("Press Any Key To Continue ...")
                    sys.stdin.readline(1)
                    break
                else:
                    print(r['code'] + " " + r['message'] + "\n" + "Try Again")
                    print("Press Any Key To Continue ...")
                    sys.stdin.readline(1)
                    clear()

        elif status[:-1] == '3':
            sys.exit()

        else:
            print("Wrong Choose Try Again")


if __name__ == "__main__":
    main()
