#!/bin/sh
#
#DESCRIPTION: Starts training the model for CIFAR 10
#
#
#AUTHOR: Vik Kamath
#
#
#DISCLAIMER: Heavily based on the scipt in bvlc/caffe

#---------VARIABLES----------------------
#-------
#NOTE $caffe,$cifar and $analysis are defined
#	in my bashrc
TOOLS=$caffe/build/tools
PROTOTXT_LR1=$analysis/db/vanilla/cifar10_full_solver.prototxt
PROTOTXT_LR2=$analysis/db/vanilla/cifar10_full_solver_lr1.prototxt
PROTOTXT_LR3=$analysis/db/vanilla/cifar10_full_solver_lr2.prototxt
SOLVERSTATE_1=$analysis/db/vanilla/cifar10_vanilla_60000.solverstate
SOLVERSTATE_2=$analysis/db/vanilla/cifar10_vanilla_65000.solverstate
GLOGDIR=$analysis/db/vanilla/vanilla/glog/

#-------
#****************************************




#---------TRAINING-----------------------
#-------
#USAGE (according to train_net.bin):
#train_net.bin \
#	solver_proto_file
#	[resume point file]

#Make the Glog directory if it doesn't exist
mkdir -p $GLOGDIR

#Train
GLOG_logtostderr=0
GLOG_log_dir=$GLOGDIR
$TOOLS/train_net.bin \
	$PROTOTXT_LR1 \

#Reduce learning rate by a factor of 10
GLOG_logtostderr=0
GLOG_log_dir=$GLOGDIR
$TOOLS/train_net.bin \
	$PROTOTXT_LR2 \
	$SOLVERSTATE_1 \

#Reduce learning rate by a factor of 10, again
GLOG_logtostderr=0
GLOG_log_dir=$GLOGDIR
$TOOLS/train_net.bin \
	$PROTOTXT_LR2 \
	$SOLVERSTATE_2 \

#--------
#******************************************





	
	
