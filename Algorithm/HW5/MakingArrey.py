LIS = [0]*200
LDS = [0]*200

def assendingOrder(arr, it):
	global LIS
	n = len(arr)-it 
	lis = [0]*n
	lis[0] = 1
	for i in range (1 , n): 
		for j in range(0 , i): 
			if arr[it+i] > arr[it] :
				if lis[j]!=0 and arr[it+i] > arr[it+j] :
					lis[i] = max(lis[j]+1,lis[i])
			else:
				lis[i] = 0
	LIS[it] = max(lis)


def dessendingOrder(arr, it):
	global LDS
	n = len(arr)-it
	lis = [0]*n
	lis[0] = 1
	for i in range (1 , n): 
		for j in range(0 , i): 
			if arr[it+i] < arr[it] :
				if lis[j]!=0 and arr[it+i] < arr[it+j] :
					lis[i] = max(lis[j]+1,lis[i])
			else:
				lis[i] = 0
	LDS[it] = max(lis)


m = int(input())
for i in range(m):
    global LIS
    global LDS
    n = int(input())
    LIS = [0]*n
    LDS = [0]*n
    a = [int(input()) for k in range(n)]
    if n <= 2:
        print(n)
    else:
        for i in range(len(a)-1):
            dessendingOrder(a,i)
            assendingOrder(a,i)

        for i in range(len(a)):
            LIS[i] = LIS[i] + LDS[i]

        print(max(LIS)-1)

