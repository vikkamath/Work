#!/bin/sh
#DESCRIPTION: Creates leveldb databases from the image folder
#
#AUTHOR : Vik Kamath
#
#DISCLAIMER: Code is based on that in blvc/Caffe



#-------VARIABLES-------------------
#NOTE: $caffe and $cifar are in my bashrc
#-------
TOOLS=$caffe/build/tools #Where the Caffe tools are located
DATA=$cifar/analysis/kamathv1/db #Where the training data information is 

TRAIN_DATA_ROOT=$cifar/download/train/
VAL_DATA_ROOT=$cifar/download/train/
LEVELDB_DATA_ROOT=$analysis/db/vanilla

TRAIN_LEVELDB_NAME="cifar10_train_leveldb_vanilla"
VAL_LEVELDB_NAME="cifar10_val_leveldb_vanilla"

RESIZE=false
#Set RESIZE to false if the images are already 
# 	256x256
#-------
#*******************************************



#-------RESIZE-----------------------
#----------
if $RESIZE; then
	RESIZE_HEIGHT=256
	RESIZE_WIDTH=256
else
	RESIZE_HEIGHT=0
	RESIZE_WIDTH=0
fi
#----------



#--------PATH VALIDATION------------------
#----------
if [ ! -d "$TRAIN_DATA_ROOT" ]; then
	echo "Either the path specified is invalid or the file specified isn't a directory"	
	exit 1
fi
if [ ! -d "$VAL_DATA_ROOT" ]; then
	echo "Either the path specified is invalid or the file specified isn't a directory"	
	exit 1
fi
#----------
#*******************************************



#--------LEVELDB CONSTRUCTION-------------
#Refer syntax in $caffe/tools/convert_imageset.cpp
#--------
#According to convert_imageset.bin, usage:
#convertimageset.bin \
#	ROOTDIR/ \
# 	LABELSFILE \
#	DB_NAME \
# 	RANDOMSHUFFLE [0 or 1] \
#	DB_BACKEND [leveldb or lmdb - only for caffe-dev] \
#	[resize_height] [resize_width] \

#Make the experiment database if it doesn't exist
mkdir -p $LEVELDB_DATA_ROOT

echo "Constructing training and validation leveldb"


#Construction of training leveldb
echo "Constructing Training LevelDB"
GLOG_logtostderr=1 #Write errors to stderr
$TOOLS/convert_imageset.bin \
	$TRAIN_DATA_ROOT \
	$DATA/train_labels_file.txt \
	$LEVELDB_DATA_ROOT/$TRAIN_LEVELDB_NAME 1 leveldb \
	$RESIZE_HEIGHT $RESIZE_WIDTH

#Contruction of validation leveldb
echo "Constructing Training LevelDB"
GLOG_logtostderr=1 #Write errors to stderr
$TOOLS/convert_imageset.bin \
	$VAL_DATA_ROOT \
	$DATA/validation_labels_file.txt \
	$LEVELDB_DATA_ROOT/$VAL_LEVELDB_NAME 1 leveldb \
	$RESIZE_HEIGHT $RESIZE_WIDTH

echo "Done!" 
#---------
#*******************************************



	
	

	



