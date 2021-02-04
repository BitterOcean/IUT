%{
  Filter 2 - Part 2 : 
    implement 1-D moving average filter by pure matlab and apply it 
    on noisy gray scale image.
    range of window = 0 to 15
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

M1 = 0;
M2 = 15;
window = ones(1,M1+M2+1)/(M1+M2+1);

denoised = imfilter(noisy, window);

% figure
% subplot(1,3,1), imshow(original), title('Original')
% subplot(1,3,2), imshow(noisy), title('Noisy')
% subplot(1,3,3), imshow(denoised), title('Denoised by filter2 M2 = 15')

figure, imshow(denoised), title('Denoised by filter2 M2 = 15')
psnr = psnr(denoised, original);
ssim = ssim(denoised, original);

% plot impulse response and step response ---------------------------------
up = 20;
range = -5:up;
h = reshape(impz(window),[1 M2+1]); % impulse response
s = reshape(stepz(window),[1 M2+1]); % step response

figure
tiledlayout(2,1)

% Top plot
ax1 = nexttile;
stem(ax1,range,[zeros(1,size(-5:-M1-1,2)) h zeros(1,size(M2+1:up,2))])
title('Moving Average filter Impulse Response')
axis([-5 up -0.02 0.08])

% Bottom plot
ax2 = nexttile;
stem(ax2,range,[zeros(1,size(-5:-M1-1,2)) s ones(1,size(M2+1:up,2))])
title('Moving Average filter Step Response')
axis([-5 up -0.2 1.2])
