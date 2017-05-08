import cv2, math, numpy, pandas as pd #pip install opencv-python
import os, sys
from os import walk
from PIL import Image, ImageChops, ImageEnhance #pip install Pillow

#Simple matrix print for debug
def printMatrix(matrix):
	for row in matrix:
		print(row)

#Count frequency of black vs white around the image border
def countColors(array, colorTracker):
	for color in array:
		if(color == 0):
			colorTracker[0] += 1
		else:
			colorTracker[0] -= 1

#Make letter black with higher probability
def correctWhiteSpace(im, imageData):
	#estimate background color
	colorTracker = [0]
	#count occourance of outermost pixels of image
	countColors(imageData[0][:im.size[0] - 1], colorTracker)
	countColors(imageData[im.size[1] - 1][1:], colorTracker)
	countColors((row[0] for row in imageData[1:im.size[1]]), colorTracker)
	countColors((row[im.size[0] - 1] for row in imageData[:im.size[1] - 1]), colorTracker)
	
	color = 0 if colorTracker[0] > 0 else 255
	return im.point(lambda x: 255 if x == 0 else 0, '1') if colorTracker[0] > 0 else im
	

#remove background space in image
def trim(im):
	bg = Image.new(im.mode, im.size, 255)
	diff = ImageChops.difference(im, bg)
	diff = ImageChops.add(diff, diff)
	bbox = diff.getbbox()
	if bbox:
		return im.crop(bbox)

#make image length by length (assuming compression)
def square(im, length):
	size = (length, length)
	im.thumbnail((length, length))
	background = Image.new('L', size, (255))
	background.paste(im, (int((size[0] - im.size[0]) / 2), int((size[1] - im.size[1]) / 2)))
	
	return background;

#Param im     The PIL object to be processed
#Param length The length of the square result 
def processImage(im, length):
	#grayscale image
	im = im.convert("L")
	
	#load image into array
	imageData = numpy.asarray(im)
	imageData.setflags(write = 1)
	
	#convert image to binary
	threshold = round(imageData.mean())
	im = im.point(lambda x: 0 if x < threshold else 255, '1')
	imageData = numpy.asarray(im)
	imageData.setflags(write = 1)
	im = correctWhiteSpace(im, imageData)
	
	#denoise image
	im.save("temp.jpg", "JPEG")
	img = cv2.imread('temp.jpg')
	dst = cv2.fastNlMeansDenoising(img, None, 70.0, 7, 21)
	cv2.imwrite("temp.jpg", dst)
	
	#convert image to binary again
	im = Image.open("temp.jpg").convert("L")
	im = im.point(lambda x: 0 if x < threshold else 255, '1')
	
	#remove some background
	im = trim(im)
	
	#compress and pad image so that it is 128^2
	im = square(im, length)
	
	return im



def walkFolder(imgFolder):
	for (dirpath, dirs, files) in walk(imgFolder):
		for d in dirs:
			print(d)
			walkSubFolders(d)


def walkSubFolders(imgFolder):
	outputDir = "Processed"+imgFolder
	if not os.path.exists(outputDir):
		os.makedirs(outputDir)

	for (dirpath, dirs, files) in os.walk('74k_EnglishImg'+'/'+imgFolder):
		print('dirpath')
		for file in files:
			filename = os.path.join(dirpath, file)

			print(filename)
			try:
				im = Image.open(filename)
				im = processImage(im, 32)
				im.save(outputDir + "/" + file)
				print(file + " fin")

			except IOError:
				print("Cannot open ", imgFolder + "/" + file)

		for d in dirs:
			
			walkSubFolders(d)

walkFolder(''.join(str(e) for e in sys.argv[1:]))
