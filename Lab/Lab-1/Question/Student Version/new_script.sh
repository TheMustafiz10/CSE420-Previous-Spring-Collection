#!/bin/bash

STUDENT_ID="24341214"

echo "Starting build process..."

# Clean previous builds
rm -f lex.yy.c y.tab.c y.tab.h y.output *.o *.exe ${STUDENT_ID}_log.txt

# Generate parser
bison -d -v ${STUDENT_ID}.y
echo 'Generated the parser C file and header file'

# Compile parser
g++ -w -c -o y.o y.tab.c
echo 'Generated the parser object file'

# Generate scanner
flex ${STUDENT_ID}.l
echo 'Generated the scanner C file'

# Compile scanner
g++ -fpermissive -w -c -o l.o lex.yy.c
echo 'Generated the scanner object file'

# Link
g++ -o ${STUDENT_ID}.exe y.o l.o
echo 'All ready, running...'

# Run with input file
if [ $# -eq 1 ]; then
    ./${STUDENT_ID}.exe $1
else
    echo "Usage: ./script.sh input.txt"
    exit 1
fi
