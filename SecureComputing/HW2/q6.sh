#!/bin/bash

Command=${1}

if [ $Command == "--run" ]
then
	echo "--------------- Part (A) : find (p, q, n, e, d) -------------"
	openssl rsa -in Private.key -text > ./openssl_rsa_params.txt
	echo "openssl_rsa_params.txt is created"
	openssl pkey -in Private.key -pubout -text > ./openssl_public_key.txt
	echo "openssl_public_key.txt is created"
	echo "--------------- Part (B) : decrypt cipher.txt ---------------"
	cat cipher.txt| base64 -d > ./cipherbase64.txt
	echo "cipherbase64.txt is created"
	openssl rsautl -decrypt -in cipherbase64.txt -out plain.txt -inkey Private.key
	echo "plain.txt is created"
	echo "--------------- Part (C) : encrypt your name ----------------"
	echo "Maryam Saeedmehr" > MyPlainName.txt
	echo "MyPlainName.txt is created"
	openssl rsautl -sign -inkey Private.key -in	MyPlainName.txt -out MyCipherName.txt
	echo "MyCipherName.txt is created"
	cat MyCipherName.txt| base64 > MyCipherName64.txt
	echo "MyCipherName64.txt is created"
elif [ $Command == "--remove" ]
then
	rm openssl_rsa_params.txt openssl_public_key.txt cipherbase64.txt plain.txt MyPlainName.txt MyCipherName.txt MyCipherName64.txt
	echo "All files removed :)"
else
	echo "Unkown command :| "
fi