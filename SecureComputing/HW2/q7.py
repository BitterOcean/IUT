"""
    # Computer Security Course 3992

    # Question 7 ? ------------------------------
        HMAC SHA256
        BLOCK-SIZE=64Byte
        pure python (NOT use hmac,
                     ALLOW using hashlib)

    # How to run it ? ---------------------------
        ~$ python3 q7.py

    # Who am I ? --------------------------------
        Author : Maryam Saeedmehr
        Std.NO : 9629373
"""
import hashlib


def xor(x, y):
    return bytes(x[i] ^ y[i] for i in range(min(len(x), len(y))))


def hmac_sha256(key_K, data):
    if len(key_K) > 64:
        raise ValueError('The key must be <= 64 bytes in length')
    padded_K = key_K + b'\x00' * (64 - len(key_K))
    ipad = b'\x36' * 64
    opad = b'\x5c' * 64
    h_inner = hashlib.sha256(xor(padded_K, ipad))
    h_inner.update(data)
    h_outer = hashlib.sha256(xor(padded_K, opad))
    h_outer.update(h_inner.digest())
    return h_outer.digest()


key = b"security"
message = b"Cryptography is the practice and study of techniques for secure communication"
result = hmac_sha256(key, message)
print(result.hex())
