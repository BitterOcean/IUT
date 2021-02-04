%{
  Filter 1 - Part 1 : 
    apply 1-D median filter on noisy gray scale image 
    using "medfilt1" bulit-in function
  -------------------------------------------------------------------------
  Authors : 
    Hadis Ahmadian   - 9622613
    Maede Shamirzaei - 9629743
    Hamidreza Moalem - 9635593
%}

clc
close all
clear all

load('testimage.mat');
original = im2double(original);
noisy = im2double(noisy);

denoised = medfilt1(noisy);

% figure
% subplot(1,3,1), imshow(original), title('Original')
% subplot(1,3,2), imshow(noisy), title('Noisy')
% subplot(1,3,3), imshow(denoised), title('Denoised image by medfilt1')

figure, imshow(denoised), title('Denoised image by medfilt1')
psnr = psnr(denoised, original);
ssim = ssim(denoised, original);
