%{
  Non-adaptive blind image watermarking using DCT
  -------------------------------------------------------------------------
  Embedding Function

  Author : Maryam Saeedmehr
  Std.NO : 9629373
  Supervisor : Professor S. Samavi
  Multimedia final project
%}

function W_image = embed_proj(I, B, a, W2D, K, alpha)
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
            if W1D((i-1)*wholeBlockCols+j) == 0
                beta = dct{i,j}(a,a+1) - dct{i,j}(a+1,a);
            else 
                beta = dct{i,j}(a+1,a) - dct{i,j}(a,a+1);
            end
            if dct{i,j}(a+1,a) > dct{i,j}(a,a+1) && alpha > beta
                dct{i,j}(a+1,a) = dct{i,j}(a+1,a) + alpha/2;
                dct{i,j}(a,a+1) = dct{i,j}(a,a+1) - alpha/2;
            elseif dct{i,j}(a+1,a) <= dct{i,j}(a,a+1) && alpha > beta
                dct{i,j}(a,a+1) = dct{i,j}(a,a+1) + alpha/2;
                dct{i,j}(a+1,a) = dct{i,j}(a+1,a) - alpha/2;
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
%     text(-260,-150,'Non-adaptive watermarking');
%     text(-180,550,['PSNR = ' num2str(psnr(W_image,I))]);
    disp(['Non-adaptive watermarking , PSNR = ' num2str(PSNR)]);
end 