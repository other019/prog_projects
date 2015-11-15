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
    call write_int
  exit:
    ;exit returning 0
    mov ah, 4Ch
    mov al, 00h
    int 21h
  write_int:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; WRITE INTEGER TO STANDARD INPUT   ;
    ; FROM BX REGISTER                  ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      mov cl, 01h
      mov ch, 0Ah
      ;create stack frame
      push bp
      mov bp, sp
      push bp
      ;push bx to local variable
      ;reserve 2bytes
      sub esp,02h
      mov WORD[ebp-2],bx ;pushing our number
      push 0
      ;set bl to 4
      mov bl, 04h ;number of places we need
    .loop1:
      mov ax, WORD [ebp-2] ;get our number
      div ch
      push ax
      mov ax,WORD [ebp-2]
      div cl ;;bug jest tutaj trzeba sprawdzic w której połowce co jest po dzielniu
      pop dx
      sub dh, ah
      ; było sub ah,dh
      ;; czy to na pewno zeruję dobrą połówkę
      ;;cos za duzo na stos wrzucam
    
      and ax, 0Fh
      add ax,'0'
      push ax
      mov ax, 00h
      mov al, cl
      mov cl, 0Ah
      mul cl
      mov cl,al
      mov ax, 00h
      mov al, ch
      mov ch, 0Ah
      mul ch
      mov ch,al
      cmp bl,0
      je .write
      dec bl
      jmp .loop1
    .write:
      mov dx,0
      pop dx
      cmp dx, 0
      je .end
      mov ah, 02h
      int 21h
      jmp .write
    .end:
      ;destroy the stack frame
      mov sp, bp
      pop bp
      ret

  read_int:
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; READ INTEGER FROM STANDARD INPUT  ;
  ; return it in bx register          ;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov bx, 00h ;bufer for output
    mov cl, 01h ;holding power of ten
    push 0 ;pushing null byte
    ;push input to stack
    ;to make it easy to read it backwards
  .loop1:
    ;calling an interput READ CHAR FROM STDIN
    mov ah, 01h
    int 21h
    ;check whether char in al is a number
    ;jump if less than '0'
    cmp al,'0'
    jb .save
    ;jump if greater than '9'
    cmp al,'9'
    ja .save
  .is_number1:
    push ax
    jmp .loop1


  .save:
    ;pop value frome stack
    pop ax
    ;check if its proper number
    cmp al,'0'
    jb .end
    cmp al,'9'
    ja .end
    ;substract al - '0' to obtain value
    sub al,'0'
    ;multiply al x cx to obtain proper position
    mul cl
    add bx,ax
    mov ax,cx
    mov dl,0Ah
    mul dl
    mov cx,ax
    jmp .save

  .end:

    ret

section .data
section .bss
