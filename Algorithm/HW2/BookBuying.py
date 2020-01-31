import sys
def printPairs(arr, arr_size, sum): 
    
        s = set() 
        res = [0,10000000000]
        
        for i in range(0,arr_size): 
            temp = sum-arr[i] 
            if (temp>=0 and temp in s): 
                if(res[1]-res[0] >= abs(arr[i]-temp)):
                    res[1] = max(arr[i],temp)
                    res[0] = min(arr[i],temp) 
            s.add(arr[i])
        return res

for line in sys.stdin:
    for N in line.split():
        N = int(N)
        cost = [int(i) for i in input().split()]
        Money = int(input())
    

        result = printPairs(cost,N,Money)
        print('Mohammad should buy books whose prices are '+str(result[0])+' and '+str(result[1])+'.\n')

