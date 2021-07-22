"""
    # Computer Security Course 3992

    # Question 4 ? ------------------------------
        RSA cipher decryption

    # How to run it ? ---------------------------
        ~$ pip install sympy
        ~$ pip install pycryptodome
        ~$ python3 q4.py

    # Who am I ? --------------------------------
        Author : Maryam Saeedmehr
        Std.NO : 9629373
"""
from sympy.ntheory import factorint
from Crypto.Util.number import inverse, long_to_bytes

cipher_text = int("""
231319575254249797149103185156267081062545553691852675
282846289476023301930926212128409488137502459205785308
405035663920608325484211325620827296125513253371838541
9499135351324957142526657429040
""".replace("\n", ""))
n = int("""
334968324068330375204010018712324507677580283866812532
578531831500439877858653886621019808357316967344454351
865438503848417711082827464896718583162361040986768993
8609495858551308025785883804091
""".replace("\n", ""))
e = 65537  # public key
p, q = factorint(n).keys()
phi = (1 - p) * (1 - q)
d = inverse(e, phi)  # private key
plain_text = pow(cipher_text, d, n)

print(f'Plain text  : {long_to_bytes(plain_text)}')
