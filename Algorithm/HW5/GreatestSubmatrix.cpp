#include <iostream>
#include<vector>
using namespace std;

int max_size(vector<int> a)
{
	int max,sum;
	max=-127; sum=0; 
	for(int i=0;i<a.size();i++)
	{
		sum+=a[i];
		if(sum>max)
			max=sum;
			
		if(sum<0)
			sum=0;
	}
	return max;
}

int max_sub_matrix(int n){
	int max,fun;
	max=-127;
	int tmp;
	vector<int> tmpvec;
	vector<vector<int> > x;
	for (int i=0;i<n;i++)
	{
		tmpvec.clear();
		
		for (int j=0;j<n;j++)
		{
			cin>>tmp;
			tmpvec.push_back(tmp);
			
		}
		x.push_back(tmpvec);
	}
	///voroode dadeha
	
	for(int k=0;k<n;k++){
		tmpvec.clear();
		for (int i=0;i<n;i++)
			tmpvec.push_back(0);
		
		for (int i=k;i<n;i++)
		{
			for (int j=0;j<n;j++)
				tmpvec[j]+=x[i][j];
			
			fun=max_size(tmpvec);
			if(fun>max)
				max=fun;
		}	
	}
		if(n!=0){
		//	cout<<max;
			return max;
		}
	
}

int main(){
	//cout<<"enter size of your matrix :\n";
	int n;
	cin>>n;
	cout<<max_sub_matrix(n);
	return 0;
}

