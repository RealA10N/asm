hello.out: hello.o
	gcc -no-pie -o hello.out hello.o

hello.o:
	nasm -felf64 -o hello.o hello.asm
