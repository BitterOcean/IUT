n , k = input().split()
n , k = int(n) , int(k)

def makeArray(l,r,a): 
	global k
	if k < 1 or l + 1 == r: 
		return

	k -= 2
	mid = (l + r) // 2

	a[mid - 1] , a[mid] = a[mid] , a[mid - 1]

	makeArray(l, mid, a)
	makeArray(mid, r, a)

def arrayWithKCalls(n):
	global k
	if (k % 2 == 0): 
		print("-1",end="") 
		return
	
	a = [i+1 for i in range(n)] 

	k -= 1
	makeArray(0, n, a) 

	for i in range(n-1): 
		print(a[i]," ",end="")
	print(a[n-1],end="")

arrayWithKCalls(n) 
