#! /bin/bash

echo "Hello		 World"

mkdir TEMPTEST
cd TEMPTEST

pwd

cp /etc/passwd passwd
sudo cp /etc/shadow shadow

sudo cat * | less

grep root passwd
grep root shadow


###################################################
#VARIABLES#

HELLO="Hello World"
echo $HELLO

echo "What is your name?"
read MY_NAME
echo "Hello $MY_NAME Welcome!"
echo "Lets create you your very own file"

touch "${MY_NAME}_file"

echo "Well Hello There $MY_NAME" >> ${MY_NAME}_file





