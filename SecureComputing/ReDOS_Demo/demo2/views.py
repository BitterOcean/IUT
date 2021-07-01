from django.shortcuts import render
from django.http import JsonResponse
import time
import re

def demo2(request, username, password):
    if request.method == "GET":
        start   = time.time()
        regex   = re.compile(username)
        result  = regex.match(password)
        end     = time.time() - start
        print("\033[94m[+] username    : %s\033[0m" % username)
        print("\033[94m[+] password    : %s\033[0m" % password)
        if result:
            print("\033[93m[!] Match state : \033[0m\033[91mWeak Password\033[0m")
            print("\033[93m[!] Duration    : %f\033[0m" % end)
            return JsonResponse({"status": "Unautherized", "code": 401, "Duration": end})
        print("\033[93m[!] Match state : \033[0m\033[1mStrong Password\033[0m")
        print("\033[93m[!] Duration    : %f\033[0m" % end)
        return JsonResponse({"status": "OK", "code": 200, "Duration": end})
    return JsonResponse({
        "status": "Bad Request",
        "code": 400,
        "message": "You should send me Username and Password with GET method."
    })