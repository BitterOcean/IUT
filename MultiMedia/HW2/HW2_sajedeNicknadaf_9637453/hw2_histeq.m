function[J]=hw2_histeq(I)
[m,n]=size(I);
[CDF]=hist_cdf(I);
for i=1:m
    for j=1:n
      J(i,j)=CDF(I(i,j)+1);  
    end
end
%for q3 comment this imshows
%figure ,imshow(I),title('original image');
%figure ,imshow(J),title('equalized image');
L=im2uint8(J);
hist_cdf(L);
