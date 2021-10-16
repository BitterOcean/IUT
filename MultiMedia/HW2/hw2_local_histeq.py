"""
MultiMedia Homework 2
-----------------------------
Author : Maryam Saeedmehr
Std NO.: 9629373
"""
# Question 3 : Local Histogram Equalization

import cv2 as cv # for reading image
import numpy as np # some mathematic calculation
import matplotlib.pyplot as plt # plot results

def hw2_local_histeq(image, n):
    [Row, Column] = image.shape
    row_pad = 0
    column_pad = 0
    new_image = image[:] # make a copy of input image.
    
    # add padding if needed------------------------------------------------
    if Row%n:
        row_pad = n - Row%n
        for i in range(row_pad):
            new_image = np.insert(new_image, 0, image[0], axis = 0)
        [Row, Column] = new_image.shape # update row, column

    if Column%n:
        column_pad = n - Column%n
        for i in range(column_pad):
            new_image = np.insert(new_image, 0, new_image[:,0], axis = 1) 
        [Row, Column] = new_image.shape # update row, column
        
    # local equalization----------------------------------------------------
    for r in range(Row):
        for c in range(Column):
            if r+n<Row and c+n<Column:
                new_intensity = hw2_histeq(new_image[r:r+n,c:c+n])
            
                # update intensity according to histogram equalization
                new_image[r][c] = new_intensity[new_image[r][c]]
            else:
                break
    
    # remove padding--------------------------------------------------------
    equalized_image = new_image[:] # make a copy of equalized image
    for i in range(row_pad):
            equalized_image = np.delete(equalized_image, 0, axis = 0)
            
    for i in range(column_pad):
            equalized_image = np.delete(equalized_image, 0, axis = 1) 
    
    # plot the result-------------------------------------------------------
    plt.figure(figsize=(8, 6))
    plt.title('Equalized Image')
    plt.imshow(equalized_image, cmap='gray')
    
    # returning the equalized image-----------------------------------------
    return equalized_image
    
# ----------------------------------
# Test the function
img1 = cv.imread('Hi.tif', 0)
local_equlized_image = hw2_local_histeq(img1, 3)

