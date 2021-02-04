%{
  Filter 3 : 
    implement 1-D maximum filter by pure matlab and apply it 
    on noisy gray scale image.
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

[row, column] = size(noisy);

windowSize = 3;
window = zeros(1,windowSize);

% zero-padded noisy image -------------------------------------------------
temp = zeros(row, column+2*floor(windowSize/2));
temp1 = zeros(row, column+2*floor(windowSize/2));
temp(:, 1+floor(windowSize/2):column+floor(windowSize/2)) = noisy;

for i = 1:row
    % Move window through all elements of the signal ----------------------
    for j = floor(windowSize/2)+1:column+floor(windowSize/2)
        
        % Pick up window elements -----------------------------------------
        for k = 0:windowSize-1
            window(k + 1) = temp(i, j - floor(windowSize/2) + k); 
        end
        
        % window = sort(window); ------------------------------------------
        % temp(i, j) = window(windowSize);
        temp1(i, j) = max(window);
    end
end

% remove zero pads --------------------------------------------------------
denoised = temp1(:, 1+floor(windowSize/2):column+floor(windowSize/2));

% figure
% subplot(1,3,1), imshow(original), title('Original')
% subplot(1,3,2), imshow(noisy), title('Noisy')
% subplot(1,3,3), imshow(denoised), title('Denoised by filter3')

figure, imshow(denoised), title('Denoised by filter3')
psnr = psnr(denoised, original);
ssim = ssim(denoised, original);

% plot impulse response and step response ---------------------------------
n = -5:5;
h = zeros(size(n)); % impulse response
h(n==-1)=1;
h(n==0)=1;
h(n==1)=1;
s = @(n) (n >= -1); % step response

figure
tiledlayout(2,1)

% Top plot
ax1 = nexttile;
stem(ax1,n,h)
title('Max filter Impulse Response')
axis([-5 5 -1 2])

% Bottom plot
ax2 = nexttile;
stem(ax2,n,s(n))
title('Max filter Step Response')
axis([-5 5 -1 2])