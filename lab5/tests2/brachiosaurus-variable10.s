.file	"../tests2/brachiosaurus-variable10.l2"
.globl _c0_main
_c0_main:
	addq $-216, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_46
.main_1:
	movl $1, 52(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_23
.main_2:
	movl 52(%rsp), %r10d
	movl %r10d, 56(%rsp)
	addl $1, 56(%rsp)
	movl $10, %ebp
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_12
.main_3:
	movl 56(%rsp), %r14d
	addl $1, %r14d
	movl %ebp, %r13d
	addl $1, %r13d
	movl $100, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_4:
	movl %r14d, %edi
	addl $1, %edi
	movl %r13d, %esi
	addl $1, %esi
	movl %r12d, %ebx
	addl $1, %ebx
	movl $1000, %eax
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_6
.main_5:
	addl $1, %edi
	addl $1, %esi
	movl %ebx, %ecx
	addl $1, %ecx
	movl %eax, %r8d
	addl $1, %r8d
	movl $10000, %r9d
.main_95:
	movl %r9d, %ebx
	movl %r8d, %eax
	movl %ecx, %edx
	movl %esi, %ecx
	movl %edi, %r8d
.main_10:
.main_103:
	movl %ebx, %edi
	movl %eax, %esi
.main_21:
.main_119:
.main_44:
.main_151:
.main_91:
.main_155:
.main_93:
	movl %r8d, %r9d
	addl %ecx, %r9d
	addl %edx, %r9d
	addl %esi, %r9d
	movl %r9d, %eax
	addl %edi, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $216, %rsp
	ret
.main_6:
	addl $1, %edi
	addl $1, %esi
	movl %ebx, %edx
	addl $1, %edx
	movl %eax, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_94:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_10
.main_7:
	movl %r14d, %r15d
	addl $1, %r15d
	movl %r13d, %r14d
	addl $1, %r14d
	movl %r12d, %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_9
.main_8:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_97:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_11:
.main_102:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_21
.main_9:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_96:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_11
.main_12:
	movl 56(%rsp), %r10d
	movl %r10d, 60(%rsp)
	addl $1, 60(%rsp)
	movl %ebp, 56(%rsp)
	addl $1, 56(%rsp)
	movl $100, %ebp
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_16
.main_13:
	movl 60(%rsp), %r10d
	movl %r10d, 64(%rsp)
	addl $1, 64(%rsp)
	movl 56(%rsp), %r10d
	movl %r10d, 68(%rsp)
	addl $1, 68(%rsp)
	movl %ebp, 72(%rsp)
	addl $1, 72(%rsp)
	movl $1000, 76(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_15
.main_14:
	movl 64(%rsp), %edi
	addl $1, %edi
	movl 68(%rsp), %esi
	addl $1, %esi
	movl 72(%rsp), %edx
	addl $1, %edx
	movl 76(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_99:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_19:
.main_105:
	movl %ebx, %edi
	movl %eax, %esi
.main_22:
.main_118:
	jmp .main_44
.main_15:
	movl 64(%rsp), %edi
	addl $1, %edi
	movl 68(%rsp), %esi
	addl $1, %esi
	movl 72(%rsp), %edx
	addl $1, %edx
	movl 76(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_98:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_19
.main_16:
	movl 60(%rsp), %r15d
	addl $1, %r15d
	movl 56(%rsp), %r14d
	addl $1, %r14d
	movl %ebp, %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_18
.main_17:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_101:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_20:
.main_104:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_22
.main_18:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_100:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_20
.main_23:
	movl 52(%rsp), %r10d
	movl %r10d, 64(%rsp)
	addl $1, 64(%rsp)
	movl $10, 52(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_33
.main_24:
	movl 64(%rsp), %r10d
	movl %r10d, 80(%rsp)
	addl $1, 80(%rsp)
	movl 52(%rsp), %r10d
	movl %r10d, 84(%rsp)
	addl $1, 84(%rsp)
	movl $100, 88(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_28
.main_25:
	movl 80(%rsp), %r10d
	movl %r10d, 92(%rsp)
	addl $1, 92(%rsp)
	movl 84(%rsp), %r10d
	movl %r10d, 96(%rsp)
	addl $1, 96(%rsp)
	movl 88(%rsp), %r10d
	movl %r10d, 100(%rsp)
	addl $1, 100(%rsp)
	movl $1000, 104(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_27
.main_26:
	movl 92(%rsp), %edi
	addl $1, %edi
	movl 96(%rsp), %esi
	addl $1, %esi
	movl 100(%rsp), %edx
	addl $1, %edx
	movl 104(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_107:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_31:
.main_115:
	movl %ebx, %edi
	movl %eax, %esi
.main_42:
.main_121:
.main_45:
.main_150:
	jmp .main_91
.main_27:
	movl 92(%rsp), %edi
	addl $1, %edi
	movl 96(%rsp), %esi
	addl $1, %esi
	movl 100(%rsp), %edx
	addl $1, %edx
	movl 104(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_106:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_31
.main_28:
	movl 80(%rsp), %r15d
	addl $1, %r15d
	movl 84(%rsp), %r14d
	addl $1, %r14d
	movl 88(%rsp), %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_30
.main_29:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_109:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_32:
.main_114:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_42
.main_30:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_108:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_32
.main_33:
	movl 64(%rsp), %r10d
	movl %r10d, 60(%rsp)
	addl $1, 60(%rsp)
	movl 52(%rsp), %r10d
	movl %r10d, 56(%rsp)
	addl $1, 56(%rsp)
	movl $100, %ebp
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_37
.main_34:
	movl 60(%rsp), %r10d
	movl %r10d, 108(%rsp)
	addl $1, 108(%rsp)
	movl 56(%rsp), %r10d
	movl %r10d, 112(%rsp)
	addl $1, 112(%rsp)
	movl %ebp, 116(%rsp)
	addl $1, 116(%rsp)
	movl $1000, 120(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_36
.main_35:
	movl 108(%rsp), %edi
	addl $1, %edi
	movl 112(%rsp), %esi
	addl $1, %esi
	movl 116(%rsp), %edx
	addl $1, %edx
	movl 120(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_111:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_40:
.main_117:
	movl %ebx, %edi
	movl %eax, %esi
.main_43:
.main_120:
	jmp .main_45
.main_36:
	movl 108(%rsp), %edi
	addl $1, %edi
	movl 112(%rsp), %esi
	addl $1, %esi
	movl 116(%rsp), %edx
	addl $1, %edx
	movl 120(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_110:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_40
.main_37:
	movl 60(%rsp), %r15d
	addl $1, %r15d
	movl 56(%rsp), %r14d
	addl $1, %r14d
	movl %ebp, %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_39
.main_38:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_113:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_41:
.main_116:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_43
.main_39:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_112:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_41
.main_46:
	movl $1, 68(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_68
.main_47:
	movl 68(%rsp), %r10d
	movl %r10d, 124(%rsp)
	addl $1, 124(%rsp)
	movl $10, 128(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_57
.main_48:
	movl 124(%rsp), %r10d
	movl %r10d, 132(%rsp)
	addl $1, 132(%rsp)
	movl 128(%rsp), %r10d
	movl %r10d, 136(%rsp)
	addl $1, 136(%rsp)
	movl $100, 140(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_52
.main_49:
	movl 132(%rsp), %r10d
	movl %r10d, 144(%rsp)
	addl $1, 144(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 148(%rsp)
	addl $1, 148(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 152(%rsp)
	addl $1, 152(%rsp)
	movl $1000, 156(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_51
.main_50:
	movl 144(%rsp), %edi
	addl $1, %edi
	movl 148(%rsp), %esi
	addl $1, %esi
	movl 152(%rsp), %edx
	addl $1, %edx
	movl 156(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_123:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_55:
.main_131:
	movl %ebx, %edi
	movl %eax, %esi
.main_66:
.main_147:
.main_89:
.main_153:
.main_92:
.main_154:
	jmp .main_93
.main_51:
	movl 144(%rsp), %edi
	addl $1, %edi
	movl 148(%rsp), %esi
	addl $1, %esi
	movl 152(%rsp), %edx
	addl $1, %edx
	movl 156(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_122:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_55
.main_52:
	movl 132(%rsp), %r15d
	addl $1, %r15d
	movl 136(%rsp), %r14d
	addl $1, %r14d
	movl 140(%rsp), %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_54
.main_53:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_125:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_56:
.main_130:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_66
.main_54:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_124:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_56
.main_57:
	movl 124(%rsp), %r10d
	movl %r10d, 60(%rsp)
	addl $1, 60(%rsp)
	movl 128(%rsp), %r10d
	movl %r10d, 56(%rsp)
	addl $1, 56(%rsp)
	movl $100, %ebp
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_61
.main_58:
	movl 60(%rsp), %r10d
	movl %r10d, 160(%rsp)
	addl $1, 160(%rsp)
	movl 56(%rsp), %r10d
	movl %r10d, 164(%rsp)
	addl $1, 164(%rsp)
	movl %ebp, 168(%rsp)
	addl $1, 168(%rsp)
	movl $1000, 172(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_60
.main_59:
	movl 160(%rsp), %edi
	addl $1, %edi
	movl 164(%rsp), %esi
	addl $1, %esi
	movl 168(%rsp), %edx
	addl $1, %edx
	movl 172(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_127:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_64:
.main_133:
	movl %ebx, %edi
	movl %eax, %esi
.main_67:
.main_146:
	jmp .main_89
.main_60:
	movl 160(%rsp), %edi
	addl $1, %edi
	movl 164(%rsp), %esi
	addl $1, %esi
	movl 168(%rsp), %edx
	addl $1, %edx
	movl 172(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_126:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_64
.main_61:
	movl 60(%rsp), %r15d
	addl $1, %r15d
	movl 56(%rsp), %r14d
	addl $1, %r14d
	movl %ebp, %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_63
.main_62:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_129:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_65:
.main_132:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_67
.main_63:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_128:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_65
.main_68:
	movl 68(%rsp), %r10d
	movl %r10d, 64(%rsp)
	addl $1, 64(%rsp)
	movl $10, 52(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_78
.main_69:
	movl 64(%rsp), %r10d
	movl %r10d, 176(%rsp)
	addl $1, 176(%rsp)
	movl 52(%rsp), %r10d
	movl %r10d, 180(%rsp)
	addl $1, 180(%rsp)
	movl $100, 184(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_73
.main_70:
	movl 176(%rsp), %r10d
	movl %r10d, 188(%rsp)
	addl $1, 188(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 192(%rsp)
	addl $1, 192(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 196(%rsp)
	addl $1, 196(%rsp)
	movl $1000, 200(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_72
.main_71:
	movl 188(%rsp), %edi
	addl $1, %edi
	movl 192(%rsp), %esi
	addl $1, %esi
	movl 196(%rsp), %edx
	addl $1, %edx
	movl 200(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_135:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_76:
.main_143:
	movl %ebx, %edi
	movl %eax, %esi
.main_87:
.main_149:
.main_90:
.main_152:
	jmp .main_92
.main_72:
	movl 188(%rsp), %edi
	addl $1, %edi
	movl 192(%rsp), %esi
	addl $1, %esi
	movl 196(%rsp), %edx
	addl $1, %edx
	movl 200(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_134:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_76
.main_73:
	movl 176(%rsp), %r15d
	addl $1, %r15d
	movl 180(%rsp), %r14d
	addl $1, %r14d
	movl 184(%rsp), %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_75
.main_74:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_137:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_77:
.main_142:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_87
.main_75:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_136:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_77
.main_78:
	movl 64(%rsp), %r10d
	movl %r10d, 60(%rsp)
	addl $1, 60(%rsp)
	movl 52(%rsp), %r10d
	movl %r10d, 56(%rsp)
	addl $1, 56(%rsp)
	movl $100, %ebp
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_82
.main_79:
	movl 60(%rsp), %r10d
	movl %r10d, 204(%rsp)
	addl $1, 204(%rsp)
	movl 56(%rsp), %r10d
	movl %r10d, 208(%rsp)
	addl $1, 208(%rsp)
	movl %ebp, 212(%rsp)
	addl $1, 212(%rsp)
	movl $1000, %r9d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_81
.main_80:
	movl 204(%rsp), %edi
	addl $1, %edi
	movl 208(%rsp), %esi
	addl $1, %esi
	movl 212(%rsp), %edx
	addl $1, %edx
	movl %r9d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_139:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_85:
.main_145:
	movl %ebx, %edi
	movl %eax, %esi
.main_88:
.main_148:
	jmp .main_90
.main_81:
	movl 204(%rsp), %edi
	addl $1, %edi
	movl 208(%rsp), %esi
	addl $1, %esi
	movl 212(%rsp), %edx
	addl $1, %edx
	movl %r9d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_138:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_85
.main_82:
	movl 60(%rsp), %r15d
	addl $1, %r15d
	movl 56(%rsp), %r14d
	addl $1, %r14d
	movl %ebp, %r13d
	addl $1, %r13d
	movl $1000, %r12d
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_84
.main_83:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_141:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_86:
.main_144:
	movl %ebx, %edi
	movl %eax, %esi
	jmp .main_88
.main_84:
	movl %r15d, %edi
	addl $1, %edi
	movl %r14d, %esi
	addl $1, %esi
	movl %r13d, %edx
	addl $1, %edx
	movl %r12d, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_140:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_86
.ident	"15-411 L4 reference compiler"
