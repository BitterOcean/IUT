"""
MultiMedia Homework 2
-----------------------------
Author : Maryam Saeedmehr
Std NO.: 9629373
"""
# Question 4 : Watermarking 

import cv2 as cv # for reading image
import numpy as np # some mathematic calculation
import matplotlib.pyplot as plt # plot results
from PIL import Image # used for dithering the image also open an image

def hw2_hide(image, logo, L):
    [column, row] = image.shape
    watermarked = np.copy(image) # make a copy of input image
    
    # Resize Logo to the cover image-----------------------------------------------------
    resized_logo = logo.resize((row, column)) 

    # Make Logo an 1-bit image with dither-----------------------------------------------
    logo_bw = resized_logo.convert('1')
    
    # convert 'PIL.TiffImagePlugin.TiffImageFile' to np.array to become easy to use -----
    One_Bit_logo = np.array(logo_bw, dtype='?') 
    
    # hide the logo to level L of the cover image----------------------------------------
    for i in range(row):
        for j in range(column):
                watermarked_binary_pixel_list = list(f'{image[i][j]:08b}')
                watermarked_binary_pixel_list[8-L] = f'{One_Bit_logo[i][j]:01b}'
                watermarked_binary_pixel_str = ''.join(watermarked_binary_pixel_list)
                watermarked[i][j] = int(watermarked_binary_pixel_str, 2)
    
    # Plot the results ------------------------------------------------------------------
    plt.figure(figsize=(8, 6))
    plt.imshow(image, cmap='gray')
    plt.title('Original Image');

    plt.figure(figsize=(8, 6))
    plt.imshow(watermarked, cmap='gray')
    plt.title('Watermarked Image');
    
    # Calculate MSE ---------------------------------------------------------------------
    MSE = np.mean((image - watermarked)**2)
    print('MSE = {}'.format(MSE))
    
    # Return watermarked image and the MSE ----------------------------------------------
    return [watermarked, MSE]
    
    
# ------------------------------------
# Test the function
image = cv.imread('Hi.tif', 0)
logo = Image.open('iut.tif')
L = 1

Output = hw2_hide(image, logo, L)
