        global  main
        extern  puts
        section .text
main:
        mov rdi, msg
        sub rsp, 8
        call puts
        add rsp, 8
        xor rax, rax
        ret

        section .data
msg:    db 'Hello world!', 0
