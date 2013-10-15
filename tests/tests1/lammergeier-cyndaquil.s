.file	"../tests1/lammergeier-cyndaquil.l3"
.globl __c0_main
__c0_assertIsAKeyword:
	addq $-8, %rsp
.assertIsAKeyword_start:
.__c0_assertIsAKeyword_0:
	movl $1, %r9d
	movl $0, %r11d
	movl %r9d, %eax
	cltd
	idivl %r11d
	movl %eax, %r9d
	movl $0, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
__c0_printhexPrints0x:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.printhexPrints0x_start:
	movl %edi, %r8d
.__c0_printhexPrints0x_0:
	movl $0, %ecx
.__c0_printhexPrints0x_54:
	movl %ecx, %edx
.__c0_printhexPrints0x_1:
	cmpl $8, %edx
	jge .__c0_printhexPrints0x_3
.__c0_printhexPrints0x_2:
	movl $7, %ecx
	subl %edx, %ecx
	movl %ecx, %esi
	imull $4, %esi
	movl %r8d, %edi
	movl %esi, %ecx
	sarl %cl, %edi
	movl %edi, %ecx
	andl $15, %ecx
	cmpl $0, %ecx
	jnz .__c0_printhexPrints0x_5
.__c0_printhexPrints0x_4:
	movl $48, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_86:
	jmp .__c0_printhexPrints0x_51
.__c0_printhexPrints0x_5:
	cmpl $1, %ecx
	jnz .__c0_printhexPrints0x_7
.__c0_printhexPrints0x_6:
	movl $49, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_84:
	jmp .__c0_printhexPrints0x_50
.__c0_printhexPrints0x_7:
	cmpl $2, %ecx
	jnz .__c0_printhexPrints0x_9
.__c0_printhexPrints0x_8:
	movl $50, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_82:
	jmp .__c0_printhexPrints0x_49
.__c0_printhexPrints0x_9:
	cmpl $3, %ecx
	jnz .__c0_printhexPrints0x_11
.__c0_printhexPrints0x_10:
	movl $51, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_80:
	jmp .__c0_printhexPrints0x_48
.__c0_printhexPrints0x_11:
	cmpl $4, %ecx
	jnz .__c0_printhexPrints0x_13
.__c0_printhexPrints0x_12:
	movl $52, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_78:
	jmp .__c0_printhexPrints0x_47
.__c0_printhexPrints0x_13:
	cmpl $5, %ecx
	jnz .__c0_printhexPrints0x_15
.__c0_printhexPrints0x_14:
	movl $53, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_76:
	jmp .__c0_printhexPrints0x_46
.__c0_printhexPrints0x_15:
	cmpl $6, %ecx
	jnz .__c0_printhexPrints0x_17
.__c0_printhexPrints0x_16:
	movl $54, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_74:
	jmp .__c0_printhexPrints0x_45
.__c0_printhexPrints0x_17:
	cmpl $7, %ecx
	jnz .__c0_printhexPrints0x_19
.__c0_printhexPrints0x_18:
	movl $55, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_72:
	jmp .__c0_printhexPrints0x_44
.__c0_printhexPrints0x_19:
	cmpl $8, %ecx
	jnz .__c0_printhexPrints0x_21
.__c0_printhexPrints0x_20:
	movl $56, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_70:
	jmp .__c0_printhexPrints0x_43
.__c0_printhexPrints0x_21:
	cmpl $9, %ecx
	jnz .__c0_printhexPrints0x_23
.__c0_printhexPrints0x_22:
	movl $57, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_68:
	jmp .__c0_printhexPrints0x_42
.__c0_printhexPrints0x_23:
	cmpl $10, %ecx
	jnz .__c0_printhexPrints0x_25
.__c0_printhexPrints0x_24:
	movl $97, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_66:
	jmp .__c0_printhexPrints0x_41
.__c0_printhexPrints0x_25:
	cmpl $11, %ecx
	jnz .__c0_printhexPrints0x_27
.__c0_printhexPrints0x_26:
	movl $98, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_64:
	jmp .__c0_printhexPrints0x_40
.__c0_printhexPrints0x_27:
	cmpl $12, %ecx
	jnz .__c0_printhexPrints0x_29
.__c0_printhexPrints0x_28:
	movl $99, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_62:
	jmp .__c0_printhexPrints0x_39
.__c0_printhexPrints0x_29:
	cmpl $13, %ecx
	jnz .__c0_printhexPrints0x_31
.__c0_printhexPrints0x_30:
	movl $100, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_60:
	jmp .__c0_printhexPrints0x_38
.__c0_printhexPrints0x_31:
	cmpl $14, %ecx
	jnz .__c0_printhexPrints0x_33
.__c0_printhexPrints0x_32:
	movl $101, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_58:
	jmp .__c0_printhexPrints0x_37
.__c0_printhexPrints0x_33:
	cmpl $15, %ecx
	jnz .__c0_printhexPrints0x_35
.__c0_printhexPrints0x_34:
	movl $102, %ecx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_56:
	jmp .__c0_printhexPrints0x_36
.__c0_printhexPrints0x_35:
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq __c0_assertIsAKeyword
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
.__c0_printhexPrints0x_55:
.__c0_printhexPrints0x_36:
.__c0_printhexPrints0x_57:
.__c0_printhexPrints0x_37:
.__c0_printhexPrints0x_59:
.__c0_printhexPrints0x_38:
.__c0_printhexPrints0x_61:
.__c0_printhexPrints0x_39:
.__c0_printhexPrints0x_63:
.__c0_printhexPrints0x_40:
.__c0_printhexPrints0x_65:
.__c0_printhexPrints0x_41:
.__c0_printhexPrints0x_67:
.__c0_printhexPrints0x_42:
.__c0_printhexPrints0x_69:
.__c0_printhexPrints0x_43:
.__c0_printhexPrints0x_71:
.__c0_printhexPrints0x_44:
.__c0_printhexPrints0x_73:
.__c0_printhexPrints0x_45:
.__c0_printhexPrints0x_75:
.__c0_printhexPrints0x_46:
.__c0_printhexPrints0x_77:
.__c0_printhexPrints0x_47:
.__c0_printhexPrints0x_79:
.__c0_printhexPrints0x_48:
.__c0_printhexPrints0x_81:
.__c0_printhexPrints0x_49:
.__c0_printhexPrints0x_83:
.__c0_printhexPrints0x_50:
.__c0_printhexPrints0x_85:
.__c0_printhexPrints0x_51:
	movl %edx, %ecx
	addl $1, %ecx
.__c0_printhexPrints0x_53:
	movl %ecx, %edx
	jmp .__c0_printhexPrints0x_1
.__c0_printhexPrints0x_3:
	movl $0, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
	jmp .__c0_printhexPrints0x_36
	jmp .__c0_printhexPrints0x_37
	jmp .__c0_printhexPrints0x_38
	jmp .__c0_printhexPrints0x_39
	jmp .__c0_printhexPrints0x_40
	jmp .__c0_printhexPrints0x_41
	jmp .__c0_printhexPrints0x_42
	jmp .__c0_printhexPrints0x_43
	jmp .__c0_printhexPrints0x_44
	jmp .__c0_printhexPrints0x_45
	jmp .__c0_printhexPrints0x_46
	jmp .__c0_printhexPrints0x_47
	jmp .__c0_printhexPrints0x_48
	jmp .__c0_printhexPrints0x_49
	jmp .__c0_printhexPrints0x_50
	jmp .__c0_printhexPrints0x_51
__c0_Ch:
	addq $-8, %rsp
.Ch_start:
	movl %edi, %r9d
	movl %esi, %r8d
.__c0_Ch_0:
	movl %r9d, %ecx
	andl %r8d, %ecx
	movl $-1, %r8d
	xorl %r9d, %r8d
	movl %r8d, %r9d
	andl %edx, %r9d
	movl %ecx, %r8d
	xorl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
__c0_Parity:
	addq $-8, %rsp
.Parity_start:
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %ecx
.__c0_Parity_0:
	xorl %r8d, %r9d
	xorl %ecx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
__c0_Maj:
	addq $-8, %rsp
.Maj_start:
	movl %edi, %r9d
	movl %esi, %r8d
.__c0_Maj_0:
	movl %r9d, %ecx
	andl %r8d, %ecx
	andl %edx, %r9d
	xorl %r9d, %ecx
	movl %r8d, %r9d
	andl %edx, %r9d
	movl %ecx, %r8d
	xorl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
__c0_f:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.f_start:
	movl %edi, %r8d
	movl %ecx, %edi
.__c0_f_0:
	movl $0, %r11d
	cmpl %r8d, %r11d
	jg .__c0_f_2
.__c0_f_3:
	cmpl $19, %r8d
	jg .__c0_f_2
.__c0_f_1:
	movl %edx, %ecx
	movl %edi, %r8d
	movl %esi, %edi
	movl %ecx, %esi
	movl %r8d, %edx
	movq %r9, %rbx
	callq __c0_Ch
	movq %rbx, %r9
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_f_2:
	movl $20, %r11d
	cmpl %r8d, %r11d
	jg .__c0_f_6
.__c0_f_7:
	cmpl $39, %r8d
	jg .__c0_f_6
.__c0_f_5:
	movl %edx, %ecx
	movl %edi, %r8d
	movl %esi, %edi
	movl %ecx, %esi
	movl %r8d, %edx
	movq %r9, %rbx
	callq __c0_Parity
	movq %rbx, %r9
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_f_6:
	movl $40, %r11d
	cmpl %r8d, %r11d
	jg .__c0_f_10
.__c0_f_11:
	cmpl $59, %r8d
	jg .__c0_f_10
.__c0_f_9:
	movl %edx, %ecx
	movl %edi, %r8d
	movl %esi, %edi
	movl %ecx, %esi
	movl %r8d, %edx
	movq %r9, %rbx
	callq __c0_Maj
	movq %rbx, %r9
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_f_10:
	movl $60, %r11d
	cmpl %r8d, %r11d
	jg .__c0_f_14
.__c0_f_15:
	cmpl $79, %r8d
	jg .__c0_f_14
.__c0_f_13:
	movl %edx, %ecx
	movl %edi, %r8d
	movl %esi, %edi
	movl %ecx, %esi
	movl %r8d, %edx
	movq %r9, %rbx
	callq __c0_Parity
	movq %rbx, %r9
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_f_14:
	movq %r9, %rbx
	callq __c0_assertIsAKeyword
	movq %rbx, %r9
	movl $0, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
	jmp .__c0_f_14
	jmp .__c0_f_10
	jmp .__c0_f_6
	jmp .__c0_f_2
__c0_ROTL:
	addq $-8, %rsp
.ROTL_start:
	movl %edi, %r9d
	movl %esi, %r8d
.__c0_ROTL_0:
	movl $31, %esi
	subl %r9d, %esi
	movl $2147483647, %edx
	movl %esi, %ecx
	sarl %cl, %edx
	movl %r8d, %edi
	movl %r9d, %ecx
	sall %cl, %edi
	movl $32, %esi
	subl %r9d, %esi
	movl %r8d, %r9d
	movl %esi, %ecx
	sarl %cl, %r9d
	movl %r9d, %r8d
	andl %edx, %r8d
	movl %edi, %r9d
	orl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
__c0_K:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.K_start:
	movl %edi, %r8d
.__c0_K_0:
	movl $0, %r11d
	cmpl %r8d, %r11d
	jg .__c0_K_2
.__c0_K_3:
	cmpl $19, %r8d
	jg .__c0_K_2
.__c0_K_1:
	movl $1518500249, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_K_2:
	movl $20, %r11d
	cmpl %r8d, %r11d
	jg .__c0_K_6
.__c0_K_7:
	cmpl $39, %r8d
	jg .__c0_K_6
.__c0_K_5:
	movl $1859775393, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_K_6:
	movl $40, %r11d
	cmpl %r8d, %r11d
	jg .__c0_K_10
.__c0_K_11:
	cmpl $59, %r8d
	jg .__c0_K_10
.__c0_K_9:
	movl $-1894007588, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_K_10:
	movl $60, %r11d
	cmpl %r8d, %r11d
	jg .__c0_K_14
.__c0_K_15:
	cmpl $79, %r8d
	jg .__c0_K_14
.__c0_K_13:
	movl $-899497514, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.__c0_K_14:
	movq %r9, %rbx
	callq __c0_assertIsAKeyword
	movq %rbx, %r9
.__c0_K_17:
.__c0_K_18:
.__c0_K_19:
.__c0_K_20:
	movl $0, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
	jmp .__c0_K_14
	jmp .__c0_K_10
	jmp .__c0_K_6
	jmp .__c0_K_2
__c0_main:
	addq $-1064, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_start:
.__c0_main_0:
	movl $0, %edi
	movl $0, %ecx
	movl $0, %ebx
	movl $0, %r12d
	movl $0, %edx
	movl $1732584193, %r13d
	movl $-271733879, %eax
	movl $-1732584194, %r14d
	movl $271733878, %esi
	movl $-1009589776, %r8d
.__c0_main_438:
	movl %r8d, 708(%rsp)
	movl %esi, 712(%rsp)
	movl %r14d, 716(%rsp)
	movl %eax, 720(%rsp)
	movl %r13d, %r8d
	movl %edx, %eax
	movl %r12d, %r13d
	movl %ebx, %esi
	movl %ecx, %edx
	movl %edi, %ebx
.__c0_main_1:
	cmpl $0, %ebx
	jnz .__c0_main_3
.__c0_main_2:
	movl $0, %r12d
	movl $0, %ecx
.__c0_main_440:
	movl %ecx, %edi
	movl %r12d, 724(%rsp)
	movl %eax, %r12d
	movl %edx, %r14d
	movl %ebx, %r15d
.__c0_main_4:
	cmpl $4, %edi
	jge .__c0_main_6
.__c0_main_5:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %rbx
	callq _eof
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_8
.__c0_main_7:
	movl $1, %r11d
	cmpl %r14d, %r11d
	jnz .__c0_main_10
.__c0_main_9:
	movl $1, %r11d
	cmpl %esi, %r11d
	jnz .__c0_main_12
