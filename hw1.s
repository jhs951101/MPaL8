        NAME    main
        
        PUBLIC  __iar_program_start
        
        SECTION .intvec : CODE (2)
        THUMB
        
__iar_program_start
        B       main

        
        SECTION .text : CODE (2)
        THUMB

main
        NOP
        
        LDR R2, =data1
        LDR R3, =data2
        LDR R5, =data3
        ; R2, R3, R5 : data1,2,3의 주소를 가지는 레지스터
        
        B loop1
        
loop2
        LSRS R4, R4, #1
        ; R4: 16진수를 4자리씩 소유한 후 계속 LSR한 값을 가지는 레지스터
        ADC R0, R0, #0
        ; R0: data1 숫자들의 1의 갯수를 저장하는 레지스터
        
        BEQ loop1
        ; LSR하다가 값이 0이 되지 않는 한 loop2 영역은 계속 실행됨
        
        B loop2
        
loop4
        LSRS R4, R4, #1
        ADC R1, R1, #0
        ; R1: data2 숫자들의 1의 갯수를 저장하는 레지스터
        
        BEQ loop3
        ; LSR하다가 값이 0이 되지 않는 한 loop4 영역은 계속 실행됨
        
        B loop4
        
loop1  ; loop2 영역과 중첩 loop 관계 (loop2 in loop1)
        CMP R2, R3
        ; R2가 data2의 주소에 도달하지 않는 한 loop1,2 영역은 계속 실행됨
        
        ITT NE
        LDRNE R4, [R2], #4
        BNE loop2
        
loop3  ; loop4 영역과 중첩 loop 관계 (loop4 in loop3)
        CMP R3, R5
        ; R3가 data3의 주소에 도달하지 않는 한 loop1,2 영역은 계속 실행됨
        
        ITT NE
        LDRNE R4, [R3], #4
        BNE loop4
        
decision
        CMP R0, R1
        ; R0가 더 크거나 서로 같으면 FFFF를 저장하고 작으면 1111을 저장함
        
        ITE GE
        MOVGE R9, #0xFFFF
        MOVLT R9, #0x1111
        
        STR R9, [R5]
        B end
        
        DATA
data1 DCD 0x1191, 0x2345, 0x10A0, 0x2456
data2 DCD 0x4467, 0x3001, 0x2010, 0x2111
data3

end
        NOP
        END