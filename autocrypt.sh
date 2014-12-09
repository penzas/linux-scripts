#!/bin/bash

# This script was created for the purpose of automatically encrypting files in Linux.
# If you would like to know more, please visit the link below.
#
# https://penzas.com/encrypting-your-files-in-linux/


# The MIT License (MIT)
#
# Copyright (c) 2014 penzas.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


# specify the secure directory
secure_directory=/home/penzas/Desktop/SecureDocuments/

# specify the encyption key
encyption_key_name="SecureDocumentsKey"

#cd to the directory containing the files
cd $secure_directory

shred_orginal_files=NO
shred_passes=35

clear

IFS_OLD=$IFS
IFS=$(echo -en "\n\b")

#encrypt files
echo "Encrypting new files:"

# all files not associated with encrypted file extensions
for file in `ls $secure_directory | grep -v '.pgp\|.gpg'`
  do
	if [ -a $file.gpg ] || [ -a $file.pgp ]; 
	then 
		echo "  $file: An encrypted version of this file already exists.";
	else
		echo " encrypting $file ..."
		gpg --default-recipient-self --default-key $encyption_key_name --encrypt-files $file;
	fi
done
echo "Done."

#shred orginal files
if [ $shred_orginal_files == YES ]
  then
	echo "Shredding orginal files:"
	for file in `ls $secure_directory | grep -v '.pgp\|.gpg'`
	  do
		echo " shredding $file ..."
		shred -u -n $shred_passes $file
	done
	echo "Done."
fi

IFS=$IFS_OLD

