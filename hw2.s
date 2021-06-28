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
        LDR R0, =VALUE
        ; R0: VALUE의 주소를 저장하는 레지스터
        MOV R3, #4
        ; R3: xor_f 영역이 실행되는 횟수

xor_f
        CMP R3, #0
        BEQ decision
        
        LDRB R1, [R0], #1
        ; R1: 32bit의 16진수 숫자를 2자리씩 가져와 저장하는 레지스터
        EOR R2, R2, R1
        ; R2: 2자리씩 가져온 다음 모두 exclusive-OR한 결과 값을 갖게 되는 레지스터
        
        SUB R3, R3, #1
        B xor_f
        
decision
        MOV R5, #1
        /* R5: 상수 1을 의미
           (SUB 명령어의 두 번째 attribute에는 상수가 못들어가므로 레지스터로 했음) */
        
loop
        LSRS R2, R2, #1
        ; LSR을 32번이 아닌 최대 8번해서 홀수인지 짝수인지를 판별할 수 있음
        
        IT CS
        SUBCS R4, R5, R4
        /* R4: 0이면 짝수라는 뜻이고 1이면 홀수라는 뜻임 (핵심!)
           Carry Flag가 1이면 Toggle을 함 (1 -> 0, 0 -> 1),
           'a = 1-a' 공식을 그대로 어셈블리화 한 것임 */
        
        BEQ end
        
        B loop
        
        DATA
VALUE DCD 0x32345678
        
end
        NOP
        END
