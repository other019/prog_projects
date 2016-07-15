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
  
;mov si, bp
;sub si, cx
;mov [si],dx ;asign reminder of division to buffer 
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; WRITE INTEGER TO STANDARD INPUT   ;
    ; FROM BX REGISTER                  ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      %define BUFF_SIZE 6
      %define D [bp-2*BUFF_SIZE]
      %define A [bp-(2*BUFF_SIZE+2)]
      ;create stack frame
      push bp
      mov bp, sp
      push bp
      ;allocating memory on stack for buffer
      sub sp,2*BUFF_SIZE
      ;allocate memory on stack for var I and A
      sub sp,04h
      
      mov A,bx ;save the orginal value
    
    ;setting buff to 0
    mov cx, BUFF_SIZE
    .loop1:
      mov [bp-cx],0
      dec cx
      cmp cx,0
      jz .end_loop1
      jmp .loop1
      
    .end_loop1:
      mov cx,0
      mov bx,10
      
    .loop2:
      mov dx,0
      mov ax,A
      div bx
      mov [bp-cx],dx ;asign reminder of division to buffer
      mov ax,bx
      mul 10
      mob bx,ax
      inc cx
      cmp cx,BUFF_SIZE
      je .end_loop2
      jmp .loop2
      
    .end_loop2:
      mov cx,BUFF_SIZE
      
    .loop3:
      mov bx,[bp-cx]
      mov dx,[bp-cx+1]
      sub bx,dx
      mov [bp-cx],bx
      dec cx
      cmp cx,00h
      jz .end_loop3
      jmp .loop3
      
    .end_loop3:
      mov D, 01h
      mov cx,00h
      
    .loop4:
      mov ax,[bp-cx]
      mov dx,00h
      mov bx,D
      div bx
      mov [bp-cx],ax
      
      mov ax,D
      mul 10
      mov D,ax
      
      inc cx    
      cmp cx,BUFF_SIZE
      je .end_loop4
      jmp .loop4
      
    .end_loop4:
      mov cx,0
      push 0
      
    .loop5:
      mov bx,[bp-cx]
      add bx,30h
      push bx
      inc cx
      cmp cx,BUFF_SIZE
      je .end_loop5
      jmp .loop5
    
    .end_loop5:
      pop bx
      cmp bx,30h
      je .end_loop5
      jmp .write
      
    .write  
      pop bx
      cmp bx,0
      je .end
      mov ah,02h
      mov dl,bl
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
