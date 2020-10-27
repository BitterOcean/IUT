function[pad]=hw2_local_histeq(I,n)
[x,y]=size(I);
if mod(x,n)~=0
    pad1=n-mod(x,n);
else
    pad1=0;
end
if mod(y,n)~=0
    pad2=n-mod(y,n);
else
    pad2=0;
end

for i=1:x
    for j=1:y
      pad(i+pad1,j+pad2)=I(i,j);  
    end
end
for i=1:pad1
      pad(i,:)=pad(i+pad1,:);  
end

for j=1:pad2
      pad(:,j)=pad(:,j+pad2);  
end

for i=1:((x+pad1)/n)
    for j=1:((y+pad2)/n)
        [localeq(i:i*n,j:j*n)]=hw2_histeq(pad(i:i*n,j:j*n));
    end
end

for i=1:x
    for j=1:y
      eq(i,j)=localeq(i+pad1,j+pad2);  
    end
end

figure ,imshow(I),title('original image');
figure ,imshow(pad),title('padded image');
figure ,imshow(localeq),title('padded equalized image');
figure ,imshow(eq),title('local equalized image');