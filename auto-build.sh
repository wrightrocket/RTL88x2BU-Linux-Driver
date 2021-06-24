if [ lsmod | grep -q "88x2bu" ]
then
	logger -t WIFI "Module 88x2bu already loaded successfully"
	exit 0
fi
if [ -d /usr/local/src/RTL88x2BU-Linux-Driver/ ]
then 
	cd /usr/local/src/RTL88x2BU-Linux-Driver/
else
	logger -t WIFI "Driver directory /usr/local/src/RTL88x2BU-Linux-Driver/ not found"
	exit 1
fi

if [! make clean ]
then
       
else
	logger -t WIFI "Unable to clean driver directory"
	exit 2
fi
if [! make ]
then
	logger -t WIFI "Unable to make driver"
	exit 3
if [! make install ]
then
	logger -t WIFI "Unable to install driver"
	exit 4
fi

if [! modprobe 88x2bu ]
	logger -t WIFI "Module driver failed to load"
	exit 5
else
	logger -t WIFI "Module 88x2bu successfully"
fi
