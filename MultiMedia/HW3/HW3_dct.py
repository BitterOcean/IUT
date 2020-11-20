# Question 2 : DCT on k*k blocks with threshold=t

from scipy.fftpack import dct, idct
import cv2 as cv # for reading image
import numpy as np # some mathematic calculation
import matplotlib.pyplot as plt # plot results

# implement 2D DCT--------------------
def dct2(a):
    return dct(dct(a.T, norm='ortho').T, norm='ortho')

# implement 2D IDCT-------------------
def idct2(a):
    return idct(idct(a.T, norm='ortho').T, norm='ortho')

# PSNR Function-----------------------
def PSNR(original, compressed): 
    mse = np.mean((original - compressed) ** 2) 
    if(mse == 0): 
        """
        MSE is zero means no noise is present in the signal
        Therefore PSNR have no importance. 
        """
        return 100
    max_pixel = 255.0
    psnr = 20 * np.log10(max_pixel / np.sqrt(mse)) 
    return psnr

# DCT---------------------------------------------------------
def HW3_dct(I, K, t):
    if K not in range(4, 33):
        print('Block size should be in range [4, 32]')
        return -1
    
    [Row, Column] = I.shape
    J = cv.resize(I,(Row+(K-Row%K) , Column+(K-Column%K)))
    [Row, Column] = J.shape
    
    # DCT Coefficient calculation---------------------
    dct_coeff = dct2(J.reshape(Row//K*Column//K, K, K))
          
    # threshold appliance-----------------------------
    dct_coeff[abs(dct_coeff) < t] = 0
                
    # Reconstructing the image by idct2---------------
    rebuilt_image = idct2(dct_coeff).reshape(Row,Column)
    difference = abs(J - rebuilt_image)
    
    # PSNR--------------------------------------------
    psnr = PSNR(J, rebuilt_image)
    print('PSNR = {}'.format(psnr))
    
    # zero Coefficient count--------------------------
    zero_count = np.count_nonzero(dct_coeff==0)
    zero_percent = (zero_count/(Row*Column))*100
    print('Zero coefficients = {} %'.format(zero_percent))
    
    # plot the rebuilt, original and difference of those---
    plt.figure(figsize=(24, 18))
    plt.subplot(131)
    plt.title('Original Image')
    plt.imshow(I, cmap='gray')
    plt.subplot(132)
    plt.title('Reconstructed Image')
    plt.imshow(rebuilt_image, cmap='gray')
    plt.subplot(133)
    plt.title('Difference Image')
    plt.imshow(difference, cmap='gray')
    
# ------------------------------------------------------------
# Test the function
I = cv.imread('Hi.tif', 0)
K = 8
t = 50
HW3_dct(I, K, t)
