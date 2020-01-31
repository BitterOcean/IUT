#include<iostream>
using namespace std;

int maxSubArraySum(int a[], int size)
{
	int max_so_far = 0, max_ending_here = 0;
	for (int i = 0; i < size; i++)
	{
		max_ending_here = max_ending_here + a[i];
		if (max_ending_here < 0)
			max_ending_here = 0;

		/* Do not compare for all elements. Compare only
		   when  max_ending_here > 0 */
		else if (max_so_far < max_ending_here)
			max_so_far = max_ending_here;
	}
	return max_so_far;
}


int main() 
{
	int n;
	cin >> n;
	int* a;
	a = new int[n];
	while (n != 0) 
	{
		for (int i = 0; i < n; i++)
			cin >> a[i];
		int res = maxSubArraySum(a, n);
		if (res != 0)
			cout << "The maximum winning streak is " << res << ".\n";
		else
			cout << "Losing streak.\n";
		cin >>  n;
	}
	return 0;
}
