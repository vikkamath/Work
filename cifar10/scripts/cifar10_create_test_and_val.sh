#!/bin/sh
#DESCRIPTION: Divides the data (labels) into training and validation according to ratio specs below
#
#AUTHOR: Vik Kamath, Aalto University
#
#TODO: 1. Take care of the situation where division results in fractional indices
#      2. Find a way to avoid writing results of shuffle into a temp file

#--------------VARIABLES---------------------------
#NOTE: $cifar and $caffe are defined in my bashrc
#
LABELS=$cifar/analysis/kamathv1/scripts/labels_file.txt
TRAINING=$cifar/analysis/kamathv1/scripts/train_labels_file.txt
VALIDATION=$cifar/analysis/kamathv1/scripts/validation_labels_file.txt
TEMPFILE=./tempfile.txt
SPLIT=80 #Percentage of training samples
#--------------------------------------------------

#-------------PROCESSING---------------------------
shuf $LABELS > $TEMPFILE #Randomly shuffle the data and write to a temp file
lines=$(wc -l < $TEMPFILE) #count the number of lines in the file
trainidx=$[$lines*$SPLIT/100] #training END index
validx=$[$trainidx+1] #validation START index
sed -n "1,$trainidx p" $TEMPFILE > $TRAINING #Write the first 80% of the shuffled data into the training file
sed -n  "$validx,$lines p" $TEMPFILE > $VALIDATION #Write the last 20% of the shuffled data into the validation file
rm tempfile.txt #Remove the temporary file
#--------------------------------------------------


