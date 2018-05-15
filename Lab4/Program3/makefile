project: asmfile.o cfile.o
	gcc asmfile.o cfile.o -o project

asmfile.o: asmfile.s
	as -o asmfile.o asmfile.s

cfile.o: cfile.c
	gcc -c cfile.c
