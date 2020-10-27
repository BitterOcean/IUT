clc;
close all;
clear;

Input_image = imread('Hi.tif');
[row, column] = size(Input_image);

% Nearest
Resized_nearest = imresize(Input_image,0.8,'nearest');
Nearest_image = imresize(Resized_nearest,[row, column],'nearest');
subplot(2,3,1),imshow(Resized_nearest),title('Resize 1 : Nearest');
subplot(2,3,4),imshow(Nearest_image),title('Resize 2 : Nearest');
HW1_MSE(Input_image,Nearest_image);
sprintf('Nearest MSE is %f',ans);
disp(ans);

% Bilinear
Resized_bilinear = imresize(Input_image,0.8,'bilinear');
Bilinear_image = imresize(Resized_bilinear,[row, column],'bilinear');
subplot(2,3,2),imshow(Resized_bilinear),title('Resize 1 : Bilinear');
subplot(2,3,5),imshow(Bilinear_image),title('Resize 2 : Bilinear');
HW1_MSE(Input_image,Bilinear_image);
sprintf('Bilinear MSE is %f',ans);
disp(ans);

% Bicubic
Resized_bicubic = imresize(Input_image,0.8,'bicubic');
Bicubic_image = imresize(Resized_bicubic,[row, column],'bicubic');
subplot(2,3,3),imshow(Resized_bicubic),title('Resize 1 : Bicubic');
subplot(2,3,6),imshow(Bicubic_image),title('Resize 2 : Bicubic'); hold off
HW1_MSE(Input_image,Bicubic_image);
sprintf('Bicubic MSE is %f',ans);
disp(ans);