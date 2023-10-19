section .text
global main

main:
        cmp edi, 2
        js .no_source_file_provided

        add rsi, 8      ; rsi = code filename string

        extern fopen ; open source code file
        mov rdi, rsi
        mov rsi, read_only
        sub rsp, 8
        call fopen
        add rsp, 8

        ; descriptor now in rax
        cmp rax, 0
        jz .failed_to_open_source_file


.failed_to_open_source_file:
        mov rdi, failed_to_open_file_msg
        jmp exit_and_report_error

.no_source_file_provided:
        mov rdi, no_source_file_msg
        jmp exit_and_report_error

exit_and_report_error:
        ; recieve error message in rdi,
        ; print and exit with code 1
        extern exit, puts
        sub rsp, 8
        call puts
        add rsp, 8

        mov rdi, 1
        sub rsp, 8
        call exit


section .bss
        code resb 1024*1024
        stack resb 1024*1024

section .data

        data times 2*1024*1024 db 0
        dend db 0
        dptr dq data+(1024*1024)

        sptr dq stack
        send dq stack + (1024*1024)

no_source_file_msg:
        db 'error: no input file', 10, 0
failed_to_open_file_msg:
        db 'error: failed to open source file', 10, 0
read_only:
        db 'r', 0