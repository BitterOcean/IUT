function [J]=hw2_hide(I,logo,L)
[x,y]=size(I);
logo=imresize(logo,[x,y]);
K=dither(logo);
for i=1:x
    for j=1:y
        J(i,j)=bitset(I(i,j),L,K(i,j));
    end
end
covered=bitget(J,L);
figure ,imshow(K),title('dither image');
figure ,imshow(J),title('watermarked image');
figure ,imshow(covered,[]),title('bitget form watermarked image');
