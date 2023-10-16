.PHONY: test build

build: hello

test: hello
	./hello | diff stdout.txt -

hello: hello.o
	gcc -no-pie -o hello hello.o

hello.o:
	nasm -felf64 -o hello.o hello.asm
