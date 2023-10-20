section .text
global main

main:
        cmp edi, 2
        js .no_source_file_provided

        extern fopen ; open source code file
        mov rdi, [rsi+8] ; rsi+8 = code filename string
        mov rsi, read_only
        sub rsp, 8
        call fopen
        add rsp, 8

        ; descriptor now in rax
        cmp rax, 0
        jz .failed_to_open_source_file

        mov rdi, rax    ; FILE*

.process_code_char:
        extern fgetc
        push rdi
        call fgetc
        pop rdi

        cmp eax, 0      ; if negative (EOF)
        js .end_of_file
        
        mov rcx, valid_chars
.check_input_chars:
        mov bl, [rcx]

        ; if checked all valid chars and no match.
        cmp bl, 0
        jz .process_code_char

        ; if current char not matching cur valid char
        inc rcx
        cmp bl, al
        jnz .check_input_chars 

        ; if current char is valid
        mov rdx, [cptr]
        mov [rdx], bl   ; store current command in code
        inc qword [cptr]         ; inc code pointer
        jmp .process_code_char

.end_of_file:
        extern puts
        mov rdi, code
        sub rsp, 8
        call puts
        add rsp, 8
        ret

.failed_to_open_source_file:
        mov rdi, failed_to_open_file_msg
        jmp exit_and_report_error

.no_source_file_provided:
        mov rdi, no_source_file_msg
        jmp exit_and_report_error

exit_and_report_error:
        ; recieve error message in rdi,
        ; print and exit with code 1
        extern puts
        sub rsp, 8
        call puts
        add rsp, 8
        
        extern exit
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

        cptr dq code

no_source_file_msg:
        db 'error: no input file', 10, 0
failed_to_open_file_msg:
        db 'error: failed to open source file', 10, 0
read_only:
        db 'r', 0
valid_chars:
        db '+-<>.,[]', 0