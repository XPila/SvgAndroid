## !makejar.sh
export TMPDIR=/data/data/com.xpila.ash 
#script file for terminal emulator com.xpila.ash
#create jar file from binaries compiled in AIDE 2.2 or AIDE 3.2 (different 'bin' folder structure)
#requierements - zip (e.g. from kbox)
#current directory must be AIDE project root (version 2.2) or build directory containing 'bin' folder

#exit on first error
set -e
#redirect stderr to logfile
exec 2> "!makejar.err"

#read package name from MANIFEST.MF
PACKAGE=$(cat MANIFEST.MF | grep -E "^Name:")
#cut prefix "Name:"
PACKAGE=${PACKAGE#Name:}
#cut beginning whitespace
export PACKAGE=${PACKAGE# }
echo "Package name: $PACKAGE"

#check for output files
export CLS_DIR=""
if [ -e bin/classes2 ]; then
 export CLS_DIR="bin/classes2"
else
 if [ -e bin/classesrelease ]; then
  export CLS_DIR="bin/classesrelease"
 else
  echo "no output binary files" >&2
  exit
 fi
fi
if [ ! -e $CLS_DIR ]; then
 echo "no output binary files" >&2
 exit
fi
echo "output binary files in folder $CLS_DIR"

#clean jar folder
if [ -e jar ]; then
 echo "deleting files jar/*"
 rm -r jar
fi

#backup old jar file
if [ -e $PACKAGE.jar ]; then
 echo "making backup of $PACKAGE.jar"
 mv $PACKAGE.jar $PACKAGE.bak
fi

if [ ! -e package.sh ]; then
 echo "package.sh not found" >&2
 exit
fi

#create directory structure and copy files (package specific)
SCRIPT="$(cat package.sh)"
mkdir jar
cp MANIFEST.MF jar/ 
cd jar
export CLS_DIR="../$CLS_DIR"
eval "$SCRIPT"

#compress files from jar folder to jar file using zip
#cd jar
echo "compressing files..."
#zip must be installed
zip -r ../$PACKAGE.jar *

echo "end"
sleep 1
exit
