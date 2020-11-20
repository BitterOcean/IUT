"""
MultiMedia Homework 3
-----------------------------
Author : Maryam Saeedmehr
Std NO.: 9629373
"""

# Question 1 : Median Cut

import cv2 as cv # for reading image
import numpy as np # some mathematic calculation
import matplotlib.pyplot as plt # plot results


# Histogram Function of HW2------------------------------------
def histogram(image):
    """
    This function will calculate histogram of
    an input image.
    """
    Histogram = [0]*257
    [Row, Column] = image.shape
    for row in range(Row):
        for column in range(Column):
            Histogram[image[row][column] + 1] = Histogram[image[row][column] + 1] + 1
        
    return Histogram
    
    
# Hist_Median function----------------------------------------
def hist_median(image):
    # create a copy of original image
    image_copy = np.copy(image)

    hist = histogram(image)
    
    [Row, Column] = image.shape
    imageSize = Row * Column
    
    # find k-means-----------------------------
    sum_ = 0
    k_means = []
    k = 1
    for i in range(257):
        sum_ += hist[i]
        if sum_ >= k*imageSize//4:
            k_means.append(i)
            k += 1
            if k == 4:
                break
                
    # Quantization-----------------------------
    for i in range(Row):
        for j in range(Column):
            if image[i][j] < k_means[0]:
                image_copy[i][j] = 0
            elif image[i][j] >= k_means[0] and image[i][j] < k_means[1]:
                image_copy[i][j] = 1
            elif image[i][j] >= k_means[1] and image[i][j] < k_means[2]:
                image_copy[i][j] = 2
            else :
                image_copy[i][j] = 3
    
    
    # Plot Histogram and k-means---------------
    plt.figure(figsize=(8, 6))
    plt.title('Histogram')
    plt.plot(hist)
    plt.vlines(k_means[0], ymin=25, ymax=max(hist), colors='red', label='T01')
    plt.vlines(k_means[1], ymin=25, ymax=max(hist), colors='green', label='T0')
    plt.vlines(k_means[2], ymin=25, ymax=max(hist), colors='yellow', label='T02')
    plt.legend()
    
    # Plot Quantized image---------------------
    plt.figure(figsize=(16, 12))
    plt.subplot(121)
    plt.title('Original Image')
    plt.imshow(image, cmap='gray')
    plt.subplot(122)
    plt.title('Quantized Image')
    plt.imshow(image_copy, cmap='gray')
    
# ------------------------------------------------------------
# Test the function
img = cv.imread('Hi.tif', 0)
hist_median(img)
