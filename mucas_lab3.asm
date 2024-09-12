;
;
; CMSC lab 3
; Cate Gellai A. Mucas
;
;Lab 3: An assembly program that checks whether the year entered by the user is a leap year or not.
;

%include "asm_io.inc"


segment .data 
; prompt and out messages

prompt     db "Enter a year: ", 0
outmsg1    db " is a leap year.", 0
outmsg2    db " is not a leap year.", 0
outmsg3    db "Invalid input try again.", 0


segment .bss
year resd 1



segment .text
		global asm_main

asm_main: 

		enter   0,0               
        pusha

        mov     eax, prompt             ; get year from user
        call    print_string
        call    read_int          
        mov     [year], eax     

        mov     eax, [year]             ; check if user entered a negative input
        cmp     eax, 1
        jl      invalid_year    
        

        mov     eax, [year]             ; check if century year 
        mov     edx, 0
        mov     ebx, 100
        div     ebx
        cmp     edx, 0
        jnz     not_century             ; jump to not_century


        mov     eax, [year]             ; check if century year is leap year 
        mov     edx, 0
        mov     ebx, 400
        div     ebx
        cmp     edx, 0
        jnz     not_leap_year           ; jump to not_leap_year
        jmp     leap_year



        not_century:

            mov     eax, [year]         ; check if not century year is divisible by 4
            mov     edx, 0
            mov     ebx, 4
            div     ebx
            cmp     edx, 0
            jnz     not_leap_year       ; jump to not_leap_year otherwise to leap_year   
            jmp     leap_year
           


        not_leap_year:

            mov     eax, [year]         ;print not leap year
            call    print_int
            mov     eax, outmsg2
            call    print_string
            call    print_nl
            jmp     end_code



        leap_year:                      ; print leap year
            
            mov     eax, [year]
            call    print_int
            mov     eax, outmsg1
            call    print_string
            call    print_nl
            jmp     end_code



        invalid_year:                   ; print input invalid

            mov     eax, outmsg3
            call    print_string
            call    print_nl
            jmp     end_code
            

        end_code: 

            popa
            mov     eax, 0          ; return back to C
            leave                     
            ret




         




