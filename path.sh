
#/!bin/bash
if [ "$1" = "-h" -o "$1" = "--help" -o "" ]; then
    echo This program helps you find path to a file
    echo Type: "./path.sh [fileName]"
    echo Where fileName is the name of the file you want to find
    echo Type: "./path.sh [-h or --help]" to get help
    exit
fi

inHelp=$(help | grep " $1 " | cut -d " " -f 2)

if [[ "$inHelp" != "" ]]; then
    echo Internal command
    exit
fi

if [ -e "$1" ]; then
    echo $1 is an executable file
    echo Path to it: $PWD/$1
    exit
fi

if [ -e "/bin/$1" ]; then
    echo $1 is an external command
    echo Path to it: /bin/$1
    exit
fi

paths=$PATH
for f in $paths
do  #echo $f/$1
    if [ -e "$f/$1" ]; then
        echo $1 is an executable file
        echo Path to it: $f/$1
        exit
    else
        echo Nothing found
        exit
    fi
done
