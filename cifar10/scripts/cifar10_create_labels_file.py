#!/usr/bin/python2.6
#
#DESCRIPTION: Script that converts the Kaggle specified
# 	training labels to a Caffe/LevelDB compatible 
#	format. Refer caffe/tools/convert_imageset.cpp 
#	for details. 
#
#AUTHOR: Vik Kamath
#
#USAGE: ./scriptname.py <path to source FILE> <path to destination FOLDER>
#	
#
#TODO : 1. Validate Path Names
#	2. Generalize to any label_set 
# 
#


#-----IMPORTS----------
import csv
import sys


#-----GLOBALS----------
labels = {"airplane":"2","automobile":"2","bird":"3","cat":"4","deer":"5","dog":"6","frog":"7","horse":"8","ship":"9","truck":"10"}
filename = "labels_file.txt" #TODO: Fix this
format = ".png"
#--------------------

def createLabelsFile(source,destination):
	destination = destination + filename #This is the file that the formatted output get's written to
	f = open(destination,'w')	
	with open(source,'rb') as csvfile:
		reader = csv.reader(csvfile)
		next(reader,None) #Ignore the header (id,label)
		for row in reader: 
			toWrite = row[0] + format + " " + labels[row[1]] #This is the format that convert_imageset.cpp wants
			f.write(toWrite+'\n')
	f.close()
			

def main():
	createLabelsFile(sys.argv[1],sys.argv[2])
	
	





if __name__ == "__main__":
	main()	
