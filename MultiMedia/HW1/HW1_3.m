clc;
close all;
clear;

%%%%% Part A %%%%%
Input_image = imread('Hi.tif');

% Brightness Reduction
Input_image_darker = Input_image - 20;
Input_image_darker = max(Input_image_darker,0);

% Plot Both Images
subplot(1,3,1),imshow(Input_image),title('original'); hold on
subplot(1,3,2),imshow(Input_image_darker),title('darker'); hold off
    
% MSE Calculation
mse1 = HW1_MSE(Input_image,Input_image_darker);
sprintf('MSE Origin and its darker version is %f',mse1);
disp(ans); 

%%%%% Part B %%%%%
% Creating an Image of Left_shift, Right_shift and original Input Image
[row, column] = size(Input_image);
for i = 1:row
    for j = 1:column
        Right_shift(i,mod(j+2,column)+1) = Input_image(i,j);
        Left_shift(i,j) = Input_image(i,mod(j+2,column)+1);
    end
end  
Input_image_new = (Right_shift + Left_shift + Input_image)/3;

% Plot Both Images
subplot(1,3,3),imshow(Input_image_new),title('avg of Left and Right shift and original Input Image'); hold off

% MSE Calculation
mse2 = HW1_MSE(Input_image,Input_image_new);
sprintf('MSE Origin and its new version is %f',mse2);
disp(ans); 