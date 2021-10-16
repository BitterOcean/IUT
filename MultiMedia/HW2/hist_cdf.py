"""
MultiMedia Homework 2
-----------------------------
Author : Maryam Saeedmehr
Std NO.: 9629373
"""

# Question 1 : Histogram and CDF Calculation

import cv2 as cv # for reading image
import numpy as np # some mathematic calculation
import matplotlib.pyplot as plt # plot results

def hist_cdf(image):
    """
    This function will calculate histogram of
    an input image and also calculate cdf of 
    the image. It will finally plot the results
    """
    # Histogram Calculation
    Histogram = [0]*257
    [Row, Column] = image.shape
    for row in range(Row):
        for column in range(Column):
            Histogram[image[row][column] + 1] = Histogram[image[row][column] + 1] + 1

    # PDF Calculation
    pdf = [Histogram[i]/(Row*Column) for i in range(257)]
    
    # CDF Calculation
    cdf = [0]*257
    for i in range(1,257):
        cdf[i] = cdf[i-1] + pdf[i]

        
     # ----------------------------------------------------------
     # These plots should be commented fot Question 3 otherwise
     # some errors like : 'warning about too many open figures'
     # occures. :)
         
#     # Plot Histogram
#     plt.figure(figsize=(8, 6))
#     plt.title('Histogram')
#     plt.plot(Histogram)
    
#     # Plot CDF
#     plt.figure(figsize=(8, 6))
#     plt.title('CDF')
#     plt.plot(cdf)

     # -----------------------------------------------------------
    
    return [Histogram, cdf]
    

# -----------------------------
# Test the function
img = cv.imread('Hi.tif', 0)
[Histogram, CDF] = hist_cdf(img)

# Plot Histogram
plt.figure(figsize=(8, 6))
plt.title('Histogram')
plt.plot(Histogram)

# Plot CDF
plt.figure(figsize=(8, 6))
plt.title('CDF')
plt.plot(CDF)
