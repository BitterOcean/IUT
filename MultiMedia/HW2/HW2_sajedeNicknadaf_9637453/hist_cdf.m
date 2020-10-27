function[CDF]=hist_cdf(I)
[m,n]=size(I);
h=[1:256];
y=zeros(256);
for i=1:m
    for j=1:n
       y(I(i,j)+1)=y(I(i,j)+1)+1;
    end
end

CDF=zeros(256);
CDF(1)=y(1);
for i=2:256
    CDF(i)=CDF(i-1)+y(i);
end
CDF=CDF/(m*n);
%for q3 comment this plots 
%figure ,plot(h,y),title('PDF');
%figure ,plot(h,CDF),title('CDF');