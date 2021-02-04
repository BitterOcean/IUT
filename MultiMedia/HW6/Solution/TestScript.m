function TestScript()
    clc
    close all
    
    I = imread('lena.bmp');
    W2D = imread('iut5.bmp');
    a = 4;
    B = 8;
    K = 19;
    alpha = 40;
    Q = 0;

    disp('---------- Non-Adaptive Results ----------');
    Nonadaptive = embed_proj(I, B, a, W2D, K, alpha);   
%     attack_proj(Nonadaptive, B, a, K, W2D);

    disp('------------ Adaptive Results ------------');
    Adaptive = main_Adaptive(I, B, a, W2D, K, alpha, Q);
%     attack_proj(Adaptive, B, a, K, W2D);

    figure
    subplot(1,2,1), imshow(Nonadaptive), title('Non-Adaptive, PSNR = 35.6832');
    subplot(1,2,2), imshow(Adaptive), title('Adaptive, PSNR = 44.1797');
end