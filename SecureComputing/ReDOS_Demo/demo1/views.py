from django.shortcuts import render
from django.http import JsonResponse
import time
import re

def demo1(request, data):
    if request.method == "GET":
        start   = time.time()
        regex   = re.compile('^(a+)+$')
        result  = regex.match(data)
        end     = time.time() - start
        print("\033[94m[+] InputData   : %s\033[0m" % data)
        if result:
            print("\033[93m[!] Match state : Matched\033[0m")
            print("\033[93m[!] Duration    : %f\033[0m" % end)
            return JsonResponse({"status": "Unautherized", "code": 401, "Duration": end})
        print("\033[93m[!] Match state : Not-Matched\033[0m")
        print("\033[93m[!] Duration    : %f\033[0m" % end)
        return JsonResponse({"status": "OK", "code": 200, "Duration": end})
    return JsonResponse({
        "status": "Bad Request",
        "code": 400,
        "message": "You should send me Data with GET method."
    })