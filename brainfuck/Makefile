.PHONY: build

build: bf

bf: bf.o
	gcc -no-pie -o bf bf.o

bf.o:
	nasm -felf64 -o bf.o bf.asm
