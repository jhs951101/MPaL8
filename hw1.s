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
        ; R2, R3, R5 : data1,2,3�� �ּҸ� ������ ��������
        
        B loop1
        
loop2
        LSRS R4, R4, #1
        ; R4: 16������ 4�ڸ��� ������ �� ��� LSR�� ���� ������ ��������
        ADC R0, R0, #0
        ; R0: data1 ���ڵ��� 1�� ������ �����ϴ� ��������
        
        BEQ loop1
        ; LSR�ϴٰ� ���� 0�� ���� �ʴ� �� loop2 ������ ��� �����
        
        B loop2
        
loop4
        LSRS R4, R4, #1
        ADC R1, R1, #0
        ; R1: data2 ���ڵ��� 1�� ������ �����ϴ� ��������
        
        BEQ loop3
        ; LSR�ϴٰ� ���� 0�� ���� �ʴ� �� loop4 ������ ��� �����
        
        B loop4
        
loop1  ; loop2 ������ ��ø loop ���� (loop2 in loop1)
        CMP R2, R3
        ; R2�� data2�� �ּҿ� �������� �ʴ� �� loop1,2 ������ ��� �����
        
        ITT NE
        LDRNE R4, [R2], #4
        BNE loop2
        
loop3  ; loop4 ������ ��ø loop ���� (loop4 in loop3)
        CMP R3, R5
        ; R3�� data3�� �ּҿ� �������� �ʴ� �� loop1,2 ������ ��� �����
        
        ITT NE
        LDRNE R4, [R3], #4
        BNE loop4
        
decision
        CMP R0, R1
        ; R0�� �� ũ�ų� ���� ������ FFFF�� �����ϰ� ������ 1111�� ������
        
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