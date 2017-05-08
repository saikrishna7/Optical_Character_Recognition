from distutils.dir_util import copy_tree
import os

toDirectory = "C:/Mizzou works/Spring 2017/Intro to Machine learning and Pattern Recognition/Optical_Character_Recognition/74k_EnglishFntAllImages"

# copy subdirectory example
for root, dirs, files in os.walk("C:/Mizzou works/Spring 2017/Intro to Machine learning and Pattern Recognition/Optical_Character_Recognition/74k_EnglishFnt/"):
	# print(dirs)

	for dir in dirs:
		foldername=os.path.join(root+dir)
		copy_tree(foldername, toDirectory)
# fromDirectory = "C:/Mizzou works/Spring 2017/Intro to Machine learning and Pattern Recognition/Optical_Character_Recognition/compressed/Sample001"


		