;
; mmmm    mmmm   mmmm
; #   "m m"  "m #"   "
; #    # #    # "#mmm
; #    # #    #     "#
; #mmm"   #mm#  "mmm#
;nasm -g -f bin -o fb.com fb.asm
org 100h
section .text
  start:
    call read_int
  exit:
    ;exit returning 0
    mov ah, 4Ch
    mov al, 00h
    int 21h

  read_int:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; READ INTEGER FROM STANDARD INPUT  ;
    ; return it in bx registesr         ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov bx, 00h ;bufer for output
    mov cl, 01h ;holding power of ten
    push 0 ;pushing null byte
    ;push input to stack
    ;to make it easy to read it backwards
  loop1:
    ;calling an interput READ CHAR FROM STDIN
    mov ah, 01h
    int 21h
    ;check whether char in al is a number
    ;jump if less than '0'
    cmp al,'0'
    jb save
    ;jump if greater than '9'
    cmp al,'9'
    ja save
  is_number1:
    push ax
    jmp loop1


  save:
    ;pop value frome stack
    pop ax
    ;check if its proper number
    cmp al,'0'
    jb end
    cmp al,'9'
    ja end
    ;substract al - '0' to obtain value
    sub al,'0'
    ;multiply al x cx to obtain proper position
    mul cl
    add bx,ax
    mov ax,cx
    mov dl,0Ah
    mul dl
    mov cx,ax
    jmp save

  end:

    ret

section .data
