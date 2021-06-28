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
        ; R0: VALUE�� �ּҸ� �����ϴ� ��������
        MOV R3, #4
        ; R3: xor_f ������ ����Ǵ� Ƚ��

xor_f
        CMP R3, #0
        BEQ decision
        
        LDRB R1, [R0], #1
        ; R1: 32bit�� 16���� ���ڸ� 2�ڸ��� ������ �����ϴ� ��������
        EOR R2, R2, R1
        ; R2: 2�ڸ��� ������ ���� ��� exclusive-OR�� ��� ���� ���� �Ǵ� ��������
        
        SUB R3, R3, #1
        B xor_f
        
decision
        MOV R5, #1
        /* R5: ��� 1�� �ǹ�
           (SUB ��ɾ��� �� ��° attribute���� ����� �����Ƿ� �������ͷ� ����) */
        
loop
        LSRS R2, R2, #1
        ; LSR�� 32���� �ƴ� �ִ� 8���ؼ� Ȧ������ ¦�������� �Ǻ��� �� ����
        
        IT CS
        SUBCS R4, R5, R4
        /* R4: 0�̸� ¦����� ���̰� 1�̸� Ȧ����� ���� (�ٽ�!)
           Carry Flag�� 1�̸� Toggle�� �� (1 -> 0, 0 -> 1),
           'a = 1-a' ������ �״�� �����ȭ �� ���� */
        
        BEQ end
        
        B loop
        
        DATA
VALUE DCD 0x32345678
        
end
        NOP
        END
