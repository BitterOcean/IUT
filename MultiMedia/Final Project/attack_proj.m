%{
  Non-adaptive blind image watermarking using DCT /
  Adaptive blind image watermarking using edge pixel concentration. [1]
  -------------------------------------------------------------------------
  Attack Function

  Author : Maryam Saeedmehr
  Std.NO : 9629373
  Supervisor : Professor S. Samavi
  Multimedia final project
  -------------------------------------------------------------------------
  Reference
  1. H. R. Fazlali, S. Samavi, N. Karimi, S.Shirani(2016) 
     Adaptive blind image watermarking using edge pixel concentration
%}

function attack_proj(W_image, B, a, K, W2D)
    [rows, columns] = size(W_image);
    r = floor(rows/B);
    c = floor(columns/B);
    W2D_resized = imresize(W2D, [r, c]);
    W2D_BW = dither(W2D_resized);
    % Apply JPEG attack ---------------------------------------------------
    imwrite(W_image, 'NC60.jpeg', 'quality', 60);
    imwrite(W_image, 'NC80.jpeg', 'quality', 80);
    imwrite(W_image, 'NC100.jpeg', 'quality', 100);
    % Read attacked images ------------------------------------------------
    nc60 = imread('NC60.jpeg');
    nc80 = imread('NC80.jpeg');
    nc100 = imread('NC100.jpeg');
    % Extract Logo --------------------------------------------------------
    ex_nc60 = extraction(nc60, B, a, K);
    ex_nc80 = extraction(nc80, B, a, K);
    ex_nc100 = extraction(nc100, B, a, K);
    % NC calculation ------------------------------------------------------
    nc60_xnor = not(xor(W2D_BW, ex_nc60));
    nc80_xnor = not(xor(W2D_BW, ex_nc80));
    nc100_xnor = not(xor(W2D_BW, ex_nc100));
    nc60_nc = sum(nc60_xnor(:))/(r*c);
    nc80_nc = sum(nc80_xnor(:))/(r*c);
    nc100_nc = sum(nc100_xnor(:))/(r*c);
    % Print the results and plot the extracted logo -----------------------
    disp(['NC60 , NC = ' num2str(nc60_nc)]);
    disp(['NC80 , NC = ' num2str(nc80_nc)]);
    disp(['NC100 , NC = ' num2str(nc100_nc)]);
    figure
    subplot(2,2,1), imshow(W2D_BW), title('Original Logo')
    subplot(2,2,2), imshow(ex_nc60), ...
        title(['NC60 , NC = ' num2str(nc60_nc)])
    subplot(2,2,3), imshow(ex_nc80), ...
        title(['NC80 , NC = ' num2str(nc80_nc)])
    subplot(2,2,4), imshow(ex_nc100), ...
        title(['NC100 , NC = ' num2str(nc100_nc)])    
end