.__c0_main_11:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_14
.__c0_main_13:
	movl 724(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sarl $29, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_450:
	movl %r15d, %ecx
	jmp .__c0_main_27
.__c0_main_14:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_16
.__c0_main_15:
	movl 724(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sarl $21, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_448:
	movl %r15d, %ecx
	jmp .__c0_main_26
.__c0_main_16:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_18
.__c0_main_17:
	movl 724(%rsp), %ecx
	sall $8, %ecx
	movl %r13d, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_446:
	movl %ecx, %edx
	movl %r15d, %ecx
	jmp .__c0_main_25
.__c0_main_18:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_20
.__c0_main_19:
	movl 724(%rsp), %eax
	sall $8, %eax
	movl %r13d, %ecx
	sarl $5, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %eax, %ecx
	orl %edx, %ecx
.__c0_main_444:
	movl %ecx, %edx
	movl %r15d, %ecx
	jmp .__c0_main_24
.__c0_main_20:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_22
.__c0_main_21:
	movl 724(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sall $3, %ecx
	andl $255, %ecx
	orl %ecx, %edx
	movl $1, %ecx
.__c0_main_442:
	jmp .__c0_main_23
.__c0_main_22:
	movl 724(%rsp), %ecx
	sall $8, %ecx
.__c0_main_441:
	movl %ecx, %edx
	movl %r15d, %ecx
.__c0_main_23:
.__c0_main_443:
.__c0_main_24:
.__c0_main_445:
.__c0_main_25:
.__c0_main_447:
.__c0_main_26:
.__c0_main_449:
.__c0_main_27:
.__c0_main_452:
	movl %edx, %eax
	movl %esi, %edx
	jmp .__c0_main_28
.__c0_main_12:
	movl 724(%rsp), %ecx
	sall $8, %ecx
	movl %r12d, %edx
	addl $1, %edx
	movl %edx, %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	movl %esi, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_451:
	movl %ecx, %eax
	movl %r15d, %ecx
.__c0_main_28:
.__c0_main_454:
	movl %eax, %esi
	movl %edx, %ebp
	movl %r14d, %edx
	jmp .__c0_main_29
.__c0_main_10:
	movl 724(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %esi
	orl $128, %esi
	movl $1, %ecx
	movl %r12d, %edx
	addl $1, %edx
	movl %edx, %ebx
	movl $64, %r11d
	movl %ebx, %eax
	cltd
	idivl %r11d
	movl %edx, %ebx
	movl %ebx, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_453:
	movl %edx, %ebp
	movl %ecx, %edx
	movl %r15d, %ecx
.__c0_main_29:
.__c0_main_456:
	movl %esi, %eax
	movl %r13d, %ebx
	movl %ebp, %esi
	movl %edx, %r14d
	movl %ecx, %r15d
	jmp .__c0_main_30
.__c0_main_8:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %rbx
	callq _readchar
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl 724(%rsp), %ecx
	sall $8, %ecx
	orl %edx, %ecx
	movl %r13d, %edx
	addl $1, %edx
.__c0_main_455:
	movl %ecx, %eax
	movl %edx, %ebx
.__c0_main_30:
	movl %r12d, %edx
	addl $1, %edx
	movl %edi, %ecx
	addl $1, %ecx
.__c0_main_439:
	movl %ecx, %edi
	movl %eax, 724(%rsp)
	movl %edx, %r12d
	movl %ebx, %r13d
	jmp .__c0_main_4
.__c0_main_6:
	movl $0, %ecx
	movl $0, %edx
.__c0_main_458:
	movl %edx, %ebx
	movl %ecx, 728(%rsp)
	movl %esi, %edi
.__c0_main_31:
	cmpl $4, %ebx
	jge .__c0_main_33
.__c0_main_32:
	movq %rdi, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _eof
	movq 52(%rsp), %rdi
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_35
.__c0_main_34:
	movl $1, %r11d
	cmpl %r14d, %r11d
	jnz .__c0_main_37
.__c0_main_36:
	movl $1, %r11d
	cmpl %edi, %r11d
	jnz .__c0_main_39
.__c0_main_38:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_41
.__c0_main_40:
	movl 728(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sarl $29, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_468:
	movl %r15d, %ecx
	jmp .__c0_main_54
.__c0_main_41:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_43
.__c0_main_42:
	movl 728(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sarl $21, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_466:
	movl %r15d, %ecx
	jmp .__c0_main_53
.__c0_main_43:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_45
.__c0_main_44:
	movl 728(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sarl $13, %ecx
	movl %ecx, %esi
	andl $255, %esi
	movl %edx, %ecx
	orl %esi, %ecx
.__c0_main_464:
	movl %r15d, %esi
	jmp .__c0_main_52
.__c0_main_45:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_47
.__c0_main_46:
	movl 728(%rsp), %ecx
	sall $8, %ecx
	movl %r13d, %edx
	sarl $5, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_462:
	movl %r15d, %edx
	jmp .__c0_main_51
.__c0_main_47:
	movl %r12d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_49
.__c0_main_48:
	movl 728(%rsp), %edx
	sall $8, %edx
	movl %r13d, %ecx
	sall $3, %ecx
	andl $255, %ecx
	orl %ecx, %edx
	movl $1, %ecx
.__c0_main_460:
	movl %edx, %esi
	movl %ecx, %edx
	jmp .__c0_main_50
.__c0_main_49:
	movl 728(%rsp), %ecx
	sall $8, %ecx
.__c0_main_459:
	movl %ecx, %esi
	movl %r15d, %edx
.__c0_main_50:
.__c0_main_461:
	movl %esi, %ecx
.__c0_main_51:
.__c0_main_463:
	movl %edx, %esi
.__c0_main_52:
.__c0_main_465:
	movl %ecx, %edx
	movl %esi, %ecx
.__c0_main_53:
.__c0_main_467:
.__c0_main_54:
.__c0_main_470:
	movl %edx, %eax
	movl %edi, %esi
	jmp .__c0_main_55
.__c0_main_39:
	movl 728(%rsp), %ecx
	sall $8, %ecx
	movl %r12d, %edx
	addl $1, %edx
	movl %edx, %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	movl %esi, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_469:
	movl %ecx, %eax
	movl %edx, %esi
	movl %r15d, %ecx
.__c0_main_55:
.__c0_main_472:
	movl %eax, %edx
	movl %r14d, %edi
	jmp .__c0_main_56
.__c0_main_37:
	movl 728(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %esi
	orl $128, %esi
	movl $1, %ecx
	movl %r12d, %edx
	addl $1, %edx
	movl %edx, %edi
	movl $64, %r11d
	movl %edi, %eax
	cltd
	idivl %r11d
	movl %edx, %edi
	cmpl $56, %edi
	setle %dil
	movzbl %dil, %edi
.__c0_main_471:
	movl %esi, %edx
	movl %edi, %esi
	movl %ecx, %edi
	movl %r15d, %ecx
.__c0_main_56:
.__c0_main_474:
	movl %edx, 732(%rsp)
	movl %r13d, %edx
	movl %esi, %ebp
	movl %edi, %esi
	movl %ecx, %eax
	jmp .__c0_main_57
.__c0_main_35:
	movq %rdi, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _readchar
	movq 52(%rsp), %rdi
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl 728(%rsp), %ecx
	sall $8, %ecx
	orl %edx, %ecx
	movl %r13d, %edx
	addl $1, %edx
.__c0_main_473:
	movl %ecx, 732(%rsp)
	movl %edi, %ebp
	movl %r14d, %esi
	movl %r15d, %eax
.__c0_main_57:
	movl %r12d, %edi
	addl $1, %edi
	movl %ebx, %ecx
	addl $1, %ecx
.__c0_main_457:
	movl %ecx, %ebx
	movl 732(%rsp), %r10d
	movl %r10d, 728(%rsp)
	movl %edi, %r12d
	movl %edx, %r13d
	movl %ebp, %edi
	movl %esi, %r14d
	movl %eax, %r15d
	jmp .__c0_main_31
.__c0_main_33:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_476:
	movl %edx, 736(%rsp)
	movl %r12d, %ebx
	movl %r13d, %esi
	movl %r14d, %r12d
	movl %r15d, %r13d
.__c0_main_58:
	cmpl $4, %ecx
	jge .__c0_main_60
.__c0_main_59:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _eof
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_62
.__c0_main_61:
	movl $1, %r11d
	cmpl %r12d, %r11d
	jnz .__c0_main_64
.__c0_main_63:
	movl $1, %r11d
	cmpl %edi, %r11d
	jnz .__c0_main_66
.__c0_main_65:
	movl %ebx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $59, %r14d
	jnz .__c0_main_68
.__c0_main_67:
	movl 736(%rsp), %r14d
	sall $8, %r14d
	movl %esi, %edx
	sarl $29, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %r14d, %edx
	orl %eax, %edx
.__c0_main_486:
	jmp .__c0_main_81
.__c0_main_68:
	movl %ebx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $60, %r14d
	jnz .__c0_main_70
.__c0_main_69:
	movl 736(%rsp), %eax
	sall $8, %eax
	movl %esi, %edx
	sarl $21, %edx
	andl $255, %edx
	orl %edx, %eax
.__c0_main_484:
	movl %eax, %edx
	movl %r13d, %eax
	jmp .__c0_main_80
.__c0_main_70:
	movl %ebx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $61, %r14d
	jnz .__c0_main_72
.__c0_main_71:
	movl 736(%rsp), %eax
	sall $8, %eax
	movl %esi, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %eax
.__c0_main_482:
	movl %eax, %edx
	movl %r13d, %eax
	jmp .__c0_main_79
.__c0_main_72:
	movl %ebx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $62, %r14d
	jnz .__c0_main_74
.__c0_main_73:
	movl 736(%rsp), %eax
	sall $8, %eax
	movl %esi, %edx
	sarl $5, %edx
	movl %edx, %r14d
	andl $255, %r14d
	movl %eax, %edx
	orl %r14d, %edx
.__c0_main_480:
	movl %edx, %eax
	jmp .__c0_main_78
.__c0_main_74:
	movl %ebx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $63, %r14d
	jnz .__c0_main_76
.__c0_main_75:
	movl 736(%rsp), %eax
	sall $8, %eax
	movl %esi, %edx
	sall $3, %edx
	andl $255, %edx
	orl %edx, %eax
	movl $1, %edx
.__c0_main_478:
	jmp .__c0_main_77
.__c0_main_76:
	movl 736(%rsp), %edx
	sall $8, %edx
.__c0_main_477:
	movl %edx, %eax
	movl %r13d, %edx
.__c0_main_77:
.__c0_main_479:
	movl %edx, %r13d
.__c0_main_78:
.__c0_main_481:
	movl %eax, %edx
	movl %r13d, %eax
.__c0_main_79:
.__c0_main_483:
.__c0_main_80:
.__c0_main_485:
	movl %eax, %r13d
.__c0_main_81:
.__c0_main_488:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_82
.__c0_main_66:
	movl 736(%rsp), %edi
	sall $8, %edi
	movl %ebx, %edx
	addl $1, %edx
	movl %edx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	movl %r14d, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_487:
	movl %edi, %eax
.__c0_main_82:
.__c0_main_490:
	movl %eax, %edi
	movl %edx, %r15d
	movl %r12d, %eax
	movl %r13d, %edx
	jmp .__c0_main_83
.__c0_main_64:
	movl 736(%rsp), %edx
	sall $8, %edx
	movl %edx, %edi
	orl $128, %edi
	movl $1, %r12d
	movl %ebx, %edx
	addl $1, %edx
	movl %edx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	movl %r14d, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_489:
	movl %edx, %r15d
	movl %r12d, %eax
	movl %r13d, %edx
.__c0_main_83:
.__c0_main_492:
	movl %edi, %r14d
	movl %r15d, %edi
	jmp .__c0_main_84
.__c0_main_62:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _readchar
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %edx
	movl 736(%rsp), %eax
	sall $8, %eax
	orl %edx, %eax
	movl %esi, %edx
	addl $1, %edx
.__c0_main_491:
	movl %eax, %r14d
	movl %edx, %esi
	movl %r12d, %eax
	movl %r13d, %edx
.__c0_main_84:
	addl $1, %ebx
	addl $1, %ecx
.__c0_main_475:
	movl %r14d, 736(%rsp)
	movl %eax, %r12d
	movl %edx, %r13d
	jmp .__c0_main_58
.__c0_main_60:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_494:
	movl %ecx, %r14d
	movl %edx, 740(%rsp)
	movl %esi, %r15d
	movl %edi, %ebp
	movl %r12d, 732(%rsp)
.__c0_main_85:
	cmpl $4, %r14d
	jge .__c0_main_87
.__c0_main_86:
	movq %r8, 52(%rsp)
	movq %r9, %r12
	callq _eof
	movq 52(%rsp), %r8
	movq %r12, %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_89
.__c0_main_88:
	movl $1, %r11d
	cmpl 732(%rsp), %r11d
	jnz .__c0_main_91
.__c0_main_90:
	movl $1, %r11d
	cmpl %ebp, %r11d
	jnz .__c0_main_93
.__c0_main_92:
	movl %ebx, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_95
.__c0_main_94:
	movl 740(%rsp), %ecx
	sall $8, %ecx
	movl %r15d, %edx
	sarl $29, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_504:
	movl %ecx, %esi
	movl %r13d, %edx
	jmp .__c0_main_108
.__c0_main_95:
	movl %ebx, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_97
.__c0_main_96:
	movl 740(%rsp), %ecx
	sall $8, %ecx
	movl %r15d, %edx
	sarl $21, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_502:
	movl %ecx, %edx
	movl %r13d, %ecx
	jmp .__c0_main_107
.__c0_main_97:
	movl %ebx, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_99
.__c0_main_98:
	movl 740(%rsp), %edx
	sall $8, %edx
	movl %r15d, %ecx
	sarl $13, %ecx
	movl %ecx, %esi
	andl $255, %esi
	movl %edx, %ecx
	orl %esi, %ecx
.__c0_main_500:
	movl %ecx, %edx
	movl %r13d, %ecx
	jmp .__c0_main_106
.__c0_main_99:
	movl %ebx, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_101
.__c0_main_100:
	movl 740(%rsp), %esi
	sall $8, %esi
	movl %r15d, %ecx
	sarl $5, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %esi, %ecx
	orl %edx, %ecx
.__c0_main_498:
	movl %ecx, %edx
	movl %r13d, %ecx
	jmp .__c0_main_105
.__c0_main_101:
	movl %ebx, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_103
.__c0_main_102:
	movl 740(%rsp), %edx
	sall $8, %edx
	movl %r15d, %ecx
	sall $3, %ecx
	andl $255, %ecx
	orl %ecx, %edx
	movl $1, %ecx
.__c0_main_496:
	jmp .__c0_main_104
.__c0_main_103:
	movl 740(%rsp), %ecx
	sall $8, %ecx
.__c0_main_495:
	movl %ecx, %edx
	movl %r13d, %ecx
.__c0_main_104:
.__c0_main_497:
.__c0_main_105:
.__c0_main_499:
.__c0_main_106:
.__c0_main_501:
.__c0_main_107:
.__c0_main_503:
	movl %edx, %esi
	movl %ecx, %edx
.__c0_main_108:
.__c0_main_506:
	movl %ebp, %ecx
	jmp .__c0_main_109
.__c0_main_93:
	movl 740(%rsp), %ecx
	sall $8, %ecx
	movl %ebx, %edx
	addl $1, %edx
	movl %edx, %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	movl %esi, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_505:
	movl %ecx, %esi
	movl %edx, %ecx
	movl %r13d, %edx
.__c0_main_109:
.__c0_main_508:
	movl %esi, %edi
	movl %ecx, %eax
	movl 732(%rsp), %ecx
	jmp .__c0_main_110
.__c0_main_91:
	movl 740(%rsp), %ecx
	sall $8, %ecx
	orl $128, %ecx
	movl $1, %esi
	movl %ebx, %edx
	addl $1, %edx
	movl %edx, %edi
	movl $64, %r11d
	movl %edi, %eax
	cltd
	idivl %r11d
	movl %edx, %edi
	movl %edi, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_507:
	movl %ecx, %edi
	movl %edx, %eax
	movl %esi, %ecx
	movl %r13d, %edx
.__c0_main_110:
.__c0_main_510:
	movl %r15d, %r12d
	movl %edx, %esi
	jmp .__c0_main_111
.__c0_main_89:
	movq %r8, 52(%rsp)
	movq %r9, %r12
	callq _readchar
	movq 52(%rsp), %r8
	movq %r12, %r9
	movl %eax, %ecx
	movl 740(%rsp), %edx
	sall $8, %edx
	orl %ecx, %edx
	movl %r15d, %ecx
	addl $1, %ecx
.__c0_main_509:
	movl %edx, %edi
	movl %ecx, %r12d
	movl %ebp, %eax
	movl 732(%rsp), %ecx
	movl %r13d, %esi
.__c0_main_111:
	movl %ebx, %edx
	addl $1, %edx
	movl %r14d, %ebx
	addl $1, %ebx
.__c0_main_493:
	movl %ebx, %r14d
	movl %edi, 740(%rsp)
	movl %edx, %ebx
	movl %r12d, %r15d
	movl %eax, %ebp
	movl %ecx, 732(%rsp)
	movl %esi, %r13d
	jmp .__c0_main_85
.__c0_main_87:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_512:
	movl %edx, 744(%rsp)
	movl %ebx, %esi
	movl %r15d, %edi
	movl %ebp, %r12d
	movl 732(%rsp), %ebx
.__c0_main_112:
	cmpl $4, %ecx
	jge .__c0_main_114
.__c0_main_113:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _eof
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_116
.__c0_main_115:
	movl $1, %r11d
	cmpl %ebx, %r11d
	jnz .__c0_main_118
.__c0_main_117:
	movl $1, %r11d
	cmpl %r12d, %r11d
	jnz .__c0_main_120
.__c0_main_119:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $59, %r14d
	jnz .__c0_main_122
.__c0_main_121:
	movl 744(%rsp), %edx
	sall $8, %edx
	movl %edi, %eax
	sarl $29, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_522:
	movl %edx, %eax
	movl %r13d, %edx
	jmp .__c0_main_135
.__c0_main_122:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $60, %r14d
	jnz .__c0_main_124
.__c0_main_123:
	movl 744(%rsp), %edx
	sall $8, %edx
	movl %edi, %eax
	sarl $21, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_520:
	movl %edx, %eax
	movl %r13d, %edx
	jmp .__c0_main_134
.__c0_main_124:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $61, %r14d
	jnz .__c0_main_126
.__c0_main_125:
	movl 744(%rsp), %eax
	sall $8, %eax
	movl %edi, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %eax
.__c0_main_518:
	movl %r13d, %edx
	jmp .__c0_main_133
.__c0_main_126:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $62, %r14d
	jnz .__c0_main_128
.__c0_main_127:
	movl 744(%rsp), %edx
	sall $8, %edx
	movl %edi, %eax
	sarl $5, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_516:
	movl %edx, %eax
	movl %r13d, %edx
	jmp .__c0_main_132
.__c0_main_128:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $63, %r14d
	jnz .__c0_main_130
.__c0_main_129:
	movl 744(%rsp), %eax
	sall $8, %eax
	movl %edi, %edx
	sall $3, %edx
	andl $255, %edx
	orl %edx, %eax
	movl $1, %edx
.__c0_main_514:
	jmp .__c0_main_131
.__c0_main_130:
	movl 744(%rsp), %edx
	sall $8, %edx
.__c0_main_513:
	movl %edx, %eax
	movl %r13d, %edx
.__c0_main_131:
.__c0_main_515:
.__c0_main_132:
.__c0_main_517:
.__c0_main_133:
.__c0_main_519:
.__c0_main_134:
.__c0_main_521:
.__c0_main_135:
.__c0_main_524:
	movl %r12d, %r15d
	movl %edx, %r12d
	jmp .__c0_main_136
.__c0_main_120:
	movl 744(%rsp), %r12d
	sall $8, %r12d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	movl %r14d, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_523:
	movl %r12d, %eax
	movl %edx, %r15d
	movl %r13d, %r12d
.__c0_main_136:
.__c0_main_526:
	movl %eax, %r14d
	movl %r15d, %edx
	movl %ebx, %eax
	movl %r12d, %ebx
	jmp .__c0_main_137
.__c0_main_118:
	movl 744(%rsp), %edx
	sall $8, %edx
	movl %edx, %ebx
	orl $128, %ebx
	movl $1, %r12d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	movl %r14d, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_525:
	movl %ebx, %r14d
	movl %r12d, %eax
	movl %r13d, %ebx
.__c0_main_137:
.__c0_main_528:
	movl %edx, %r12d
	movl %ebx, %edx
	jmp .__c0_main_138
.__c0_main_116:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _readchar
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl 744(%rsp), %edx
	sall $8, %edx
	orl %eax, %edx
	addl $1, %edi
.__c0_main_527:
	movl %edx, %r14d
	movl %ebx, %eax
	movl %r13d, %edx
.__c0_main_138:
	addl $1, %esi
	addl $1, %ecx
.__c0_main_511:
	movl %r14d, 744(%rsp)
	movl %eax, %ebx
	movl %edx, %r13d
	jmp .__c0_main_112
.__c0_main_114:
	movl $0, %ecx
	movl $0, %edx
.__c0_main_530:
	movl %edx, %r14d
	movl %ecx, 748(%rsp)
.__c0_main_139:
	cmpl $4, %r14d
	jge .__c0_main_141
.__c0_main_140:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _eof
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_143
.__c0_main_142:
	movl $1, %r11d
	cmpl %ebx, %r11d
	jnz .__c0_main_145
.__c0_main_144:
	movl $1, %r11d
	cmpl %r12d, %r11d
	jnz .__c0_main_147
.__c0_main_146:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_149
.__c0_main_148:
	movl 748(%rsp), %ecx
	sall $8, %ecx
	movl %edi, %edx
	sarl $29, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_540:
	movl %r13d, %edx
	jmp .__c0_main_162
.__c0_main_149:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_151
.__c0_main_150:
	movl 748(%rsp), %ecx
	sall $8, %ecx
	movl %edi, %edx
	sarl $21, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_538:
	movl %r13d, %edx
	jmp .__c0_main_161
.__c0_main_151:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_153
.__c0_main_152:
	movl 748(%rsp), %ecx
	sall $8, %ecx
	movl %edi, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_536:
	movl %r13d, %edx
	jmp .__c0_main_160
.__c0_main_153:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_155
.__c0_main_154:
	movl 748(%rsp), %eax
	sall $8, %eax
	movl %edi, %ecx
	sarl $5, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %eax, %ecx
	orl %edx, %ecx
.__c0_main_534:
	movl %ecx, %edx
	movl %r13d, %eax
	jmp .__c0_main_159
.__c0_main_155:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_157
.__c0_main_156:
	movl 748(%rsp), %edx
	sall $8, %edx
	movl %edi, %ecx
	sall $3, %ecx
	movl %ecx, %eax
	andl $255, %eax
	movl %edx, %ecx
	orl %eax, %ecx
	movl $1, %eax
.__c0_main_532:
	movl %ecx, %edx
	movl %eax, %ecx
	jmp .__c0_main_158
.__c0_main_157:
	movl 748(%rsp), %ecx
	sall $8, %ecx
.__c0_main_531:
	movl %ecx, %edx
	movl %r13d, %ecx
.__c0_main_158:
.__c0_main_533:
	movl %ecx, %eax
.__c0_main_159:
.__c0_main_535:
	movl %edx, %ecx
	movl %eax, %edx
.__c0_main_160:
.__c0_main_537:
.__c0_main_161:
.__c0_main_539:
.__c0_main_162:
.__c0_main_542:
	movl %r12d, %eax
	jmp .__c0_main_163
.__c0_main_147:
	movl 748(%rsp), %ecx
	sall $8, %ecx
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r12d
	movl $64, %r11d
	movl %r12d, %eax
	cltd
	idivl %r11d
	movl %edx, %r12d
	movl %r12d, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_541:
	movl %edx, %eax
	movl %r13d, %edx
.__c0_main_163:
.__c0_main_544:
	movl %ecx, %r12d
	movl %ebx, %ecx
	jmp .__c0_main_164
.__c0_main_145:
	movl 748(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %ebx
	orl $128, %ebx
	movl $1, %ecx
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r12d
	movl $64, %r11d
	movl %r12d, %eax
	cltd
	idivl %r11d
	movl %edx, %r12d
	movl %r12d, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_543:
	movl %ebx, %r12d
	movl %edx, %eax
	movl %r13d, %edx
.__c0_main_164:
.__c0_main_546:
	movl %r12d, %r15d
	movl %eax, %r12d
	movl %ecx, %eax
	jmp .__c0_main_165
.__c0_main_143:
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _readchar
	movq 52(%rsp), %rdi
	movq 60(%rsp), %rsi
	movq %rbp, %r8
	movq %r15, %r9
	movl 748(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %edx
	orl %eax, %edx
	movl %edi, %ecx
	addl $1, %ecx
.__c0_main_545:
	movl %edx, %r15d
	movl %ecx, %edi
	movl %ebx, %eax
	movl %r13d, %edx
.__c0_main_165:
	movl %esi, %ecx
	addl $1, %ecx
	movl %r14d, %esi
	addl $1, %esi
.__c0_main_529:
	movl %esi, %r14d
	movl %r15d, 748(%rsp)
	movl %ecx, %esi
	movl %eax, %ebx
	movl %edx, %r13d
	jmp .__c0_main_139
.__c0_main_141:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_548:
	movl %ecx, %r14d
	movl %edx, 752(%rsp)
	movl %esi, %r15d
	movl %edi, %ebp
	movl %r12d, %edi
	movl %ebx, 732(%rsp)
	movl %r13d, 756(%rsp)
.__c0_main_166:
	cmpl $4, %r14d
	jge .__c0_main_168
.__c0_main_167:
	movq %rdi, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _eof
	movq %r13, %rdi
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_170
.__c0_main_169:
	movl $1, %r11d
	cmpl 732(%rsp), %r11d
	jnz .__c0_main_172
.__c0_main_171:
	movl $1, %r11d
	cmpl %edi, %r11d
	jnz .__c0_main_174
.__c0_main_173:
	movl %r15d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_176
.__c0_main_175:
	movl 752(%rsp), %ecx
	sall $8, %ecx
	movl %ebp, %edx
	sarl $29, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_558:
	movl %ecx, %edx
	movl 756(%rsp), %esi
	jmp .__c0_main_189
.__c0_main_176:
	movl %r15d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_178
.__c0_main_177:
	movl 752(%rsp), %esi
	sall $8, %esi
	movl %ebp, %ecx
	sarl $21, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %esi, %ecx
	orl %edx, %ecx
.__c0_main_556:
	movl %ecx, %edx
	movl 756(%rsp), %ecx
	jmp .__c0_main_188
.__c0_main_178:
	movl %r15d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_180
.__c0_main_179:
	movl 752(%rsp), %edx
	sall $8, %edx
	movl %ebp, %ecx
	sarl $13, %ecx
	movl %ecx, %esi
	andl $255, %esi
	movl %edx, %ecx
	orl %esi, %ecx
.__c0_main_554:
	movl %ecx, %edx
	movl 756(%rsp), %ecx
	jmp .__c0_main_187
.__c0_main_180:
	movl %r15d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_182
.__c0_main_181:
	movl 752(%rsp), %edx
	sall $8, %edx
	movl %ebp, %ecx
	sarl $5, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_552:
	movl 756(%rsp), %ecx
	jmp .__c0_main_186
.__c0_main_182:
	movl %r15d, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_184
.__c0_main_183:
	movl 752(%rsp), %ecx
	sall $8, %ecx
	movl %ebp, %edx
	sall $3, %edx
	andl $255, %edx
	movl %ecx, %esi
	orl %edx, %esi
	movl $1, %ecx
.__c0_main_550:
	movl %esi, %edx
	jmp .__c0_main_185
.__c0_main_184:
	movl 752(%rsp), %ecx
	sall $8, %ecx
.__c0_main_549:
	movl %ecx, %edx
	movl 756(%rsp), %ecx
.__c0_main_185:
.__c0_main_551:
.__c0_main_186:
.__c0_main_553:
.__c0_main_187:
.__c0_main_555:
.__c0_main_188:
.__c0_main_557:
	movl %ecx, %esi
.__c0_main_189:
.__c0_main_560:
	movl %edi, %ecx
	jmp .__c0_main_190
.__c0_main_174:
	movl 752(%rsp), %ecx
	sall $8, %ecx
	movl %r15d, %edx
	addl $1, %edx
	movl %edx, %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	cmpl $0, %esi
	sete %sil
	movzbl %sil, %esi
.__c0_main_559:
	movl %ecx, %edx
	movl %esi, %ecx
	movl 756(%rsp), %esi
.__c0_main_190:
.__c0_main_562:
	movl %edx, %edi
	movl %ecx, %edx
	movl 732(%rsp), %ebx
	jmp .__c0_main_191
.__c0_main_172:
	movl 752(%rsp), %ecx
	sall $8, %ecx
	orl $128, %ecx
	movl $1, %esi
	movl %r15d, %edx
	addl $1, %edx
	movl %edx, %edi
	movl $64, %r11d
	movl %edi, %eax
	cltd
	idivl %r11d
	movl %edx, %edi
	movl %edi, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_561:
	movl %ecx, %edi
	movl %esi, %ebx
	movl 756(%rsp), %esi
.__c0_main_191:
.__c0_main_564:
	movl %edi, %eax
	movl %ebp, %ecx
	movl %edx, %r12d
	movl %ebx, %edx
	jmp .__c0_main_192
.__c0_main_170:
	movq %rdi, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _readchar
	movq %r13, %rdi
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl 752(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %esi
	orl %edx, %esi
	movl %ebp, %ecx
	addl $1, %ecx
.__c0_main_563:
	movl %esi, %eax
	movl %edi, %r12d
	movl 732(%rsp), %edx
	movl 756(%rsp), %esi
.__c0_main_192:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %ebx
	addl $1, %ebx
.__c0_main_547:
	movl %ebx, %r14d
	movl %eax, 752(%rsp)
	movl %edi, %r15d
	movl %ecx, %ebp
	movl %r12d, %edi
	movl %edx, 732(%rsp)
	movl %esi, 756(%rsp)
	jmp .__c0_main_166
.__c0_main_168:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_566:
	movl %edx, %ebx
	movl %r15d, %esi
	movl %ebp, %r12d
	movl 732(%rsp), %r13d
	movl 756(%rsp), %r15d
.__c0_main_193:
	cmpl $4, %ecx
	jge .__c0_main_195
.__c0_main_194:
	movq %rdi, 68(%rsp)
	movq %rsi, 52(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _eof
	movq 68(%rsp), %rdi
	movq 52(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_197
.__c0_main_196:
	movl $1, %r11d
	cmpl %r13d, %r11d
	jnz .__c0_main_199
.__c0_main_198:
	movl $1, %r11d
	cmpl %edi, %r11d
	jnz .__c0_main_201
.__c0_main_200:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $59, %r14d
	jnz .__c0_main_203
.__c0_main_202:
	movl %ebx, %eax
	sall $8, %eax
	movl %r12d, %edx
	sarl $29, %edx
	andl $255, %edx
	orl %edx, %eax
.__c0_main_576:
	movl %r15d, %edx
	jmp .__c0_main_216
.__c0_main_203:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $60, %r14d
	jnz .__c0_main_205
.__c0_main_204:
	movl %ebx, %edx
	sall $8, %edx
	movl %r12d, %eax
	sarl $21, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_574:
	movl %edx, %eax
	movl %r15d, %edx
	jmp .__c0_main_215
.__c0_main_205:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $61, %r14d
	jnz .__c0_main_207
.__c0_main_206:
	movl %ebx, %eax
	sall $8, %eax
	movl %r12d, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %eax
.__c0_main_572:
	movl %r15d, %edx
	jmp .__c0_main_214
.__c0_main_207:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $62, %r14d
	jnz .__c0_main_209
.__c0_main_208:
	movl %ebx, %edx
	sall $8, %edx
	movl %r12d, %eax
	sarl $5, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_570:
	movl %edx, %eax
	movl %r15d, %edx
	jmp .__c0_main_213
.__c0_main_209:
	movl %esi, %r14d
	movl $64, %r11d
	movl %r14d, %eax
	cltd
	idivl %r11d
	movl %edx, %r14d
	cmpl $63, %r14d
	jnz .__c0_main_211
.__c0_main_210:
	movl %ebx, %eax
	sall $8, %eax
	movl %r12d, %edx
	sall $3, %edx
	andl $255, %edx
	orl %edx, %eax
	movl $1, %edx
.__c0_main_568:
	jmp .__c0_main_212
.__c0_main_211:
	movl %ebx, %edx
	sall $8, %edx
.__c0_main_567:
	movl %edx, %eax
	movl %r15d, %edx
.__c0_main_212:
.__c0_main_569:
.__c0_main_213:
.__c0_main_571:
.__c0_main_214:
.__c0_main_573:
.__c0_main_215:
.__c0_main_575:
.__c0_main_216:
.__c0_main_578:
	jmp .__c0_main_217
.__c0_main_201:
	movl %ebx, %edi
	sall $8, %edi
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebx
	movl $64, %r11d
	movl %ebx, %eax
	cltd
	idivl %r11d
	movl %edx, %ebx
	movl %ebx, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_577:
	movl %edi, %eax
	movl %edx, %edi
	movl %r15d, %edx
.__c0_main_217:
.__c0_main_580:
	movl %eax, %r14d
	movl %edi, %eax
	movl %r13d, %edi
	movl %edx, %ebx
	jmp .__c0_main_218
.__c0_main_199:
	movl %ebx, %edx
	sall $8, %edx
	movl %edx, %edi
	orl $128, %edi
	movl $1, %ebx
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	movl %r13d, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_579:
	movl %edi, %r14d
	movl %edx, %eax
	movl %ebx, %edi
	movl %r15d, %ebx
.__c0_main_218:
.__c0_main_582:
	movl %r14d, %edx
	movl %eax, %r14d
	movl %edi, %r13d
	movl %ebx, %eax
	jmp .__c0_main_219
.__c0_main_197:
	movq %rdi, 68(%rsp)
	movq %rsi, 52(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _readchar
	movq 68(%rsp), %rdi
	movq 52(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %ebx, %edx
	sall $8, %edx
	orl %eax, %edx
	movl %r12d, %eax
	addl $1, %eax
.__c0_main_581:
	movl %eax, %r12d
	movl %edi, %r14d
	movl %r15d, %eax
.__c0_main_219:
	addl $1, %esi
	addl $1, %ecx
.__c0_main_565:
	movl %edx, %ebx
	movl %r14d, %edi
	movl %eax, %r15d
	jmp .__c0_main_193
.__c0_main_195:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_584:
	movl %edx, %r14d
	movl %edi, %ebp
	movl %r13d, %edi
	movl %r15d, %r13d
.__c0_main_220:
	cmpl $4, %ecx
	jge .__c0_main_222
.__c0_main_221:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %r15
	callq _eof
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %r15, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_224
.__c0_main_223:
	movl $1, %r11d
	cmpl %edi, %r11d
	jnz .__c0_main_226
.__c0_main_225:
	movl $1, %r11d
	cmpl %ebp, %r11d
	jnz .__c0_main_228
.__c0_main_227:
	movl %esi, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	cmpl $59, %r15d
	jnz .__c0_main_230
.__c0_main_229:
	movl %r14d, %edx
	sall $8, %edx
	movl %r12d, %eax
	sarl $29, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_594:
	movl %edx, %eax
	movl %r13d, %edx
	jmp .__c0_main_243
.__c0_main_230:
	movl %esi, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	cmpl $60, %r15d
	jnz .__c0_main_232
.__c0_main_231:
	movl %r14d, %eax
	sall $8, %eax
	movl %r12d, %edx
	sarl $21, %edx
	movl %edx, %r14d
	andl $255, %r14d
	movl %eax, %edx
	orl %r14d, %edx
.__c0_main_592:
	movl %edx, %eax
	movl %r13d, %edx
	jmp .__c0_main_242
.__c0_main_232:
	movl %esi, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	cmpl $61, %r15d
	jnz .__c0_main_234
.__c0_main_233:
	movl %r14d, %edx
	sall $8, %edx
	movl %r12d, %eax
	sarl $13, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_590:
	movl %edx, %r14d
	movl %r13d, %edx
	jmp .__c0_main_241
.__c0_main_234:
	movl %esi, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	cmpl $62, %r15d
	jnz .__c0_main_236
.__c0_main_235:
	movl %r14d, %edx
	sall $8, %edx
	movl %r12d, %eax
	sarl $5, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_588:
	movl %r13d, %eax
	jmp .__c0_main_240
.__c0_main_236:
	movl %esi, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	cmpl $63, %r15d
	jnz .__c0_main_238
.__c0_main_237:
	movl %r14d, %eax
	sall $8, %eax
	movl %r12d, %edx
	sall $3, %edx
	andl $255, %edx
	orl %edx, %eax
	movl $1, %edx
.__c0_main_586:
	movl %edx, %r13d
	jmp .__c0_main_239
.__c0_main_238:
	movl %r14d, %edx
	sall $8, %edx
.__c0_main_585:
	movl %edx, %eax
.__c0_main_239:
.__c0_main_587:
	movl %eax, %edx
	movl %r13d, %eax
.__c0_main_240:
.__c0_main_589:
	movl %edx, %r14d
	movl %eax, %edx
.__c0_main_241:
.__c0_main_591:
	movl %r14d, %eax
.__c0_main_242:
.__c0_main_593:
.__c0_main_243:
.__c0_main_596:
	movl %eax, %r14d
	movl %ebp, %r15d
	movl %edx, %eax
	jmp .__c0_main_244
.__c0_main_228:
	sall $8, %r14d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	movl %r15d, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_595:
	movl %edx, %r15d
	movl %r13d, %eax
.__c0_main_244:
.__c0_main_598:
	movl %r14d, %edx
	movl %eax, %r13d
	jmp .__c0_main_245
.__c0_main_226:
	movl %r14d, %edx
	sall $8, %edx
	movl %edx, %edi
	orl $128, %edi
	movl $1, %r14d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	movl %r15d, %eax
	cmpl $56, %eax
	setle %al
	movzbl %al, %eax
.__c0_main_597:
	movl %edi, %edx
	movl %eax, %r15d
	movl %r14d, %edi
.__c0_main_245:
.__c0_main_600:
	movl %edx, %r14d
	movl %r12d, %edx
	movl %r15d, %eax
	jmp .__c0_main_246
.__c0_main_224:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %r15
	callq _readchar
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %r15, %r9
	movl %eax, %edx
	movl %r14d, %eax
	sall $8, %eax
	orl %edx, %eax
	movl %r12d, %edx
	addl $1, %edx
.__c0_main_599:
	movl %eax, %r14d
	movl %ebp, %eax
.__c0_main_246:
	addl $1, %esi
	addl $1, %ecx
.__c0_main_583:
	movl %edx, %r12d
	movl %eax, %ebp
	jmp .__c0_main_220
.__c0_main_222:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_602:
	movl %edx, 760(%rsp)
	movl %ebp, %r15d
	movl %edi, %ebp
	movl %r13d, %edi
.__c0_main_247:
	cmpl $4, %ecx
	jge .__c0_main_249
.__c0_main_248:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %r13
	callq _eof
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %r13, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_251
.__c0_main_250:
	movl $1, %r11d
	cmpl %ebp, %r11d
	jnz .__c0_main_253
.__c0_main_252:
	movl $1, %r11d
	cmpl %r15d, %r11d
	jnz .__c0_main_255
.__c0_main_254:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $59, %r13d
	jnz .__c0_main_257
.__c0_main_256:
	movl 760(%rsp), %edx
	sall $8, %edx
	movl %r12d, %eax
	sarl $29, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_612:
	jmp .__c0_main_270
.__c0_main_257:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $60, %r13d
	jnz .__c0_main_259
.__c0_main_258:
	movl 760(%rsp), %eax
	sall $8, %eax
	movl %r12d, %edx
	sarl $21, %edx
	movl %edx, %r13d
	andl $255, %r13d
	movl %eax, %edx
	orl %r13d, %edx
.__c0_main_610:
	jmp .__c0_main_269
.__c0_main_259:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $61, %r13d
	jnz .__c0_main_261
.__c0_main_260:
	movl 760(%rsp), %eax
	sall $8, %eax
	movl %r12d, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %eax
.__c0_main_608:
	movl %eax, %edx
	jmp .__c0_main_268
.__c0_main_261:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $62, %r13d
	jnz .__c0_main_263
.__c0_main_262:
	movl 760(%rsp), %r13d
	sall $8, %r13d
	movl %r12d, %edx
	sarl $5, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %r13d, %edx
	orl %eax, %edx
.__c0_main_606:
	jmp .__c0_main_267
.__c0_main_263:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $63, %r13d
	jnz .__c0_main_265
.__c0_main_264:
	movl 760(%rsp), %edi
	sall $8, %edi
	movl %r12d, %edx
	sall $3, %edx
	andl $255, %edx
	orl %edx, %edi
	movl $1, %edx
.__c0_main_604:
	movl %edi, %eax
	movl %edx, %edi
	jmp .__c0_main_266
.__c0_main_265:
	movl 760(%rsp), %edx
	sall $8, %edx
.__c0_main_603:
	movl %edx, %eax
.__c0_main_266:
.__c0_main_605:
	movl %eax, %edx
.__c0_main_267:
.__c0_main_607:
.__c0_main_268:
.__c0_main_609:
.__c0_main_269:
.__c0_main_611:
.__c0_main_270:
.__c0_main_614:
	movl %edx, %eax
	movl %r15d, %edx
	jmp .__c0_main_271
.__c0_main_255:
	movl 760(%rsp), %r13d
	sall $8, %r13d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	movl %r15d, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_613:
	movl %r13d, %eax
.__c0_main_271:
.__c0_main_616:
	movl %eax, %r13d
	movl %ebp, %eax
	jmp .__c0_main_272
.__c0_main_253:
	movl 760(%rsp), %edx
	sall $8, %edx
	movl %edx, %r13d
	orl $128, %r13d
	movl $1, %r15d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	movl %ebp, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_615:
	movl %r15d, %eax
.__c0_main_272:
.__c0_main_618:
	movl %r13d, 732(%rsp)
	movl %edx, %r13d
	jmp .__c0_main_273
.__c0_main_251:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %r13
	callq _readchar
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %r13, %r9
	movl 760(%rsp), %edx
	sall $8, %edx
	orl %eax, %edx
	movl %r12d, %eax
	addl $1, %eax
.__c0_main_617:
	movl %edx, 732(%rsp)
	movl %eax, %r12d
	movl %r15d, %r13d
	movl %ebp, %eax
.__c0_main_273:
	movl %esi, %edx
	addl $1, %edx
	addl $1, %ecx
.__c0_main_601:
	movl 732(%rsp), %r10d
	movl %r10d, 760(%rsp)
	movl %edx, %esi
	movl %r13d, %r15d
	movl %eax, %ebp
	jmp .__c0_main_247
.__c0_main_249:
	movl $0, %ecx
	movl $0, %edx
.__c0_main_620:
	movl %edx, %r13d
	movl %ecx, 764(%rsp)
.__c0_main_274:
	cmpl $4, %r13d
	jge .__c0_main_276
.__c0_main_275:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, 60(%rsp)
	callq _eof
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %r8
	movq 60(%rsp), %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_278
.__c0_main_277:
	movl $1, %r11d
	cmpl %ebp, %r11d
	jnz .__c0_main_280
.__c0_main_279:
	movl $1, %r11d
	cmpl %r15d, %r11d
	jnz .__c0_main_282
.__c0_main_281:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_284
.__c0_main_283:
	movl 764(%rsp), %eax
	sall $8, %eax
	movl %r12d, %ecx
	sarl $29, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %eax, %ecx
	orl %edx, %ecx
.__c0_main_630:
	movl %ecx, %edx
	movl %edi, %ecx
	jmp .__c0_main_297
.__c0_main_284:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_286
.__c0_main_285:
	movl 764(%rsp), %ecx
	sall $8, %ecx
	movl %r12d, %edx
	sarl $21, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_628:
	movl %ecx, %edx
	movl %edi, %ecx
	jmp .__c0_main_296
.__c0_main_286:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_288
.__c0_main_287:
	movl 764(%rsp), %ecx
	sall $8, %ecx
	movl %r12d, %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_626:
	jmp .__c0_main_295
.__c0_main_288:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_290
.__c0_main_289:
	movl 764(%rsp), %ecx
	sall $8, %ecx
	movl %r12d, %edx
	sarl $5, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_624:
	movl %edi, %edx
	jmp .__c0_main_294
.__c0_main_290:
	movl %esi, %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_292
.__c0_main_291:
	movl 764(%rsp), %edi
	sall $8, %edi
	movl %r12d, %ecx
	sall $3, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %edi, %ecx
	orl %edx, %ecx
	movl $1, %edx
.__c0_main_622:
	jmp .__c0_main_293
.__c0_main_292:
	movl 764(%rsp), %ecx
	sall $8, %ecx
.__c0_main_621:
	movl %edi, %edx
.__c0_main_293:
.__c0_main_623:
.__c0_main_294:
.__c0_main_625:
	movl %edx, %edi
.__c0_main_295:
.__c0_main_627:
	movl %ecx, %edx
	movl %edi, %ecx
.__c0_main_296:
.__c0_main_629:
.__c0_main_297:
.__c0_main_632:
	movl %edx, %eax
	movl %r15d, %edx
	jmp .__c0_main_298
.__c0_main_282:
	movl 764(%rsp), %ecx
	sall $8, %ecx
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	movl %r15d, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_631:
	movl %ecx, %eax
	movl %edi, %ecx
.__c0_main_298:
.__c0_main_634:
	movl %ebp, %r15d
	jmp .__c0_main_299
.__c0_main_280:
	movl 764(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %r15d
	orl $128, %r15d
	movl $1, %ecx
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	movl %ebp, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_633:
	movl %r15d, %eax
	movl %ecx, %r15d
	movl %edi, %ecx
.__c0_main_299:
.__c0_main_636:
	movl %edx, 732(%rsp)
	movl %r15d, %ebp
	movl %ecx, %edi
	jmp .__c0_main_300
.__c0_main_278:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, 60(%rsp)
	callq _readchar
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %r8
	movq 60(%rsp), %r9
	movl %eax, %edx
	movl 764(%rsp), %ecx
	sall $8, %ecx
	movl %ecx, %eax
	orl %edx, %eax
	movl %r12d, %ecx
	addl $1, %ecx
.__c0_main_635:
	movl %ecx, %r12d
	movl %r15d, 732(%rsp)
.__c0_main_300:
	movl %esi, %edx
	addl $1, %edx
	movl %r13d, %ecx
	addl $1, %ecx
.__c0_main_619:
	movl %ecx, %r13d
	movl %eax, 764(%rsp)
	movl %edx, %esi
	movl 732(%rsp), %r15d
	jmp .__c0_main_274
.__c0_main_276:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_638:
	movl %edx, 768(%rsp)
	movl %r15d, %r13d
	movl %ebp, %r15d
.__c0_main_301:
	cmpl $4, %ecx
	jge .__c0_main_303
.__c0_main_302:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _eof
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_305
.__c0_main_304:
	movl $1, %r11d
	cmpl %r15d, %r11d
	jnz .__c0_main_307
.__c0_main_306:
	movl $1, %r11d
	cmpl %r13d, %r11d
	jnz .__c0_main_309
.__c0_main_308:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $59, %ebp
	jnz .__c0_main_311
.__c0_main_310:
	movl 768(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $29, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_648:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_324
.__c0_main_311:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $60, %ebp
	jnz .__c0_main_313
.__c0_main_312:
	movl 768(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $21, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_646:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_323
.__c0_main_313:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $61, %ebp
	jnz .__c0_main_315
.__c0_main_314:
	movl 768(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $13, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_644:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_322
.__c0_main_315:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $62, %ebp
	jnz .__c0_main_317
.__c0_main_316:
	movl 768(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $5, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_642:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_321
.__c0_main_317:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $63, %ebp
	jnz .__c0_main_319
.__c0_main_318:
	movl 768(%rsp), %edx
	sall $8, %edx
	movl %r12d, %edi
	sall $3, %edi
	movl %edi, %eax
	andl $255, %eax
	movl %edx, %edi
	orl %eax, %edi
	movl $1, %edx
.__c0_main_640:
	movl %edi, %eax
	jmp .__c0_main_320
.__c0_main_319:
	movl 768(%rsp), %edx
	sall $8, %edx
.__c0_main_639:
	movl %edx, %eax
	movl %edi, %edx
.__c0_main_320:
.__c0_main_641:
.__c0_main_321:
.__c0_main_643:
.__c0_main_322:
.__c0_main_645:
.__c0_main_323:
.__c0_main_647:
.__c0_main_324:
.__c0_main_650:
	movl %eax, %ebp
	movl %r13d, %eax
	jmp .__c0_main_325
.__c0_main_309:
	movl 768(%rsp), %r13d
	sall $8, %r13d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	movl %ebp, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_649:
	movl %r13d, %ebp
	movl %edx, %eax
	movl %edi, %edx
.__c0_main_325:
.__c0_main_652:
	movl %eax, %r13d
	movl %r15d, %eax
	jmp .__c0_main_326
.__c0_main_307:
	movl 768(%rsp), %edx
	sall $8, %edx
	movl %edx, %r13d
	orl $128, %r13d
	movl $1, %r15d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	movl %ebp, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_651:
	movl %r13d, %ebp
	movl %edx, %r13d
	movl %r15d, %eax
	movl %edi, %edx
.__c0_main_326:
.__c0_main_654:
	jmp .__c0_main_327
.__c0_main_305:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _readchar
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl 768(%rsp), %edx
	sall $8, %edx
	movl %edx, %eax
	orl %ebp, %eax
	movl %r12d, %edx
	addl $1, %edx
.__c0_main_653:
	movl %eax, %ebp
	movl %edx, %r12d
	movl %r15d, %eax
	movl %edi, %edx
.__c0_main_327:
	addl $1, %esi
	addl $1, %ecx
.__c0_main_637:
	movl %ebp, 768(%rsp)
	movl %eax, %r15d
	movl %edx, %edi
	jmp .__c0_main_301
.__c0_main_303:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_656:
	movl %edx, 772(%rsp)
.__c0_main_328:
	cmpl $4, %ecx
	jge .__c0_main_330
.__c0_main_329:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _eof
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_332
.__c0_main_331:
	movl $1, %r11d
	cmpl %r15d, %r11d
	jnz .__c0_main_334
.__c0_main_333:
	movl $1, %r11d
	cmpl %r13d, %r11d
	jnz .__c0_main_336
.__c0_main_335:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $59, %ebp
	jnz .__c0_main_338
.__c0_main_337:
	movl 772(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $29, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_666:
	movl %edx, %eax
	jmp .__c0_main_351
.__c0_main_338:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $60, %ebp
	jnz .__c0_main_340
.__c0_main_339:
	movl 772(%rsp), %eax
	sall $8, %eax
	movl %r12d, %edx
	sarl $21, %edx
	movl %edx, %ebp
	andl $255, %ebp
	movl %eax, %edx
	orl %ebp, %edx
.__c0_main_664:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_350
.__c0_main_340:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $61, %ebp
	jnz .__c0_main_342
.__c0_main_341:
	movl 772(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $13, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_662:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_349
.__c0_main_342:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $62, %ebp
	jnz .__c0_main_344
.__c0_main_343:
	movl 772(%rsp), %ebp
	sall $8, %ebp
	movl %r12d, %edx
	sarl $5, %edx
	movl %edx, %eax
	andl $255, %eax
	movl %ebp, %edx
	orl %eax, %edx
.__c0_main_660:
	movl %edx, %eax
	movl %edi, %edx
	jmp .__c0_main_348
.__c0_main_344:
	movl %esi, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	cmpl $63, %ebp
	jnz .__c0_main_346
.__c0_main_345:
	movl 772(%rsp), %edi
	sall $8, %edi
	movl %r12d, %edx
	sall $3, %edx
	andl $255, %edx
	orl %edx, %edi
	movl $1, %edx
.__c0_main_658:
	movl %edi, %eax
	jmp .__c0_main_347
.__c0_main_346:
	movl 772(%rsp), %edx
	sall $8, %edx
.__c0_main_657:
	movl %edx, %eax
	movl %edi, %edx
.__c0_main_347:
.__c0_main_659:
.__c0_main_348:
.__c0_main_661:
.__c0_main_349:
.__c0_main_663:
.__c0_main_350:
.__c0_main_665:
	movl %edx, %edi
.__c0_main_351:
.__c0_main_668:
	movl %eax, %edx
	movl %r13d, %eax
	jmp .__c0_main_352
.__c0_main_336:
	movl 772(%rsp), %r13d
	sall $8, %r13d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	movl %ebp, %eax
	cmpl $0, %eax
	sete %al
	movzbl %al, %eax
.__c0_main_667:
	movl %r13d, %edx
.__c0_main_352:
.__c0_main_670:
	movl %eax, %ebp
	movl %r15d, %r13d
	jmp .__c0_main_353
.__c0_main_334:
	movl 772(%rsp), %edx
	sall $8, %edx
	movl %edx, %r13d
	orl $128, %r13d
	movl $1, %r15d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %ebp
	movl $64, %r11d
	movl %ebp, %eax
	cltd
	idivl %r11d
	movl %edx, %ebp
	movl %ebp, %eax
	cmpl $56, %eax
	setle %al
	movzbl %al, %eax
.__c0_main_669:
	movl %r13d, %edx
	movl %eax, %ebp
	movl %r15d, %r13d
.__c0_main_353:
.__c0_main_672:
	movl %edx, %eax
	movl %r12d, %edx
	movl %r13d, %r15d
	jmp .__c0_main_354
.__c0_main_332:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _readchar
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl 772(%rsp), %eax
	sall $8, %eax
	orl %edx, %eax
	movl %r12d, %edx
	addl $1, %edx
.__c0_main_671:
	movl %r13d, %ebp
.__c0_main_354:
	addl $1, %esi
	addl $1, %ecx
.__c0_main_655:
	movl %eax, 772(%rsp)
	movl %edx, %r12d
	movl %ebp, %r13d
	jmp .__c0_main_328
.__c0_main_330:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_674:
	movl %ecx, %ebp
	movl %edx, 776(%rsp)
	movl %esi, 732(%rsp)
	movl %r12d, 756(%rsp)
	movl %edi, 780(%rsp)
.__c0_main_355:
	cmpl $4, %ebp
	jge .__c0_main_357
.__c0_main_356:
	movq %r8, 76(%rsp)
	movq %r9, %r12
	callq _eof
	movq 76(%rsp), %r8
	movq %r12, %r9
	movl %eax, %ecx
	movl $1, %r11d
	cmpl %ecx, %r11d
	jnz .__c0_main_359
.__c0_main_358:
	movl $1, %r11d
	cmpl %r15d, %r11d
	jnz .__c0_main_361
.__c0_main_360:
	movl $1, %r11d
	cmpl %r13d, %r11d
	jnz .__c0_main_363
.__c0_main_362:
	movl 732(%rsp), %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $59, %ecx
	jnz .__c0_main_365
.__c0_main_364:
	movl 776(%rsp), %edx
	sall $8, %edx
	movl 756(%rsp), %ecx
	sarl $29, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_684:
	movl 780(%rsp), %ecx
	jmp .__c0_main_378
.__c0_main_365:
	movl 732(%rsp), %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $60, %ecx
	jnz .__c0_main_367
.__c0_main_366:
	movl 776(%rsp), %esi
	sall $8, %esi
	movl 756(%rsp), %ecx
	sarl $21, %ecx
	movl %ecx, %edx
	andl $255, %edx
	movl %esi, %ecx
	orl %edx, %ecx
.__c0_main_682:
	movl %ecx, %edx
	movl 780(%rsp), %ecx
	jmp .__c0_main_377
.__c0_main_367:
	movl 732(%rsp), %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $61, %ecx
	jnz .__c0_main_369
.__c0_main_368:
	movl 776(%rsp), %ecx
	sall $8, %ecx
	movl 756(%rsp), %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %ecx
.__c0_main_680:
	movl 780(%rsp), %esi
	jmp .__c0_main_376
.__c0_main_369:
	movl 732(%rsp), %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $62, %ecx
	jnz .__c0_main_371
.__c0_main_370:
	movl 776(%rsp), %edx
	sall $8, %edx
	movl 756(%rsp), %ecx
	sarl $5, %ecx
	andl $255, %ecx
	orl %ecx, %edx
.__c0_main_678:
	movl 780(%rsp), %esi
	jmp .__c0_main_375
.__c0_main_371:
	movl 732(%rsp), %ecx
	movl $64, %r11d
	movl %ecx, %eax
	cltd
	idivl %r11d
	movl %edx, %ecx
	cmpl $63, %ecx
	jnz .__c0_main_373
.__c0_main_372:
	movl 776(%rsp), %edx
	sall $8, %edx
	movl 756(%rsp), %ecx
	sall $3, %ecx
	movl %ecx, %esi
	andl $255, %esi
	movl %edx, %ecx
	orl %esi, %ecx
	movl $1, %esi
.__c0_main_676:
	movl %ecx, %edx
	movl %esi, %ecx
	jmp .__c0_main_374
.__c0_main_373:
	movl 776(%rsp), %ecx
	sall $8, %ecx
.__c0_main_675:
	movl %ecx, %edx
	movl 780(%rsp), %ecx
.__c0_main_374:
.__c0_main_677:
	movl %ecx, %esi
.__c0_main_375:
.__c0_main_679:
	movl %edx, %ecx
.__c0_main_376:
.__c0_main_681:
	movl %ecx, %edx
	movl %esi, %ecx
.__c0_main_377:
.__c0_main_683:
.__c0_main_378:
.__c0_main_686:
	movl %edx, %esi
	movl %r13d, %edx
	movl %ecx, %eax
	jmp .__c0_main_379
.__c0_main_363:
	movl 776(%rsp), %ecx
	sall $8, %ecx
	movl 732(%rsp), %edx
	addl $1, %edx
	movl %edx, %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	movl %esi, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_685:
	movl %ecx, %esi
	movl 780(%rsp), %eax
.__c0_main_379:
.__c0_main_688:
	movl %esi, %edi
	movl %r15d, %ecx
	jmp .__c0_main_380
.__c0_main_361:
	movl 776(%rsp), %ecx
	sall $8, %ecx
	orl $128, %ecx
	movl $1, %esi
	movl 732(%rsp), %edx
	addl $1, %edx
	movl %edx, %edi
	movl $64, %r11d
	movl %edi, %eax
	cltd
	idivl %r11d
	movl %edx, %edi
	movl %edi, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_687:
	movl %ecx, %edi
	movl %esi, %ecx
	movl 780(%rsp), %eax
.__c0_main_380:
.__c0_main_690:
	movl %edi, %esi
	movl %eax, %edi
	jmp .__c0_main_381
.__c0_main_359:
	movq %r8, 76(%rsp)
	movq %r9, %r12
	callq _readchar
	movq 76(%rsp), %r8
	movq %r12, %r9
	movl %eax, %edx
	movl 776(%rsp), %ecx
	sall $8, %ecx
	orl %edx, %ecx
	movl 756(%rsp), %edx
	addl $1, %edx
.__c0_main_689:
	movl %ecx, %esi
	movl %edx, 756(%rsp)
	movl %r13d, %edx
	movl %r15d, %ecx
	movl 780(%rsp), %edi
.__c0_main_381:
	movl 732(%rsp), %r12d
	addl $1, %r12d
	movl %ebp, %eax
	addl $1, %eax
.__c0_main_673:
	movl %eax, %ebp
	movl %esi, 776(%rsp)
	movl %r12d, 732(%rsp)
	movl %edx, %r13d
	movl %ecx, %r15d
	movl %edi, 780(%rsp)
	jmp .__c0_main_355
.__c0_main_357:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_692:
	movl %edx, %r12d
	movl 732(%rsp), %esi
	movl 756(%rsp), %edi
	movl %r13d, %ebp
	movl 780(%rsp), %r10d
	movl %r10d, 784(%rsp)
.__c0_main_382:
	cmpl $4, %ecx
	jge .__c0_main_384
.__c0_main_383:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %r13
	callq _eof
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %r13, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_386
.__c0_main_385:
	movl $1, %r11d
	cmpl %r15d, %r11d
	jnz .__c0_main_388
.__c0_main_387:
	movl $1, %r11d
	cmpl %ebp, %r11d
	jnz .__c0_main_390
.__c0_main_389:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $59, %r13d
	jnz .__c0_main_392
.__c0_main_391:
	movl %r12d, %edx
	sall $8, %edx
	movl %edi, %eax
	sarl $29, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_702:
	movl 784(%rsp), %eax
	jmp .__c0_main_405
.__c0_main_392:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $60, %r13d
	jnz .__c0_main_394
.__c0_main_393:
	movl %r12d, %eax
	sall $8, %eax
	movl %edi, %edx
	sarl $21, %edx
	movl %edx, %r12d
	andl $255, %r12d
	movl %eax, %edx
	orl %r12d, %edx
.__c0_main_700:
	movl 784(%rsp), %eax
	jmp .__c0_main_404
.__c0_main_394:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $61, %r13d
	jnz .__c0_main_396
.__c0_main_395:
	movl %r12d, %edx
	sall $8, %edx
	movl %edi, %eax
	sarl $13, %eax
	andl $255, %eax
	orl %eax, %edx
.__c0_main_698:
	movl 784(%rsp), %eax
	jmp .__c0_main_403
.__c0_main_396:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $62, %r13d
	jnz .__c0_main_398
.__c0_main_397:
	movl %r12d, %eax
	sall $8, %eax
	movl %edi, %edx
	sarl $5, %edx
	movl %edx, %r12d
	andl $255, %r12d
	movl %eax, %edx
	orl %r12d, %edx
.__c0_main_696:
	movl 784(%rsp), %eax
	jmp .__c0_main_402
.__c0_main_398:
	movl %esi, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	cmpl $63, %r13d
	jnz .__c0_main_400
.__c0_main_399:
	movl %r12d, %eax
	sall $8, %eax
	movl %edi, %edx
	sall $3, %edx
	movl %edx, %r12d
	andl $255, %r12d
	movl %eax, %edx
	orl %r12d, %edx
	movl $1, %eax
.__c0_main_694:
	jmp .__c0_main_401
.__c0_main_400:
	movl %r12d, %edx
	sall $8, %edx
.__c0_main_693:
	movl 784(%rsp), %eax
.__c0_main_401:
.__c0_main_695:
.__c0_main_402:
.__c0_main_697:
.__c0_main_403:
.__c0_main_699:
.__c0_main_404:
.__c0_main_701:
.__c0_main_405:
.__c0_main_704:
	movl %ebp, %r12d
	movl %eax, %ebp
	jmp .__c0_main_406
.__c0_main_390:
	sall $8, %r12d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	movl %r13d, %eax
	cmpl $0, %eax
	sete %al
	movzbl %al, %eax
.__c0_main_703:
	movl %r12d, %edx
	movl %eax, %r12d
	movl 784(%rsp), %ebp
.__c0_main_406:
.__c0_main_706:
	movl %edx, %eax
	movl %r15d, %r13d
	movl %ebp, %edx
	jmp .__c0_main_407
.__c0_main_388:
	movl %r12d, %edx
	sall $8, %edx
	movl %edx, %r12d
	orl $128, %r12d
	movl $1, %r13d
	movl %esi, %edx
	addl $1, %edx
	movl %edx, %r15d
	movl $64, %r11d
	movl %r15d, %eax
	cltd
	idivl %r11d
	movl %edx, %r15d
	movl %r15d, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_705:
	movl %r12d, %eax
	movl %edx, %r12d
	movl 784(%rsp), %edx
.__c0_main_407:
.__c0_main_708:
	movl %eax, 732(%rsp)
	movl %r12d, %eax
	jmp .__c0_main_408
.__c0_main_386:
	movq %rdi, 76(%rsp)
	movq %rsi, 68(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %r13
	callq _readchar
	movq 76(%rsp), %rdi
	movq 68(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %r12d, %eax
	sall $8, %eax
	orl %edx, %eax
	movl %edi, %edx
	addl $1, %edx
.__c0_main_707:
	movl %eax, 732(%rsp)
	movl %edx, %edi
	movl %ebp, %eax
	movl %r15d, %r13d
	movl 784(%rsp), %edx
.__c0_main_408:
	addl $1, %esi
	addl $1, %ecx
.__c0_main_691:
	movl 732(%rsp), %r12d
	movl %eax, %ebp
	movl %r13d, %r15d
	movl %edx, 784(%rsp)
	jmp .__c0_main_382
.__c0_main_384:
	movl $0, %edx
	movl $0, %ecx
.__c0_main_710:
	movl %edx, %r13d
	movl %esi, 732(%rsp)
	movl %edi, 756(%rsp)
	movl %ebp, 780(%rsp)
	movl %r15d, 788(%rsp)
.__c0_main_409:
	cmpl $4, %ecx
	jge .__c0_main_411
.__c0_main_410:
	movq %rcx, 84(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _eof
	movq 84(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %edx
	movl $1, %r11d
	cmpl %edx, %r11d
	jnz .__c0_main_413
.__c0_main_412:
	movl $1, %r11d
	cmpl 788(%rsp), %r11d
	jnz .__c0_main_415
.__c0_main_414:
	movl $1, %r11d
	cmpl 780(%rsp), %r11d
	jnz .__c0_main_417
.__c0_main_416:
	movl 732(%rsp), %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	cmpl $59, %esi
	jnz .__c0_main_419
.__c0_main_418:
	movl %r13d, %esi
	sall $8, %esi
	movl 756(%rsp), %edx
	sarl $29, %edx
	andl $255, %edx
	orl %edx, %esi
.__c0_main_720:
	movl %esi, %edx
	movl 784(%rsp), %esi
	jmp .__c0_main_432
.__c0_main_419:
	movl 732(%rsp), %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	cmpl $60, %esi
	jnz .__c0_main_421
.__c0_main_420:
	movl %r13d, %edi
	sall $8, %edi
	movl 756(%rsp), %edx
	sarl $21, %edx
	movl %edx, %esi
	andl $255, %esi
	movl %edi, %edx
	orl %esi, %edx
.__c0_main_718:
	movl %edx, %esi
	movl 784(%rsp), %edi
	jmp .__c0_main_431
.__c0_main_421:
	movl 732(%rsp), %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	cmpl $61, %esi
	jnz .__c0_main_423
.__c0_main_422:
	movl %r13d, %esi
	sall $8, %esi
	movl 756(%rsp), %edx
	sarl $13, %edx
	andl $255, %edx
	orl %edx, %esi
.__c0_main_716:
	movl 784(%rsp), %edx
	jmp .__c0_main_430
.__c0_main_423:
	movl 732(%rsp), %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	cmpl $62, %esi
	jnz .__c0_main_425
.__c0_main_424:
	movl %r13d, %esi
	sall $8, %esi
	movl 756(%rsp), %edx
	sarl $5, %edx
	andl $255, %edx
	orl %edx, %esi
.__c0_main_714:
	movl 784(%rsp), %edx
	jmp .__c0_main_429
.__c0_main_425:
	movl 732(%rsp), %esi
	movl $64, %r11d
	movl %esi, %eax
	cltd
	idivl %r11d
	movl %edx, %esi
	cmpl $63, %esi
	jnz .__c0_main_427
.__c0_main_426:
	movl %r13d, %esi
	sall $8, %esi
	movl 756(%rsp), %edx
	sall $3, %edx
	movl %edx, %edi
	andl $255, %edi
	movl %esi, %edx
	orl %edi, %edx
	movl $1, %esi
.__c0_main_712:
	movl %esi, %edi
	jmp .__c0_main_428
.__c0_main_427:
	movl %r13d, %edx
	sall $8, %edx
.__c0_main_711:
	movl 784(%rsp), %edi
.__c0_main_428:
.__c0_main_713:
	movl %edx, %esi
	movl %edi, %edx
.__c0_main_429:
.__c0_main_715:
.__c0_main_430:
.__c0_main_717:
	movl %edx, %edi
.__c0_main_431:
.__c0_main_719:
	movl %esi, %edx
	movl %edi, %esi
.__c0_main_432:
.__c0_main_722:
	movl %edx, %edi
	movl 780(%rsp), %edx
	jmp .__c0_main_433
.__c0_main_417:
	movl %r13d, %esi
	sall $8, %esi
	movl 732(%rsp), %edx
	addl $1, %edx
	movl %edx, %edi
	movl $64, %r11d
	movl %edi, %eax
	cltd
	idivl %r11d
	movl %edx, %edi
	movl %edi, %edx
	cmpl $0, %edx
	sete %dl
	movzbl %dl, %edx
.__c0_main_721:
	movl %esi, %edi
	movl 784(%rsp), %esi
.__c0_main_433:
.__c0_main_724:
	movl %edi, %r13d
	movl 788(%rsp), %edi
	movl %esi, %eax
	jmp .__c0_main_434
.__c0_main_415:
	movl %r13d, %edx
	sall $8, %edx
	movl %edx, %esi
	orl $128, %esi
	movl $1, %edi
	movl 732(%rsp), %edx
	addl $1, %edx
	movl %edx, %r13d
	movl $64, %r11d
	movl %r13d, %eax
	cltd
	idivl %r11d
	movl %edx, %r13d
	movl %r13d, %edx
	cmpl $56, %edx
	setle %dl
	movzbl %dl, %edx
.__c0_main_723:
	movl %esi, %r13d
	movl 784(%rsp), %eax
.__c0_main_434:
.__c0_main_726:
	movl %r13d, %esi
	movl 756(%rsp), %r15d
	movl %edx, %ebp
	movl %edi, %edx
	movl %eax, %edi
	jmp .__c0_main_435
.__c0_main_413:
	movq %rcx, 84(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _readchar
	movq 84(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %esi
	movl %r13d, %edx
	sall $8, %edx
	orl %esi, %edx
	movl 756(%rsp), %edi
	addl $1, %edi
.__c0_main_725:
	movl %edx, %esi
	movl %edi, %r15d
	movl 780(%rsp), %ebp
	movl 788(%rsp), %edx
	movl 784(%rsp), %edi
.__c0_main_435:
	movl 732(%rsp), %eax
	addl $1, %eax
	addl $1, %ecx
.__c0_main_709:
	movl %esi, %r13d
	movl %eax, 732(%rsp)
	movl %r15d, 756(%rsp)
	movl %ebp, 780(%rsp)
	movl %edx, 788(%rsp)
	movl %edi, 784(%rsp)
	jmp .__c0_main_409
.__c0_main_411:
	movl $1, %edx
	movl 776(%rsp), %ecx
	xorl %r14d, %ecx
	xorl 736(%rsp), %ecx
	xorl 724(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, %rbp
	movq %r9, %r15
	callq __c0_ROTL
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %ecx
	movl %ecx, %r15d
	movl $1, %edx
	movl %r12d, %ecx
	xorl 760(%rsp), %ecx
	xorl 740(%rsp), %ecx
	xorl 728(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ecx
	movl %ecx, %ebp
	movl $1, %edx
	movl %r13d, %ecx
	xorl 764(%rsp), %ecx
	xorl 744(%rsp), %ecx
	xorl 736(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_ROTL
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 792(%rsp)
	movl $1, %edx
	movl %r15d, %ecx
	xorl 768(%rsp), %ecx
	xorl 748(%rsp), %ecx
	xorl 740(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 100(%rsp)
	movq %r9, 92(%rsp)
	callq __c0_ROTL
	movq 100(%rsp), %r8
	movq 92(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 796(%rsp)
	movl $1, %edx
	movl %ebp, %ecx
	xorl 772(%rsp), %ecx
	xorl 752(%rsp), %ecx
	xorl 744(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 108(%rsp)
	movq %r9, 100(%rsp)
	callq __c0_ROTL
	movq 108(%rsp), %r8
	movq 100(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 800(%rsp)
	movl $1, %edx
	movl 792(%rsp), %ecx
	xorl 776(%rsp), %ecx
	xorl %ebx, %ecx
	xorl 748(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 116(%rsp)
	movq %r9, 108(%rsp)
	callq __c0_ROTL
	movq 116(%rsp), %r8
	movq 108(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 804(%rsp)
	movl $1, %edx
	movl 796(%rsp), %ecx
	xorl %r12d, %ecx
	xorl %r14d, %ecx
	xorl 752(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 124(%rsp)
	movq %r9, 116(%rsp)
	callq __c0_ROTL
	movq 124(%rsp), %r8
	movq 116(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 808(%rsp)
	movl $1, %edx
	movl 800(%rsp), %ecx
	xorl %r13d, %ecx
	xorl 760(%rsp), %ecx
	xorl %ebx, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 132(%rsp)
	movq %r9, 124(%rsp)
	callq __c0_ROTL
	movq 132(%rsp), %r8
	movq 124(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 812(%rsp)
	movl $1, %edx
	movl 804(%rsp), %ecx
	xorl %r15d, %ecx
	xorl 764(%rsp), %ecx
	xorl %r14d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 140(%rsp)
	movq %r9, 132(%rsp)
	callq __c0_ROTL
	movq 140(%rsp), %r8
	movq 132(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 816(%rsp)
	movl $1, %edx
	movl 808(%rsp), %ecx
	xorl %ebp, %ecx
	xorl 768(%rsp), %ecx
	xorl 760(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 148(%rsp)
	movq %r9, 140(%rsp)
	callq __c0_ROTL
	movq 148(%rsp), %r8
	movq 140(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 820(%rsp)
	movl $1, %edx
	movl 812(%rsp), %ecx
	xorl 792(%rsp), %ecx
	xorl 772(%rsp), %ecx
	xorl 764(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 156(%rsp)
	movq %r9, 148(%rsp)
	callq __c0_ROTL
	movq 156(%rsp), %r8
	movq 148(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 824(%rsp)
	movl $1, %edx
	movl 816(%rsp), %ecx
	xorl 796(%rsp), %ecx
	xorl 776(%rsp), %ecx
	xorl 768(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 164(%rsp)
	movq %r9, 156(%rsp)
	callq __c0_ROTL
	movq 164(%rsp), %r8
	movq 156(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 828(%rsp)
	movl $1, %edx
	movl 820(%rsp), %ecx
	xorl 800(%rsp), %ecx
	xorl %r12d, %ecx
	xorl 772(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 172(%rsp)
	movq %r9, 164(%rsp)
	callq __c0_ROTL
	movq 172(%rsp), %r8
	movq 164(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 832(%rsp)
	movl $1, %edx
	movl 824(%rsp), %ecx
	xorl 804(%rsp), %ecx
	xorl %r13d, %ecx
	xorl 776(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 180(%rsp)
	movq %r9, 172(%rsp)
	callq __c0_ROTL
	movq 180(%rsp), %r8
	movq 172(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 836(%rsp)
	movl $1, %edx
	movl 828(%rsp), %ecx
	xorl 808(%rsp), %ecx
	xorl %r15d, %ecx
	xorl %r12d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 188(%rsp)
	movq %r9, 180(%rsp)
	callq __c0_ROTL
	movq 188(%rsp), %r8
	movq 180(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 840(%rsp)
	movl $1, %edx
	movl 832(%rsp), %ecx
	xorl 812(%rsp), %ecx
	xorl %ebp, %ecx
	xorl %r13d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 196(%rsp)
	movq %r9, 188(%rsp)
	callq __c0_ROTL
	movq 196(%rsp), %r8
	movq 188(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 844(%rsp)
	movl $1, %edx
	movl 836(%rsp), %ecx
	xorl 816(%rsp), %ecx
	xorl 792(%rsp), %ecx
	xorl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 204(%rsp)
	movq %r9, 196(%rsp)
	callq __c0_ROTL
	movq 204(%rsp), %r8
	movq 196(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 848(%rsp)
	movl $1, %edx
	movl 840(%rsp), %ecx
	xorl 820(%rsp), %ecx
	xorl 796(%rsp), %ecx
	xorl %ebp, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 212(%rsp)
	movq %r9, 204(%rsp)
	callq __c0_ROTL
	movq 212(%rsp), %r8
	movq 204(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 852(%rsp)
	movl $1, %edx
	movl 844(%rsp), %ecx
	xorl 824(%rsp), %ecx
	xorl 800(%rsp), %ecx
	xorl 792(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 220(%rsp)
	movq %r9, 212(%rsp)
	callq __c0_ROTL
	movq 220(%rsp), %r8
	movq 212(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 856(%rsp)
	movl $1, %edx
	movl 848(%rsp), %ecx
	xorl 828(%rsp), %ecx
	xorl 804(%rsp), %ecx
	xorl 796(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 228(%rsp)
	movq %r9, 220(%rsp)
	callq __c0_ROTL
	movq 228(%rsp), %r8
	movq 220(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 860(%rsp)
	movl $1, %edx
	movl 852(%rsp), %ecx
	xorl 832(%rsp), %ecx
	xorl 808(%rsp), %ecx
	xorl 800(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 236(%rsp)
	movq %r9, 228(%rsp)
	callq __c0_ROTL
	movq 236(%rsp), %r8
	movq 228(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 864(%rsp)
	movl $1, %edx
	movl 856(%rsp), %ecx
	xorl 836(%rsp), %ecx
	xorl 812(%rsp), %ecx
	xorl 804(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 244(%rsp)
	movq %r9, 236(%rsp)
	callq __c0_ROTL
	movq 244(%rsp), %r8
	movq 236(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 868(%rsp)
	movl $1, %edx
	movl 860(%rsp), %ecx
	xorl 840(%rsp), %ecx
	xorl 816(%rsp), %ecx
	xorl 808(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 252(%rsp)
	movq %r9, 244(%rsp)
	callq __c0_ROTL
	movq 252(%rsp), %r8
	movq 244(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 872(%rsp)
	movl $1, %edx
	movl 864(%rsp), %ecx
	xorl 844(%rsp), %ecx
	xorl 820(%rsp), %ecx
	xorl 812(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 260(%rsp)
	movq %r9, 252(%rsp)
	callq __c0_ROTL
	movq 260(%rsp), %r8
	movq 252(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 876(%rsp)
	movl $1, %edx
	movl 868(%rsp), %ecx
	xorl 848(%rsp), %ecx
	xorl 824(%rsp), %ecx
	xorl 816(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 268(%rsp)
	movq %r9, 260(%rsp)
	callq __c0_ROTL
	movq 268(%rsp), %r8
	movq 260(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 880(%rsp)
	movl $1, %edx
	movl 872(%rsp), %ecx
	xorl 852(%rsp), %ecx
	xorl 828(%rsp), %ecx
	xorl 820(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 276(%rsp)
	movq %r9, 268(%rsp)
	callq __c0_ROTL
	movq 276(%rsp), %r8
	movq 268(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 884(%rsp)
	movl $1, %edx
	movl 876(%rsp), %ecx
	xorl 856(%rsp), %ecx
	xorl 832(%rsp), %ecx
	xorl 824(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 284(%rsp)
	movq %r9, 276(%rsp)
	callq __c0_ROTL
	movq 284(%rsp), %r8
	movq 276(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 888(%rsp)
	movl $1, %edx
	movl 880(%rsp), %ecx
	xorl 860(%rsp), %ecx
	xorl 836(%rsp), %ecx
	xorl 828(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 292(%rsp)
	movq %r9, 284(%rsp)
	callq __c0_ROTL
	movq 292(%rsp), %r8
	movq 284(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 892(%rsp)
	movl $1, %edx
	movl 884(%rsp), %ecx
	xorl 864(%rsp), %ecx
	xorl 840(%rsp), %ecx
	xorl 832(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 300(%rsp)
	movq %r9, 292(%rsp)
	callq __c0_ROTL
	movq 300(%rsp), %r8
	movq 292(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 896(%rsp)
	movl $1, %edx
	movl 888(%rsp), %ecx
	xorl 868(%rsp), %ecx
	xorl 844(%rsp), %ecx
	xorl 836(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 308(%rsp)
	movq %r9, 300(%rsp)
	callq __c0_ROTL
	movq 308(%rsp), %r8
	movq 300(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 900(%rsp)
	movl $1, %edx
	movl 892(%rsp), %ecx
	xorl 872(%rsp), %ecx
	xorl 848(%rsp), %ecx
	xorl 840(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 316(%rsp)
	movq %r9, 308(%rsp)
	callq __c0_ROTL
	movq 316(%rsp), %r8
	movq 308(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 904(%rsp)
	movl $1, %edx
	movl 896(%rsp), %ecx
	xorl 876(%rsp), %ecx
	xorl 852(%rsp), %ecx
	xorl 844(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 324(%rsp)
	movq %r9, 316(%rsp)
	callq __c0_ROTL
	movq 324(%rsp), %r8
	movq 316(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 908(%rsp)
	movl $1, %edx
	movl 900(%rsp), %ecx
	xorl 880(%rsp), %ecx
	xorl 856(%rsp), %ecx
	xorl 848(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 332(%rsp)
	movq %r9, 324(%rsp)
	callq __c0_ROTL
	movq 332(%rsp), %r8
	movq 324(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 912(%rsp)
	movl $1, %edx
	movl 904(%rsp), %ecx
	xorl 884(%rsp), %ecx
	xorl 860(%rsp), %ecx
	xorl 852(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 340(%rsp)
	movq %r9, 332(%rsp)
	callq __c0_ROTL
	movq 340(%rsp), %r8
	movq 332(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 916(%rsp)
	movl $1, %edx
	movl 908(%rsp), %ecx
	xorl 888(%rsp), %ecx
	xorl 864(%rsp), %ecx
	xorl 856(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 348(%rsp)
	movq %r9, 340(%rsp)
	callq __c0_ROTL
	movq 348(%rsp), %r8
	movq 340(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 920(%rsp)
	movl $1, %edx
	movl 912(%rsp), %ecx
	xorl 892(%rsp), %ecx
	xorl 868(%rsp), %ecx
	xorl 860(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 356(%rsp)
	movq %r9, 348(%rsp)
	callq __c0_ROTL
	movq 356(%rsp), %r8
	movq 348(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 924(%rsp)
	movl $1, %edx
	movl 916(%rsp), %ecx
	xorl 896(%rsp), %ecx
	xorl 872(%rsp), %ecx
	xorl 864(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 364(%rsp)
	movq %r9, 356(%rsp)
	callq __c0_ROTL
	movq 364(%rsp), %r8
	movq 356(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 928(%rsp)
	movl $1, %edx
	movl 920(%rsp), %ecx
	xorl 900(%rsp), %ecx
	xorl 876(%rsp), %ecx
	xorl 868(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 372(%rsp)
	movq %r9, 364(%rsp)
	callq __c0_ROTL
	movq 372(%rsp), %r8
	movq 364(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 932(%rsp)
	movl $1, %edx
	movl 924(%rsp), %ecx
	xorl 904(%rsp), %ecx
	xorl 880(%rsp), %ecx
	xorl 872(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 380(%rsp)
	movq %r9, 372(%rsp)
	callq __c0_ROTL
	movq 380(%rsp), %r8
	movq 372(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 936(%rsp)
	movl $1, %edx
	movl 928(%rsp), %ecx
	xorl 908(%rsp), %ecx
	xorl 884(%rsp), %ecx
	xorl 876(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 388(%rsp)
	movq %r9, 380(%rsp)
	callq __c0_ROTL
	movq 388(%rsp), %r8
	movq 380(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 940(%rsp)
	movl $1, %edx
	movl 932(%rsp), %ecx
	xorl 912(%rsp), %ecx
	xorl 888(%rsp), %ecx
	xorl 880(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 396(%rsp)
	movq %r9, 388(%rsp)
	callq __c0_ROTL
	movq 396(%rsp), %r8
	movq 388(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 944(%rsp)
	movl $1, %edx
	movl 936(%rsp), %ecx
	xorl 916(%rsp), %ecx
	xorl 892(%rsp), %ecx
	xorl 884(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 404(%rsp)
	movq %r9, 396(%rsp)
	callq __c0_ROTL
	movq 404(%rsp), %r8
	movq 396(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 948(%rsp)
	movl $1, %edx
	movl 940(%rsp), %ecx
	xorl 920(%rsp), %ecx
	xorl 896(%rsp), %ecx
	xorl 888(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 412(%rsp)
	movq %r9, 404(%rsp)
	callq __c0_ROTL
	movq 412(%rsp), %r8
	movq 404(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 952(%rsp)
	movl $1, %edx
	movl 944(%rsp), %ecx
	xorl 924(%rsp), %ecx
	xorl 900(%rsp), %ecx
	xorl 892(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 420(%rsp)
	movq %r9, 412(%rsp)
	callq __c0_ROTL
	movq 420(%rsp), %r8
	movq 412(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 956(%rsp)
	movl $1, %edx
	movl 948(%rsp), %ecx
	xorl 928(%rsp), %ecx
	xorl 904(%rsp), %ecx
	xorl 896(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 428(%rsp)
	movq %r9, 420(%rsp)
	callq __c0_ROTL
	movq 428(%rsp), %r8
	movq 420(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 960(%rsp)
	movl $1, %edx
	movl 952(%rsp), %ecx
	xorl 932(%rsp), %ecx
	xorl 908(%rsp), %ecx
	xorl 900(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 436(%rsp)
	movq %r9, 428(%rsp)
	callq __c0_ROTL
	movq 436(%rsp), %r8
	movq 428(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 964(%rsp)
	movl $1, %edx
	movl 956(%rsp), %ecx
	xorl 936(%rsp), %ecx
	xorl 912(%rsp), %ecx
	xorl 904(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 444(%rsp)
	movq %r9, 436(%rsp)
	callq __c0_ROTL
	movq 444(%rsp), %r8
	movq 436(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 968(%rsp)
	movl $1, %edx
	movl 960(%rsp), %ecx
	xorl 940(%rsp), %ecx
	xorl 916(%rsp), %ecx
	xorl 908(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 452(%rsp)
	movq %r9, 444(%rsp)
	callq __c0_ROTL
	movq 452(%rsp), %r8
	movq 444(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 972(%rsp)
	movl $1, %edx
	movl 964(%rsp), %ecx
	xorl 944(%rsp), %ecx
	xorl 920(%rsp), %ecx
	xorl 912(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 460(%rsp)
	movq %r9, 452(%rsp)
	callq __c0_ROTL
	movq 460(%rsp), %r8
	movq 452(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 976(%rsp)
	movl $1, %edx
	movl 968(%rsp), %ecx
	xorl 948(%rsp), %ecx
	xorl 924(%rsp), %ecx
	xorl 916(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 468(%rsp)
	movq %r9, 460(%rsp)
	callq __c0_ROTL
	movq 468(%rsp), %r8
	movq 460(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 980(%rsp)
	movl $1, %edx
	movl 972(%rsp), %ecx
	xorl 952(%rsp), %ecx
	xorl 928(%rsp), %ecx
	xorl 920(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 476(%rsp)
	movq %r9, 468(%rsp)
	callq __c0_ROTL
	movq 476(%rsp), %r8
	movq 468(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 984(%rsp)
	movl $1, %edx
	movl 976(%rsp), %ecx
	xorl 956(%rsp), %ecx
	xorl 932(%rsp), %ecx
	xorl 924(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 484(%rsp)
	movq %r9, 476(%rsp)
	callq __c0_ROTL
	movq 484(%rsp), %r8
	movq 476(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 988(%rsp)
	movl $1, %edx
	movl 980(%rsp), %ecx
	xorl 960(%rsp), %ecx
	xorl 936(%rsp), %ecx
	xorl 928(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 492(%rsp)
	movq %r9, 484(%rsp)
	callq __c0_ROTL
	movq 492(%rsp), %r8
	movq 484(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 992(%rsp)
	movl $1, %edx
	movl 984(%rsp), %ecx
	xorl 964(%rsp), %ecx
	xorl 940(%rsp), %ecx
	xorl 932(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 500(%rsp)
	movq %r9, 492(%rsp)
	callq __c0_ROTL
	movq 500(%rsp), %r8
	movq 492(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 996(%rsp)
	movl $1, %edx
	movl 988(%rsp), %ecx
	xorl 968(%rsp), %ecx
	xorl 944(%rsp), %ecx
	xorl 936(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 508(%rsp)
	movq %r9, 500(%rsp)
	callq __c0_ROTL
	movq 508(%rsp), %r8
	movq 500(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1000(%rsp)
	movl $1, %edx
	movl 992(%rsp), %ecx
	xorl 972(%rsp), %ecx
	xorl 948(%rsp), %ecx
	xorl 940(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 516(%rsp)
	movq %r9, 508(%rsp)
	callq __c0_ROTL
	movq 516(%rsp), %r8
	movq 508(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1004(%rsp)
	movl $1, %edx
	movl 996(%rsp), %ecx
	xorl 976(%rsp), %ecx
	xorl 952(%rsp), %ecx
	xorl 944(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 524(%rsp)
	movq %r9, 516(%rsp)
	callq __c0_ROTL
	movq 524(%rsp), %r8
	movq 516(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1008(%rsp)
	movl $1, %edx
	movl 1000(%rsp), %ecx
	xorl 980(%rsp), %ecx
	xorl 956(%rsp), %ecx
	xorl 948(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 532(%rsp)
	movq %r9, 524(%rsp)
	callq __c0_ROTL
	movq 532(%rsp), %r8
	movq 524(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1012(%rsp)
	movl $1, %edx
	movl 1004(%rsp), %ecx
	xorl 984(%rsp), %ecx
	xorl 960(%rsp), %ecx
	xorl 952(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 540(%rsp)
	movq %r9, 532(%rsp)
	callq __c0_ROTL
	movq 540(%rsp), %r8
	movq 532(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1016(%rsp)
	movl $1, %edx
	movl 1008(%rsp), %ecx
	xorl 988(%rsp), %ecx
	xorl 964(%rsp), %ecx
	xorl 956(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 548(%rsp)
	movq %r9, 540(%rsp)
	callq __c0_ROTL
	movq 548(%rsp), %r8
	movq 540(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1020(%rsp)
	movl $1, %edx
	movl 1012(%rsp), %ecx
	xorl 992(%rsp), %ecx
	xorl 968(%rsp), %ecx
	xorl 960(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 556(%rsp)
	movq %r9, 548(%rsp)
	callq __c0_ROTL
	movq 556(%rsp), %r8
	movq 548(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1024(%rsp)
	movl $1, %edx
	movl 1016(%rsp), %ecx
	xorl 996(%rsp), %ecx
	xorl 972(%rsp), %ecx
	xorl 964(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 564(%rsp)
	movq %r9, 556(%rsp)
	callq __c0_ROTL
	movq 564(%rsp), %r8
	movq 556(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1028(%rsp)
	movl $1, %edx
	movl 1020(%rsp), %ecx
	xorl 1000(%rsp), %ecx
	xorl 976(%rsp), %ecx
	xorl 968(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 572(%rsp)
	movq %r9, 564(%rsp)
	callq __c0_ROTL
	movq 572(%rsp), %r8
	movq 564(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1032(%rsp)
	movl $1, %edx
	movl 1024(%rsp), %ecx
	xorl 1004(%rsp), %ecx
	xorl 980(%rsp), %ecx
	xorl 972(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 580(%rsp)
	movq %r9, 572(%rsp)
	callq __c0_ROTL
	movq 580(%rsp), %r8
	movq 572(%rsp), %r9
	movl %eax, %ecx
	movl %ecx, 1036(%rsp)
	movl %r8d, 1040(%rsp)
	movl 720(%rsp), %r10d
	movl %r10d, 1044(%rsp)
	movl 716(%rsp), %r10d
	movl %r10d, 1048(%rsp)
	movl 712(%rsp), %r10d
	movl %r10d, 1052(%rsp)
	movl 708(%rsp), %r10d
	movl %r10d, 1056(%rsp)
	movl $5, %edx
	movl 1040(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 588(%rsp)
	movq %r9, 596(%rsp)
	callq __c0_ROTL
	movq 588(%rsp), %r8
	movq 596(%rsp), %r9
	movl %eax, 1060(%rsp)
	movl $0, %edi
	movl 1044(%rsp), %esi
	movl 1048(%rsp), %edx
	movl 1052(%rsp), %ecx
	movq %r8, 604(%rsp)
	movq %r9, 588(%rsp)
	callq __c0_f
	movq 604(%rsp), %r8
	movq 588(%rsp), %r9
	movl %eax, %ecx
	movl $0, %edx
	movl %edx, %edi
	movq %rcx, 612(%rsp)
	movq %r8, 604(%rsp)
	movq %r9, 588(%rsp)
	callq __c0_K
	movq 612(%rsp), %rcx
	movq 604(%rsp), %r8
	movq 588(%rsp), %r9
	movl %eax, %edx
	movl 1060(%rsp), %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl 1056(%rsp), %ecx
	addl %edx, %ecx
	addl 724(%rsp), %ecx
	movl 1052(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl $30, %esi
	movl 1044(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 620(%rsp)
	movq %r8, 628(%rsp)
	movq %r9, 636(%rsp)
	callq __c0_ROTL
	movq 620(%rsp), %rcx
	movq 628(%rsp), %r8
	movq 636(%rsp), %r9
	movl %eax, %edx
	movl %edx, 1044(%rsp)
	movl %ecx, 1052(%rsp)
	movl $5, %edx
	movl 1052(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 596(%rsp)
	movq %r9, 620(%rsp)
	callq __c0_ROTL
	movq 596(%rsp), %r8
	movq 620(%rsp), %r9
	movl %eax, 1056(%rsp)
	movl $1, %edi
	movl 1040(%rsp), %esi
	movl 1044(%rsp), %edx
	movl 1048(%rsp), %ecx
	movq %r8, 588(%rsp)
	movq %r9, 596(%rsp)
	callq __c0_f
	movq 588(%rsp), %r8
	movq 596(%rsp), %r9
	movl %eax, %ecx
	movl $1, %edx
	movl %edx, %edi
	movq %rcx, 604(%rsp)
	movq %r8, 588(%rsp)
	movq %r9, 596(%rsp)
	callq __c0_K
	movq 604(%rsp), %rcx
	movq 588(%rsp), %r8
	movq 596(%rsp), %r9
	movl %eax, %edx
	movl 1056(%rsp), %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl 724(%rsp), %ecx
	addl %edx, %ecx
	addl 728(%rsp), %ecx
	movl 1048(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl 1044(%rsp), %r10d
	movl %r10d, 728(%rsp)
	movl $30, %esi
	movl 1040(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 644(%rsp)
	movq %r8, 636(%rsp)
	movq %r9, 580(%rsp)
	callq __c0_ROTL
	movq 644(%rsp), %rcx
	movq 636(%rsp), %r8
	movq 580(%rsp), %r9
	movl %eax, %edx
	movl %edx, 1040(%rsp)
	movl 1052(%rsp), %r10d
	movl %r10d, 1044(%rsp)
	movl %ecx, 1048(%rsp)
	movl $5, %edx
	movl 1048(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 620(%rsp)
	movq %r9, 628(%rsp)
	callq __c0_ROTL
	movq 620(%rsp), %r8
	movq 628(%rsp), %r9
	movl %eax, 1052(%rsp)
	movl $2, %edi
	movl 1044(%rsp), %esi
	movl 1040(%rsp), %edx
	movl 728(%rsp), %ecx
	movq %r8, 596(%rsp)
	movq %r9, 620(%rsp)
	callq __c0_f
	movq 596(%rsp), %r8
	movq 620(%rsp), %r9
	movl %eax, %ecx
	movl $2, %edx
	movl %edx, %edi
	movq %rcx, 588(%rsp)
	movq %r8, 596(%rsp)
	movq %r9, 620(%rsp)
	callq __c0_K
	movq 588(%rsp), %rcx
	movq 596(%rsp), %r8
	movq 620(%rsp), %r9
	movl %eax, %esi
	movl 1052(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl 724(%rsp), %ecx
	addl %esi, %ecx
	addl 736(%rsp), %ecx
	movl 728(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl 1040(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl $30, %esi
	movl 1044(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 636(%rsp)
	movq %r8, 580(%rsp)
	movq %r9, 652(%rsp)
	callq __c0_ROTL
	movq 636(%rsp), %rcx
	movq 580(%rsp), %r8
	movq 652(%rsp), %r9
	movl %eax, %edx
	movl %edx, 728(%rsp)
	movl 1048(%rsp), %r10d
	movl %r10d, 1040(%rsp)
	movl %ecx, 1044(%rsp)
	movl $5, %edx
	movl 1044(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 628(%rsp)
	movq %r9, 644(%rsp)
	callq __c0_ROTL
	movq 628(%rsp), %r8
	movq 644(%rsp), %r9
	movl %eax, 1048(%rsp)
	movl $3, %edi
	movl 1040(%rsp), %esi
	movl 728(%rsp), %edx
	movl 724(%rsp), %ecx
	movq %r8, 620(%rsp)
	movq %r9, 628(%rsp)
	callq __c0_f
	movq 620(%rsp), %r8
	movq 628(%rsp), %r9
	movl %eax, %ecx
	movl $3, %edx
	movl %edx, %edi
	movq %rcx, 596(%rsp)
	movq %r8, 620(%rsp)
	movq %r9, 628(%rsp)
	callq __c0_K
	movq 596(%rsp), %rcx
	movq 620(%rsp), %r8
	movq 628(%rsp), %r9
	movl %eax, %esi
	movl 1048(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl 736(%rsp), %ecx
	addl %esi, %ecx
	addl 740(%rsp), %ecx
	movl 724(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl 728(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl $30, %esi
	movl 1040(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 644(%rsp)
	movq %r8, 580(%rsp)
	movq %r9, 652(%rsp)
	callq __c0_ROTL
	movq 644(%rsp), %rcx
	movq 580(%rsp), %r8
	movq 652(%rsp), %r9
	movl %eax, %edx
	movl %edx, 728(%rsp)
	movl 1044(%rsp), %r10d
	movl %r10d, 1040(%rsp)
	movl %ecx, 1044(%rsp)
	movl $5, %edx
	movl 1044(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 628(%rsp)
	movq %r9, 644(%rsp)
	callq __c0_ROTL
	movq 628(%rsp), %r8
	movq 644(%rsp), %r9
	movl %eax, 1048(%rsp)
	movl $4, %edi
	movl 1040(%rsp), %esi
	movl 728(%rsp), %edx
	movl 724(%rsp), %ecx
	movq %r8, 620(%rsp)
	movq %r9, 628(%rsp)
	callq __c0_f
	movq 620(%rsp), %r8
	movq 628(%rsp), %r9
	movl %eax, %ecx
	movl $4, %edx
	movl %edx, %edi
	movq %rcx, 596(%rsp)
	movq %r8, 620(%rsp)
	movq %r9, 628(%rsp)
	callq __c0_K
	movq 596(%rsp), %rcx
	movq 620(%rsp), %r8
	movq 628(%rsp), %r9
	movl %eax, %esi
	movl 1048(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl 736(%rsp), %ecx
	addl %esi, %ecx
	addl 744(%rsp), %ecx
	movl 724(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl 728(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl $30, %esi
	movl 1040(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 580(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 580(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, %edx
	movl %edx, 724(%rsp)
	movl 1044(%rsp), %r10d
	movl %r10d, 728(%rsp)
	movl %ecx, 1040(%rsp)
	movl $5, %edx
	movl 1040(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 644(%rsp)
	movq %r9, 636(%rsp)
	callq __c0_ROTL
	movq 644(%rsp), %r8
	movq 636(%rsp), %r9
	movl %eax, 1044(%rsp)
	movl $5, %edi
	movl 728(%rsp), %esi
	movl 724(%rsp), %edx
	movl 744(%rsp), %ecx
	movq %r8, 628(%rsp)
	movq %r9, 644(%rsp)
	callq __c0_f
	movq 628(%rsp), %r8
	movq 644(%rsp), %r9
	movl %eax, %ecx
	movl $5, %edx
	movl %edx, %edi
	movq %rcx, 620(%rsp)
	movq %r8, 628(%rsp)
	movq %r9, 644(%rsp)
	callq __c0_K
	movq 620(%rsp), %rcx
	movq 628(%rsp), %r8
	movq 644(%rsp), %r9
	movl %eax, %esi
	movl 1044(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl 736(%rsp), %ecx
	addl %esi, %ecx
	addl 748(%rsp), %ecx
	movl 744(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl 724(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl $30, %esi
	movl 728(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 668(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 668(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, %edx
	movl %edx, 724(%rsp)
	movl 1040(%rsp), %r10d
	movl %r10d, 728(%rsp)
	movl %ecx, 748(%rsp)
	movl $5, %edx
	movl 748(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 636(%rsp)
	movq %r9, 580(%rsp)
	callq __c0_ROTL
	movq 636(%rsp), %r8
	movq 580(%rsp), %r9
	movl %eax, 1040(%rsp)
	movl $6, %edi
	movl 728(%rsp), %esi
	movl 724(%rsp), %edx
	movl 744(%rsp), %ecx
	movq %r8, 644(%rsp)
	movq %r9, 636(%rsp)
	callq __c0_f
	movq 644(%rsp), %r8
	movq 636(%rsp), %r9
	movl %eax, %ecx
	movl $6, %edx
	movl %edx, %edi
	movq %rcx, 628(%rsp)
	movq %r8, 644(%rsp)
	movq %r9, 636(%rsp)
	callq __c0_K
	movq 628(%rsp), %rcx
	movq 644(%rsp), %r8
	movq 636(%rsp), %r9
	movl %eax, %esi
	movl 1040(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl 736(%rsp), %ecx
	addl %esi, %ecx
	addl 752(%rsp), %ecx
	movl 744(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl 724(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl $30, %esi
	movl 728(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 580(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 580(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, %edx
	movl %edx, 724(%rsp)
	movl 748(%rsp), %r10d
	movl %r10d, 728(%rsp)
	movl %ecx, 748(%rsp)
	movl $5, %edx
	movl 748(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 636(%rsp)
	movq %r9, 580(%rsp)
	callq __c0_ROTL
	movq 636(%rsp), %r8
	movq 580(%rsp), %r9
	movl %eax, 1040(%rsp)
	movl $7, %edi
	movl 728(%rsp), %esi
	movl 724(%rsp), %edx
	movl 744(%rsp), %ecx
	movq %r8, 644(%rsp)
	movq %r9, 636(%rsp)
	callq __c0_f
	movq 644(%rsp), %r8
	movq 636(%rsp), %r9
	movl %eax, %ecx
	movl $7, %edx
	movl %edx, %edi
	movq %rcx, 628(%rsp)
	movq %r8, 644(%rsp)
	movq %r9, 636(%rsp)
	callq __c0_K
	movq 628(%rsp), %rcx
	movq 644(%rsp), %r8
	movq 636(%rsp), %r9
	movl %eax, %esi
	movl 1040(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl 736(%rsp), %ecx
	addl %esi, %ecx
	addl %ebx, %ecx
	movl 744(%rsp), %ebx
	movl 724(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl $30, %esi
	movl 728(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 652(%rsp)
	movq %r8, 660(%rsp)
	movq %r9, 676(%rsp)
	callq __c0_ROTL
	movq 652(%rsp), %rcx
	movq 660(%rsp), %r8
	movq 676(%rsp), %r9
	movl %eax, %edx
	movl %edx, 744(%rsp)
	movl 748(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl %ecx, 728(%rsp)
	movl $5, %edx
	movl 728(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 580(%rsp)
	movq %r9, 668(%rsp)
	callq __c0_ROTL
	movq 580(%rsp), %r8
	movq 668(%rsp), %r9
	movl %eax, 748(%rsp)
	movl $8, %edi
	movl 724(%rsp), %esi
	movl 744(%rsp), %edx
	movl 736(%rsp), %ecx
	movq %r8, 636(%rsp)
	movq %r9, 580(%rsp)
	callq __c0_f
	movq 636(%rsp), %r8
	movq 580(%rsp), %r9
	movl %eax, %ecx
	movl $8, %edx
	movl %edx, %edi
	movq %rcx, 644(%rsp)
	movq %r8, 636(%rsp)
	movq %r9, 580(%rsp)
	callq __c0_K
	movq 644(%rsp), %rcx
	movq 636(%rsp), %r8
	movq 580(%rsp), %r9
	movl %eax, %esi
	movl 748(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl %r14d, %ecx
	movl 736(%rsp), %ebx
	movl 744(%rsp), %r14d
	movl $30, %esi
	movl 724(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 660(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 660(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %edx
	movl %edx, 736(%rsp)
	movl 728(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl %ecx, 724(%rsp)
	movl $5, %edx
	movl 724(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 668(%rsp)
	movq %r9, 652(%rsp)
	callq __c0_ROTL
	movq 668(%rsp), %r8
	movq 652(%rsp), %r9
	movl %eax, 728(%rsp)
	movl $9, %edi
	movl 744(%rsp), %esi
	movl 736(%rsp), %edx
	movl %r14d, %ecx
	movq %r8, 580(%rsp)
	movq %r9, 668(%rsp)
	callq __c0_f
	movq 580(%rsp), %r8
	movq 668(%rsp), %r9
	movl %eax, %ecx
	movl $9, %edx
	movl %edx, %edi
	movq %rcx, 636(%rsp)
	movq %r8, 580(%rsp)
	movq %r9, 668(%rsp)
	callq __c0_K
	movq 636(%rsp), %rcx
	movq 580(%rsp), %r8
	movq 668(%rsp), %r9
	movl %eax, %esi
	movl 728(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 760(%rsp), %ecx
	movl %r14d, %ebx
	movl 736(%rsp), %r14d
	movl $30, %esi
	movl 744(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 692(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 692(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %edx
	movl %edx, 736(%rsp)
	movl 724(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl %ecx, 760(%rsp)
	movl $5, %edx
	movl 760(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 652(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 652(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, 724(%rsp)
	movl $10, %edi
	movl 744(%rsp), %esi
	movl 736(%rsp), %edx
	movl %r14d, %ecx
	movq %r8, 668(%rsp)
	movq %r9, 652(%rsp)
	callq __c0_f
	movq 668(%rsp), %r8
	movq 652(%rsp), %r9
	movl %eax, %ecx
	movl $10, %edx
	movl %edx, %edi
	movq %rcx, 580(%rsp)
	movq %r8, 668(%rsp)
	movq %r9, 652(%rsp)
	callq __c0_K
	movq 580(%rsp), %rcx
	movq 668(%rsp), %r8
	movq 652(%rsp), %r9
	movl %eax, %esi
	movl 724(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 764(%rsp), %ecx
	movl %r14d, %ebx
	movl 736(%rsp), %r14d
	movl $30, %esi
	movl 744(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 660(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 660(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %edx
	movl %edx, 736(%rsp)
	movl 760(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl %ecx, 760(%rsp)
	movl $5, %edx
	movl 760(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 700(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 700(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, 724(%rsp)
	movl $11, %edi
	movl 744(%rsp), %esi
	movl 736(%rsp), %edx
	movl %r14d, %ecx
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_f
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %ecx
	movl $11, %edx
	movl %edx, %edi
	movq %rcx, 668(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_K
	movq 668(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %esi
	movl 724(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 768(%rsp), %ecx
	movl %r14d, %ebx
	movl 736(%rsp), %r14d
	movl $30, %esi
	movl 744(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 660(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 660(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %edx
	movl %edx, 736(%rsp)
	movl 760(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl %ecx, 760(%rsp)
	movl $5, %edx
	movl 760(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 700(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 700(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, 724(%rsp)
	movl $12, %edi
	movl 744(%rsp), %esi
	movl 736(%rsp), %edx
	movl %r14d, %ecx
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_f
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %ecx
	movl $12, %edx
	movl %edx, %edi
	movq %rcx, 668(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_K
	movq 668(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %esi
	movl 724(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 772(%rsp), %ecx
	movl %r14d, %ebx
	movl 736(%rsp), %r14d
	movl $30, %esi
	movl 744(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 660(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 660(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %edx
	movl %edx, 736(%rsp)
	movl 760(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl %ecx, 760(%rsp)
	movl $5, %edx
	movl 760(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 700(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 700(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, 724(%rsp)
	movl $13, %edi
	movl 744(%rsp), %esi
	movl 736(%rsp), %edx
	movl %r14d, %ecx
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_f
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %ecx
	movl $13, %edx
	movl %edx, %edi
	movq %rcx, 668(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_K
	movq 668(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %esi
	movl 724(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 776(%rsp), %ecx
	movl %r14d, %ebx
	movl 736(%rsp), %r14d
	movl $30, %esi
	movl 744(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 660(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 660(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %edx
	movl %edx, 736(%rsp)
	movl 760(%rsp), %r10d
	movl %r10d, 744(%rsp)
	movl %ecx, 760(%rsp)
	movl $5, %edx
	movl 760(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 700(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_ROTL
	movq 700(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, 724(%rsp)
	movl $14, %edi
	movl 744(%rsp), %esi
	movl 736(%rsp), %edx
	movl %r14d, %ecx
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_f
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %ecx
	movl $14, %edx
	movl %edx, %edi
	movq %rcx, 668(%rsp)
	movq %r8, 652(%rsp)
	movq %r9, 700(%rsp)
	callq __c0_K
	movq 668(%rsp), %rcx
	movq 652(%rsp), %r8
	movq 700(%rsp), %r9
	movl %eax, %esi
	movl 724(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl %r12d, %ecx
	movl %r14d, %ebx
	movl 736(%rsp), %r12d
	movl $30, %esi
	movl 744(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 676(%rsp)
	movq %r8, 684(%rsp)
	movq %r9, %r14
	callq __c0_ROTL
	movq 676(%rsp), %rcx
	movq 684(%rsp), %r8
	movq %r14, %r9
	movl %eax, %edx
	movl %edx, %r14d
	movl 760(%rsp), %r10d
	movl %r10d, 736(%rsp)
	movl %ecx, 744(%rsp)
	movl $5, %edx
	movl 744(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 660(%rsp)
	movq %r9, 692(%rsp)
	callq __c0_ROTL
	movq 660(%rsp), %r8
	movq 692(%rsp), %r9
	movl %eax, 760(%rsp)
	movl $15, %edi
	movl 736(%rsp), %esi
	movl %r14d, %edx
	movl %r12d, %ecx
	movq %r8, 700(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_f
	movq 700(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, %ecx
	movl $15, %edx
	movl %edx, %edi
	movq %rcx, 652(%rsp)
	movq %r8, 700(%rsp)
	movq %r9, 660(%rsp)
	callq __c0_K
	movq 652(%rsp), %rcx
	movq 700(%rsp), %r8
	movq 660(%rsp), %r9
	movl %eax, %esi
	movl 760(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl %r13d, %ecx
	movl %r12d, %ebx
	movl %r14d, %r12d
	movl $30, %esi
	movl 736(%rsp), %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, 684(%rsp)
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq 684(%rsp), %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl 744(%rsp), %r14d
	movl %ecx, 736(%rsp)
	movl $5, %edx
	movl 736(%rsp), %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 692(%rsp)
	movq %r9, 676(%rsp)
	callq __c0_ROTL
	movq 692(%rsp), %r8
	movq 676(%rsp), %r9
	movl %eax, 744(%rsp)
	movl $16, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 660(%rsp)
	movq %r9, 692(%rsp)
	callq __c0_f
	movq 660(%rsp), %r8
	movq 692(%rsp), %r9
	movl %eax, %ecx
	movl $16, %edx
	movl %edx, %edi
	movq %rcx, 700(%rsp)
	movq %r8, 660(%rsp)
	movq %r9, 692(%rsp)
	callq __c0_K
	movq 700(%rsp), %rcx
	movq 660(%rsp), %r8
	movq 692(%rsp), %r9
	movl %eax, %edx
	movl 744(%rsp), %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl %r15d, %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl 736(%rsp), %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_ROTL
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, 736(%rsp)
	movl $17, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 692(%rsp)
	movq %r9, 676(%rsp)
	callq __c0_f
	movq 692(%rsp), %r8
	movq 676(%rsp), %r9
	movl %eax, %ecx
	movl $17, %edx
	movl %edx, %edi
	movq %rcx, 660(%rsp)
	movq %r8, 692(%rsp)
	movq %r9, 676(%rsp)
	callq __c0_K
	movq 660(%rsp), %rcx
	movq 692(%rsp), %r8
	movq 676(%rsp), %r9
	movl %eax, %esi
	movl 736(%rsp), %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl %ebp, %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 684(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 684(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $18, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_f
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %ecx
	movl $18, %edx
	movl %edx, %edi
	movq %rcx, 692(%rsp)
	movq %r8, 676(%rsp)
	movq %r9, 684(%rsp)
	callq __c0_K
	movq 692(%rsp), %rcx
	movq 676(%rsp), %r8
	movq 684(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 792(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $19, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 684(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 684(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $19, %edx
	movl %edx, %edi
	movq %rcx, 676(%rsp)
	movq %r8, 684(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 676(%rsp), %rcx
	movq 684(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 796(%rsp), %ecx
	movl %r12d, %ebp
	movl %r13d, 792(%rsp)
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq __c0_ROTL
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %edx, %ebx
	movl %r15d, %r12d
	movl %ecx, %r13d
	movl $5, %edx
	movl %r13d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, %r15
	movq %r9, %r14
	callq __c0_ROTL
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %r14d
	movl $20, %edi
	movl %r12d, %esi
	movl %ebx, %edx
	movl 792(%rsp), %ecx
	movq %r8, 92(%rsp)
	movq %r9, %r15
	callq __c0_f
	movq 92(%rsp), %r8
	movq %r15, %r9
	movl %eax, %ecx
	movl $20, %edx
	movl %edx, %edi
	movq %rcx, 684(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, %r15
	callq __c0_K
	movq 684(%rsp), %rcx
	movq 92(%rsp), %r8
	movq %r15, %r9
	movl %eax, %esi
	movl %r14d, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebp, %ecx
	addl %esi, %ecx
	addl 800(%rsp), %ecx
	movl 792(%rsp), %r14d
	movl $30, %esi
	movl %r12d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, %edx
	movl %edx, %r12d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $21, %edi
	movl %r13d, %esi
	movl %r12d, %edx
	movl %ebx, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $21, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r14d, %ecx
	addl %esi, %ecx
	addl 804(%rsp), %ecx
	movl $30, %esi
	movl %r13d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $22, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $22, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 808(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $23, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $23, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 812(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $24, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $24, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 816(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $25, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $25, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 820(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $26, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $26, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 824(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $27, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $27, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 828(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $28, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $28, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 832(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $29, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $29, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 836(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $30, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $30, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 840(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $31, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $31, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 844(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $32, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $32, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 848(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $33, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $33, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 852(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $34, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $34, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 856(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $35, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $35, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 860(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $36, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $36, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 864(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $37, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $37, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 868(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $38, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $38, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 872(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $39, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $39, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 876(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $40, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $40, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 880(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $41, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $41, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 884(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $42, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $42, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 888(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $43, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $43, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 892(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $44, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $44, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 896(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $45, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $45, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 900(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $46, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $46, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 904(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $47, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $47, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 908(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $48, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $48, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 912(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $49, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $49, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 916(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $50, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $50, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 920(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $51, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $51, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 924(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $52, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $52, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 928(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $53, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $53, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 932(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $54, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $54, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 936(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $55, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $55, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 940(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $56, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $56, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 944(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $57, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $57, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 948(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $58, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $58, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 952(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $59, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $59, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 956(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $60, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $60, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 960(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $61, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $61, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 964(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $62, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $62, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 968(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $63, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $63, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 972(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $64, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $64, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 976(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $65, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $65, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 980(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $66, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $66, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 984(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $67, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $67, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 988(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $68, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $68, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 992(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $69, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $69, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 996(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $70, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $70, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 1000(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $71, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $71, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 1004(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $72, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $72, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 1008(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $73, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $73, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 1012(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $74, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $74, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 1016(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $75, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $75, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 1020(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $76, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $76, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 1024(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $77, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $77, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 1028(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $78, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $78, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl %ebp, %esi
	addl %ecx, %esi
	movl %esi, %ecx
	addl %ebx, %ecx
	addl %edx, %ecx
	addl 1032(%rsp), %ecx
	movl %r12d, %ebx
	movl %r13d, %r12d
	movl $30, %esi
	movl %r14d, %edx
	movl %esi, %edi
	movl %edx, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq __c0_ROTL
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %edx, %r13d
	movl %r15d, %r14d
	movl %ecx, %r15d
	movl $5, %edx
	movl %r15d, %ecx
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %rbp
	callq __c0_ROTL
	movq 84(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $79, %edi
	movl %r14d, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_f
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %ecx
	movl $79, %edx
	movl %edx, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq __c0_K
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %esi
	movl %ebp, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %ebx, %ecx
	addl %esi, %ecx
	addl 1036(%rsp), %ecx
	movl %r12d, %edx
	movl %r13d, %ebx
	movl $30, %edi
	movl %r14d, %esi
	movq %rdx, %rbp
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq __c0_ROTL
	movq %rbp, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl %esi, %eax
	movl %r15d, %edi
	movl %ecx, %esi
	movl %r8d, %ecx
	addl %esi, %ecx
	movl 720(%rsp), %esi
	addl %edi, %esi
	movl 716(%rsp), %r8d
	addl %eax, %r8d
	movl 712(%rsp), %eax
	addl %ebx, %eax
	movl 708(%rsp), %edi
	addl %edx, %edi
.__c0_main_437:
	movl %edi, 708(%rsp)
	movl %eax, 712(%rsp)
	movl %r8d, 716(%rsp)
	movl %esi, 720(%rsp)
	movl %ecx, %r8d
	movl 732(%rsp), %eax
	movl 756(%rsp), %r13d
	movl 780(%rsp), %esi
	movl 788(%rsp), %edx
	movl 784(%rsp), %ebx
	jmp .__c0_main_1
.__c0_main_3:
	movl %r8d, %edi
	movq %r9, %rbx
	callq __c0_printhexPrints0x
	movq %rbx, %r9
	movl 720(%rsp), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq __c0_printhexPrints0x
	movq %rbx, %r9
	movl 716(%rsp), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq __c0_printhexPrints0x
	movq %rbx, %r9
	movl 712(%rsp), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq __c0_printhexPrints0x
	movq %rbx, %r9
	movl 708(%rsp), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq __c0_printhexPrints0x
	movq %rbx, %r9
	movl $32, %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq _printchar
	movq %rbx, %r9
	movl $32, %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq _printchar
	movq %rbx, %r9
	movl $45, %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq _printchar
	movq %rbx, %r9
	movl $10, %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq _printchar
	movq %rbx, %r9
	movl $0, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $1064, %rsp
	ret
	jmp .__c0_main_435
	jmp .__c0_main_434
	jmp .__c0_main_433
	jmp .__c0_main_428
	jmp .__c0_main_429
	jmp .__c0_main_430
	jmp .__c0_main_431
	jmp .__c0_main_432
	jmp .__c0_main_408
	jmp .__c0_main_407
	jmp .__c0_main_406
	jmp .__c0_main_401
	jmp .__c0_main_402
	jmp .__c0_main_403
	jmp .__c0_main_404
	jmp .__c0_main_405
	jmp .__c0_main_381
	jmp .__c0_main_380
	jmp .__c0_main_379
	jmp .__c0_main_374
	jmp .__c0_main_375
	jmp .__c0_main_376
	jmp .__c0_main_377
	jmp .__c0_main_378
	jmp .__c0_main_354
	jmp .__c0_main_353
	jmp .__c0_main_352
	jmp .__c0_main_347
	jmp .__c0_main_348
	jmp .__c0_main_349
	jmp .__c0_main_350
	jmp .__c0_main_351
	jmp .__c0_main_327
	jmp .__c0_main_326
	jmp .__c0_main_325
	jmp .__c0_main_320
	jmp .__c0_main_321
	jmp .__c0_main_322
	jmp .__c0_main_323
	jmp .__c0_main_324
	jmp .__c0_main_300
	jmp .__c0_main_299
	jmp .__c0_main_298
	jmp .__c0_main_293
	jmp .__c0_main_294
	jmp .__c0_main_295
	jmp .__c0_main_296
	jmp .__c0_main_297
	jmp .__c0_main_273
	jmp .__c0_main_272
	jmp .__c0_main_271
	jmp .__c0_main_266
	jmp .__c0_main_267
	jmp .__c0_main_268
	jmp .__c0_main_269
	jmp .__c0_main_270
	jmp .__c0_main_246
	jmp .__c0_main_245
	jmp .__c0_main_244
	jmp .__c0_main_239
	jmp .__c0_main_240
	jmp .__c0_main_241
	jmp .__c0_main_242
	jmp .__c0_main_243
	jmp .__c0_main_219
	jmp .__c0_main_218
	jmp .__c0_main_217
	jmp .__c0_main_212
	jmp .__c0_main_213
	jmp .__c0_main_214
	jmp .__c0_main_215
	jmp .__c0_main_216
	jmp .__c0_main_192
	jmp .__c0_main_191
	jmp .__c0_main_190
	jmp .__c0_main_185
	jmp .__c0_main_186
	jmp .__c0_main_187
	jmp .__c0_main_188
	jmp .__c0_main_189
	jmp .__c0_main_165
	jmp .__c0_main_164
	jmp .__c0_main_163
	jmp .__c0_main_158
	jmp .__c0_main_159
	jmp .__c0_main_160
	jmp .__c0_main_161
	jmp .__c0_main_162
	jmp .__c0_main_138
	jmp .__c0_main_137
	jmp .__c0_main_136
	jmp .__c0_main_131
	jmp .__c0_main_132
	jmp .__c0_main_133
	jmp .__c0_main_134
	jmp .__c0_main_135
	jmp .__c0_main_111
	jmp .__c0_main_110
	jmp .__c0_main_109
	jmp .__c0_main_104
	jmp .__c0_main_105
	jmp .__c0_main_106
	jmp .__c0_main_107
	jmp .__c0_main_108
	jmp .__c0_main_84
	jmp .__c0_main_83
	jmp .__c0_main_82
	jmp .__c0_main_77
	jmp .__c0_main_78
	jmp .__c0_main_79
	jmp .__c0_main_80
	jmp .__c0_main_81
	jmp .__c0_main_57
	jmp .__c0_main_56
	jmp .__c0_main_55
	jmp .__c0_main_50
	jmp .__c0_main_51
	jmp .__c0_main_52
	jmp .__c0_main_53
	jmp .__c0_main_54
	jmp .__c0_main_30
	jmp .__c0_main_29
	jmp .__c0_main_28
	jmp .__c0_main_23
	jmp .__c0_main_24
	jmp .__c0_main_25
	jmp .__c0_main_26
	jmp .__c0_main_27
.ident	"15-411 L5 compiler"
_raise_segv:
	movq $0, %rax
	movl (%rax), %eax
_salloc:
	addq $-8, %rsp
	callq _calloc
	cmpq $0, %rax
	jz _raise_segv
	addq $8, %rsp
	ret
_salloc_array:
	pushq %rdi
	cmpq $0, %rdi
	jl _raise_segv
	imulq %rsi, %rdi
	addq $8, %rdi
	movq $1, %rsi
	callq _calloc
	cmpq $0, %rax
	jz _raise_segv
	popq %rdi
	movl %edi, (%rax)
	addq $8, %rax
	ret
