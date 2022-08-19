#!/usr/bin/env bash
# autobuild.sh

if  lsmod | grep -q "88x2bu" # check if module 88x2bu is loaded
then
	logger -t 88x2BU "Module 88x2bu already loaded successfully"
	exit 0
else
	logger -t 88x2BU "Starting build of 88x2bu module"
fi

if [ -d /usr/local/src/RTL88x2BU-Linux-Driver/ ] # check for module driver directory
then 
	cd /usr/local/src/RTL88x2BU-Linux-Driver/
else
	logger -t 88x2BU "Driver directory /usr/local/src/RTL88x2BU-Linux-Driver/ not found"
	exit 1
fi

if ! make clean # Exit if unable to clean driver directory
then
	logger -t 88x2BU "Unable to clean driver directory"
	exit 2
else
	logger -t 88x2BU "Successfully cleaned driver directory"
fi

if ! make -j 4 # Compile the module
then
	logger -t 88x2BU "Unable to compile 88x2bu module"
	exit 3
else
	logger -t 88x2BU "Successfully compiled 88x2bu module"
fi

if ! sudo make install # Install the module (best to have NOPASSWD:ALL for commands in sudoers)
then
	logger -t 88x2BU "Unable to install 88x2bu module"
	exit 4
else 
	logger -t 88x2BU "Successfully installed 88x2bu module"
fi

if ! sudo modprobe 88x2bu # Load the module
then
	logger -t 88x2BU "Module 88x2bu failed to load"
	exit 5
else
	logger -t 88x2BU "Module 88x2bu successfully loaded"
fi
