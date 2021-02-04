%{
  Adaptive blind image watermarking using edge pixel concentration. [1]
  -------------------------------------------------------------------------
  Embedding Function 

  Author : Maryam Saeedmehr
  Std.NO : 9629373
  Supervisor : Professor S. Samavi
  Multimedia final project
  -------------------------------------------------------------------------
  Reference
  1. H. R. Fazlali, S. Samavi, N. Karimi, S.Shirani(2016) 
     Adaptive blind image watermarking using edge pixel concentration
%}

function W_image = main_Adaptive(I, B, a, W2D, K, alpha, Q)
    % Split Cover into non-overlapping B*B blocks using mat2cell function--
    [rows, columns] = size(I);
    blockSizeR = B;
    blockSizeC = B; 
    wholeBlockRows = floor(rows / blockSizeR);
    wholeBlockCols = floor(columns / blockSizeC);
    trailing_rows = rows - wholeBlockRows * blockSizeR;
    trailing_cols = columns - wholeBlockCols * blockSizeC;
    blocks = mat2cell( I, ...
             [blockSizeR * ones(1, wholeBlockRows), trailing_rows], ...
             [blockSizeC * ones(1, wholeBlockCols), trailing_cols], ...
             size(I, 3) );
    % Resize and reshape Logo ---------------------------------------------
    W2D_resized = imresize(W2D, [wholeBlockRows, wholeBlockCols]);
    W2D_BW = dither(W2D_resized);
    W1D = reshape(W2D_BW,[1, wholeBlockRows*wholeBlockCols]);
    % Encrypt Logo --------------------------------------------------------
    rng(K); % rand('seed',K);
    index = randperm(wholeBlockRows*wholeBlockCols);
    W1D = W1D(index);
    % DCT2 from each block ------------------------------------------------
    dct = cell(wholeBlockRows,wholeBlockCols);
    for i = 1:wholeBlockRows
        for j = 1:wholeBlockCols
            dct{i,j} = dct2(blocks{i,j});
            % Complexity Calculation --------------------------------------
            entropy_i = entropy(blocks{i,j});
            edges = edge(blocks{i,j},'canny');
            edge_concentration = sum(edges(:) == 1);
            complexity = edge_concentration + entropy_i;
            alpha_i = sqrt(abs(complexity ...
                      * (dct{i,j}(a+1,a) + dct{i,j}(a,a+1)) / 2 ...
                      + alpha));
            if W1D((i-1)*wholeBlockCols+j) == 0
                beta_i = dct{i,j}(a,a+1) - dct{i,j}(a+1,a);
            else 
                beta_i = dct{i,j}(a+1,a) - dct{i,j}(a,a+1);
            end
            % Embeding data -----------------------------------------------
            if ((dct{i,j}(a+1,a) > dct{i,j}(a,a+1) && ...
                    W1D((i-1)*wholeBlockCols+j) == 0) ...
                    || ((dct{i,j}(a+1,a) <= dct{i,j}(a,a+1) && ...
                    W1D((i-1)*wholeBlockCols+j) == 1)))
                temp = dct{i,j}(a+1,a);
                dct{i,j}(a+1,a) = dct{i,j}(a,a+1);
                dct{i,j}(a,a+1) = temp;
            end
            % Applying alpha (strength facror) ----------------------------
            if dct{i,j}(a+1,a) > dct{i,j}(a,a+1) && alpha_i > beta_i
                dct{i,j}(a+1,a) = dct{i,j}(a+1,a) + alpha_i/2;
                dct{i,j}(a,a+1) = dct{i,j}(a,a+1) - alpha_i/2;
            elseif dct{i,j}(a+1,a) <= dct{i,j}(a,a+1) && alpha_i > beta_i
                dct{i,j}(a,a+1) = dct{i,j}(a,a+1) + alpha_i/2;
                dct{i,j}(a+1,a) = dct{i,j}(a+1,a) - alpha_i/2;
            end
            % Inverse of DCT2 ---------------------------------------------
            blocks{i,j} = uint8(idct2(dct{i,j}));
        end
    end
    % Return the result and calculate PSNR --------------------------------
    W_image = cell2mat(blocks);
    PSNR = psnr(W_image,I);
%     figure
%     subplot(1,2,1), imshow(I), title('Original Image');
%     subplot(1,2,2), imshow(W_image), title('Watermarked Image');
%     text(-256,-150,'Adaptive watermarking');
%     text(-180,550,['PSNR = ' num2str(psnr(W_image,I))]);
    disp(['Adaptive watermarking , PSNR = ' num2str(PSNR)]);
end 