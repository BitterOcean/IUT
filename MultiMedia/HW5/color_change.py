"""
MultiMedia Homework 5
-----------------------------
Author : Maryam Saeedmehr
Std NO.: 9629373

How to run :
~$ python3 color_change.py
"""

# Question 1 : Change color

import cv2 as cv  # for reading image
import numpy as np  # some mathematics calculation
import matplotlib.pyplot as plt  # plot results
from time import sleep


def color_change(I, w, new_color):
    # BGR to RGB --------------------------------------------------------------
    I_RGB = cv.cvtColor(I, cv.COLOR_BGR2RGB)
    
    # RGB to HSV --------------------------------------------------------------
    I_HSV = cv.cvtColor(I, cv.COLOR_BGR2HSV)

    # Select a point ----------------------------------------------------------
    fig1 = plt.figure(1)
    ax = fig1.add_subplot(111)
    ax.imshow(I_RGB)
    y, x = int(round(plt.ginput(1)[0][0])), int(round(plt.ginput(1)[0][1]))
    plt.plot(y, x, 'X', color=(0, 1, 0), markersize=10)
    fig1.canvas.draw()

    # Change the Color --------------------------------------------------------
    if 0 <= I_HSV[x][y][0] <= 10 and I_HSV[x][y][0] - w < 0:
        red_lower1 = 0
        red_upper1 = I_HSV[x][y][0] + w
        red_lower2 = I_HSV[x][y][0] - w + 180
        red_upper2 = 179
        for i in range(I.shape[0]):
            for j in range(I.shape[1]):
                if red_lower1 <= I_HSV[i][j][0] <= red_upper1 \
                or red_lower2 <= I_HSV[i][j][0] <= red_upper2:
                    I_HSV[i][j][0] = new_color

    elif 169 <= I_HSV[x][y][0] <= 179 and I_HSV[x][y][0] + w > 179:
        red_lower1 = 0
        red_upper1 = I_HSV[x][y][0] + w - 180
        red_lower2 = I_HSV[x][y][0] - w
        red_upper2 = 179
        for i in range(I.shape[0]):
            for j in range(I.shape[1]):
                if red_lower1 <= I_HSV[i][j][0] <= red_upper1 \
                or red_lower2 <= I_HSV[i][j][0] <= red_upper2:
                    I_HSV[i][j][0] = new_color

    elif 0 <= I_HSV[x][y][0] <= 10 or 169 <= I_HSV[x][y][0] <= 179:
        red_lower1 = I_HSV[x][y][0] - w
        red_upper1 = I_HSV[x][y][0] + w
        for i in range(I.shape[0]):
            for j in range(I.shape[1]):
                if red_lower1 <= I_HSV[i][j][0] <= red_upper1:
                    I_HSV[i][j][0] = new_color
    
    else:
        lower = I_HSV[x][y][0] - w
        upper = I_HSV[x][y][0] + w
        for i in range(I.shape[0]):
            for j in range(I.shape[1]):
                if lower <= I_HSV[i][j][0] <= upper:
                    I_HSV[i][j][0] = new_color    

    # plot the results --------------------------------------------------------
    fig2 = plt.figure(2)
    ax2 = fig2.add_subplot(111)
    ax2.imshow(cv.cvtColor(I_HSV, cv.COLOR_HSV2RGB))
    plt.show()


# Test the function -----------------------------------------------------------
img1 = cv.imread("berbatov.jpg")
img2 = cv.imread("Hi.JPG")
image = int(input('Which Image do you want to test?(Enter its number)\n1- berbatov\n2- Hi\n'))
while image not in (1,2):
    print('Oops! Wrong number!')
    image = int(input('Which Image do you want to test?(Enter its number)\n1- berbatov\n2- Hi\n'))

w = int(input('Enter the range of color (just an integer): '))
new_color = int(input('Enter the Hue of every new color you want: '))
print('\nNow pick a color you want to replace just \nby clicking on somewhere with that color...')
sleep(1.5)

if image == 1:
    color_change(img1, w, new_color)
else:
    color_change(img2, w, new_color)
