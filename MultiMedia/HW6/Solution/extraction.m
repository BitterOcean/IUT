%{
  Non-adaptive blind image watermarking using DCT /
  Adaptive blind image watermarking using edge pixel concentration. [1]
  -------------------------------------------------------------------------
  Extraction Function

  Author : Maryam Saeedmehr
  Std.NO : 9629373
  Supervisor : Professor S. Samavi
  Multimedia final project
  -------------------------------------------------------------------------
  Reference
  1. H. R. Fazlali, S. Samavi, N. Karimi, S.Shirani(2016) 
     Adaptive blind image watermarking using edge pixel concentration
%}

function ex_logo = extraction(W_image, B, a, K)
    % Split Cover into non-overlapping B*B blocks using mat2cell function--
    [rows, columns] = size(W_image);
    blockSizeR = B;
    blockSizeC = B; 
    wholeBlockRows = floor(rows / blockSizeR);
    wholeBlockCols = floor(columns / blockSizeC);
    trailing_rows = rows - wholeBlockRows * blockSizeR;
    trailing_cols = columns - wholeBlockCols * blockSizeC;
    blocks = mat2cell( W_image, ...
             [blockSizeR * ones(1, wholeBlockRows), trailing_rows], ...
             [blockSizeC * ones(1, wholeBlockCols), trailing_cols], ...
             size(W_image, 3) );
    % DCT2 from each block ------------------------------------------------
    dct = cell(wholeBlockRows,wholeBlockCols);
    W1D_encrypted = zeros(1,wholeBlockRows*wholeBlockCols);
    for i = 1:wholeBlockRows
        for j = 1:wholeBlockCols
            dct{i,j} = dct2(blocks{i,j});
            % Extracting data ---------------------------------------------
            if dct{i,j}(a+1,a) > dct{i,j}(a,a+1)
                W1D_encrypted((i-1)*wholeBlockCols+j) = 1;
            end
        end
    end
    % Decryption ----------------------------------------------------------
    rng(K); %rand('seed',K);
    index = randperm(wholeBlockRows*wholeBlockCols);
    [~, index] = sort(index);
    W1D = W1D_encrypted(index);
    % Return extracted logo -----------------------------------------------
    ex_logo = reshape(W1D, [wholeBlockRows, wholeBlockCols]);
end