section .text
global main

main:
        cmp edi, 2
        js .no_source_file_provided


.no_source_file_provided:
        extern exit, puts
        mov rdi, no_source_file_msg
        sub rsp, 8
        call puts
        add rsp, 8

        mov rdi, 1
        sub rsp, 8
        call exit

section .data

no_source_file_msg:
        db 'error: no input file', 10, 0
