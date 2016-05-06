TITLE OFFLINE

.MODEL SMALL

.STACK 100H


.DATA
    
    STR1 DB 80 DUP(0)
    STR2 DB 80 DUP(0) 
    LEN1 DW 0
    LEN2 DW 0
    CNT1 DB 26 DUP(0)
    CNT2 DB 26 DUP(0)
    NEW_LINE DB 0DH,0AH,'$'
    YES DB "YES ! TWO STRINGS ARE ANAGRAM$"
    NO DB "NO ! STRINGS ARE NOT ANAGRAM$"
    
.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX 
    
    LEA DI,STR1
    CALL READ_STR
    MOV LEN1,BX
    
    LEA DX,NEW_LINE
    MOV AH,9
    INT 21H
    
    LEA DI,STR2
    CALL READ_STR
    MOV LEN2,BX
    
    CMP BX,LEN1
    JNE NOT_ANAGRAM 
    
    MOV CX,LEN1
    CLD
    LEA SI,STR1
    CNT_STR1:
        XOR AX,AX
        LODSB
        SUB AL,'a'
        XOR DH,DH
        MOV BX,AX
        MOV DL,CNT1[BX]
        INC DL
        MOV BYTE PTR CNT1[BX],DL
        LOOP CNT_STR1
    MOV CX,LEN2
    LEA SI,STR2
    CNT_STR2:
        XOR AX,AX
        LODSB
        SUB AL,'a'
        XOR DH,DH
        MOV BX,AX
        MOV DL,CNT2[BX]
        INC DL
        MOV BYTE PTR CNT2[BX],DL
        LOOP CNT_STR2
    MOV CX,26
    XOR BX,BX
    CHECK_LOOP:
        MOV AL,CNT1[BX]
        MOV DL,CNT2[BX]
        CMP AL,DL
        JNE NOT_ANAGRAM
        INC BX
        LOOP CHECK_LOOP
    MOV AH,9
    LEA DX,NEW_LINE
    INT 21H
    LEA DX,YES
    INT 21H
    JMP EXIT
    NOT_ANAGRAM:
    MOV AH,9
    LEA DX,NEW_LINE
    INT 21H 
    LEA DX,NO
    INT 21H
    
    
    EXIT:
    MOV AH,4CH
    INT 21H
    
    
    
    
    MAIN ENDP



read_str proc 
    ;reads and store a string
    ;bx number of character read
    
    
    push ax
    push di
    
    cld
    xor bx,bx  
    mov ah,1
    int 21h
    while:
    cmp al,0dh
    je end_while
    cmp al,8h
    jne else
    dec di
    dec bx
    jmp read
    else:
    stosb
    inc bx
    read:
    int 21h
    jmp while
    end_while:
    pop di
    pop ax
    ret
    read_str endp
END MAIN