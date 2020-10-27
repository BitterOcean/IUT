function [MSE] = HW1_MSE(Input_image1,Input_image2)
    [row, column] = size(Input_image1);
    [row2, column2] = size(Input_image2);
    if row ~= row2 || column ~= column2
        MSE = -1;% Input Images should have equal size
    else
        squaredErrorImage = (double(Input_image1)-double(Input_image2)) .^ 2;
        MSE = sum(squaredErrorImage(:))/(row*column);
    end
end

