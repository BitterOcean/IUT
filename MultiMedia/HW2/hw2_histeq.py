"""
MultiMedia Homework 2
-----------------------------
Author : Maryam Saeedmehr
Std NO.: 9629373
"""
# Question 2 : Histogram Equalization 

from math import floor

def hw2_histeq(image):
    """
    This function will calculate histogram equalization 
    on the input image.
    """
    [Histogram, CDF] = hist_cdf(image)
    New_Intensity = [0]*257
    New_Intensity = [floor(cdf*255) for cdf in CDF]
        
    return New_Intensity
