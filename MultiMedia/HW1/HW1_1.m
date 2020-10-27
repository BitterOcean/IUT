function [ ] = HW1_1(Input_image)
    [row, column] = size(Input_image);
    
    for i = 1:row
        FlippedImage(i,:) = Input_image(row-i+1,:);
        for j = 1:column
            TransposedImage(i,j) = Input_image(j,i);
            Right_shift(i,mod(j+2,column)+1) = Input_image(i,j);
            Left_shift(i,j) = Input_image(i,mod(j+2,column)+1);
            Up_shift(i,j) = Input_image(mod(i+2,row)+1,j);
            Down_shift(mod(i+2,row)+1,j) = Input_image(i,j);
            Diagonal_up_right(i,mod(j+2,column)+1) = Input_image(mod(i+2,row)+1,j);  
            Diagonal_up_left(i,j) = Input_image(mod(i+2,row)+1,mod(j+2,column)+1);  
            Diagonal_down_right(mod(i+2,row)+1,mod(j+2,column)+1) = Input_image(i,j);
            Diagonal_down_left(mod(i+2,row)+1,j) = Input_image(i,mod(j+2,column)+1);
        end
    end
    
    for i = 1:floor(0.5*row)
        for j = 1:floor(0.5*column)
            CroppedImage(i,j) = Input_image(floor(0.25*row)+i,floor(0.25*column)+j);
        end
    end
    
    % Show Results
    subplot(3,4,1),imshow(Input_image),title('Main Image'); hold  on
    subplot(3,4,2),imshow(FlippedImage),title('Flip Horizontal');
    subplot(3,4,3),imshow(TransposedImage),title('Transposed Image');
    subplot(3,4,4),imshow(CroppedImage),title('Cropped Image'); 
    subplot(3,4,5),imshow(Right_shift),title('Right Shifted Image'); 
    subplot(3,4,6),imshow(Left_shift),title('Left Shifted Image');
    subplot(3,4,7),imshow(Up_shift),title('Up Shifted Image'); 
    subplot(3,4,8),imshow(Down_shift),title('Down Shifted Image');
    subplot(3,4,9),imshow(Diagonal_up_right),title('Diagonal Up Right Image'); 
    subplot(3,4,10),imshow(Diagonal_up_left),title('Diagonal Up Left Image');
    subplot(3,4,11),imshow(Diagonal_down_right),title('Diagonal Down Right Image'); 
    subplot(3,4,12),imshow(Diagonal_down_left),title('Diagonal Down Left Image'); hold off
end

