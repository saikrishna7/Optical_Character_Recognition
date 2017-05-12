import cv2
import numpy as np
import os

path='C:\Users\saikr\Desktop\dt_test';
os.chdir(path) 

img1 = cv2.imread('2.png')
img2 = cv2.imread('5.png')
img3 = cv2.imread('6.png')
img4 = cv2.imread('7.png')
img5 = cv2.imread('8.png')
img6 = cv2.imread('9.png')
img7 = cv2.imread('10.png')
img8 = cv2.imread('11.png')
img9 = cv2.imread('12.png')
img10 = cv2.imread('13.png')
img11 = cv2.imread('15.png')
img12 = cv2.imread('16.png')
img13 = cv2.imread('17.png')
img14 = cv2.imread('18.png')
img15 = cv2.imread('19.png')
img16 = cv2.imread('20.png')
img17 = cv2.imread('21.png')

img3 = np.hstack((img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17))
cv2.imwrite('final_image.png',img3)