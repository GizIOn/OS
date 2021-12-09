#!/bin/bash
re='^[+-]?[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
    echo "Integer expected";
    exit 1;
fi
if [ "$1" = "-h" -o "$1" = "--help" ]; then
    echo "This program counts nth Fibonacci number"
    echo "Type 'bash fib.sh [number]'"
    echo "And you will see the nth Fibonacci number"
    echo "For example:"
    echo "bash fib.sh 4"
    echo "will give you the result of 3"
    exit 0
elif [ "$1" -gt "0" ]; then
    n=$1
    i=0
    f=0;
    s=1;
    r=1;
    while [ $i -lt $n  ]
    do
        t=$f
        ((f+=s))
        s=$t
        ((n--));
        r=$f;
    done;
    echo $r;
elif [ "$1" -eq "0" ]; then echo 0;
else
    echo "Positive integer expected";
    exit 1;
fi
chmod +x fib.sh





