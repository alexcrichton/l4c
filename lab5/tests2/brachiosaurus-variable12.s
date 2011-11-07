.file	"../tests2/brachiosaurus-variable12.l2"
.globl _c0_main
_c0_main:
	addq $-232, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
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
	movl $1, 64(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_23
.main_2:
	movl 64(%rsp), %r10d
	movl %r10d, 68(%rsp)
	addl $1, 68(%rsp)
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
	movl 68(%rsp), %r14d
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
	movl %r9d, %eax
	addl %edi, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $232, %rsp
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
	movl 68(%rsp), %r10d
	movl %r10d, 72(%rsp)
	addl $1, 72(%rsp)
	movl %ebp, 68(%rsp)
	addl $1, 68(%rsp)
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
	movl 72(%rsp), %r10d
	movl %r10d, 76(%rsp)
	addl $1, 76(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 80(%rsp)
	addl $1, 80(%rsp)
	movl %ebp, 84(%rsp)
	addl $1, 84(%rsp)
	movl $1000, 88(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_15
.main_14:
	movl 76(%rsp), %edi
	addl $1, %edi
	movl 80(%rsp), %esi
	addl $1, %esi
	movl 84(%rsp), %edx
	addl $1, %edx
	movl 88(%rsp), %ecx
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
	movl 76(%rsp), %edi
	addl $1, %edi
	movl 80(%rsp), %esi
	addl $1, %esi
	movl 84(%rsp), %edx
	addl $1, %edx
	movl 88(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_98:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_19
.main_16:
	movl 72(%rsp), %r15d
	addl $1, %r15d
	movl 68(%rsp), %r14d
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
	movl 64(%rsp), %r10d
	movl %r10d, 76(%rsp)
	addl $1, 76(%rsp)
	movl $10, 64(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_33
.main_24:
	movl 76(%rsp), %r10d
	movl %r10d, 92(%rsp)
	addl $1, 92(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 96(%rsp)
	addl $1, 96(%rsp)
	movl $100, 100(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_28
.main_25:
	movl 92(%rsp), %r10d
	movl %r10d, 104(%rsp)
	addl $1, 104(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 108(%rsp)
	addl $1, 108(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 112(%rsp)
	addl $1, 112(%rsp)
	movl $1000, 116(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_27
.main_26:
	movl 104(%rsp), %edi
	addl $1, %edi
	movl 108(%rsp), %esi
	addl $1, %esi
	movl 112(%rsp), %edx
	addl $1, %edx
	movl 116(%rsp), %ecx
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
	movl 104(%rsp), %edi
	addl $1, %edi
	movl 108(%rsp), %esi
	addl $1, %esi
	movl 112(%rsp), %edx
	addl $1, %edx
	movl 116(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_106:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_31
.main_28:
	movl 92(%rsp), %r15d
	addl $1, %r15d
	movl 96(%rsp), %r14d
	addl $1, %r14d
	movl 100(%rsp), %r13d
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
	movl 76(%rsp), %r10d
	movl %r10d, 72(%rsp)
	addl $1, 72(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 68(%rsp)
	addl $1, 68(%rsp)
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
	movl 72(%rsp), %r10d
	movl %r10d, 120(%rsp)
	addl $1, 120(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 124(%rsp)
	addl $1, 124(%rsp)
	movl %ebp, 128(%rsp)
	addl $1, 128(%rsp)
	movl $1000, 132(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_36
.main_35:
	movl 120(%rsp), %edi
	addl $1, %edi
	movl 124(%rsp), %esi
	addl $1, %esi
	movl 128(%rsp), %edx
	addl $1, %edx
	movl 132(%rsp), %ecx
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
	movl 120(%rsp), %edi
	addl $1, %edi
	movl 124(%rsp), %esi
	addl $1, %esi
	movl 128(%rsp), %edx
	addl $1, %edx
	movl 132(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_110:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_40
.main_37:
	movl 72(%rsp), %r15d
	addl $1, %r15d
	movl 68(%rsp), %r14d
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
	movl $1, 80(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_68
.main_47:
	movl 80(%rsp), %r10d
	movl %r10d, 136(%rsp)
	addl $1, 136(%rsp)
	movl $10, 140(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_57
.main_48:
	movl 136(%rsp), %r10d
	movl %r10d, 144(%rsp)
	addl $1, 144(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 148(%rsp)
	addl $1, 148(%rsp)
	movl $100, 152(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_52
.main_49:
	movl 144(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl $1, 156(%rsp)
	movl 148(%rsp), %r10d
	movl %r10d, 160(%rsp)
	addl $1, 160(%rsp)
	movl 152(%rsp), %r10d
	movl %r10d, 164(%rsp)
	addl $1, 164(%rsp)
	movl $1000, 168(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_51
.main_50:
	movl 156(%rsp), %edi
	addl $1, %edi
	movl 160(%rsp), %esi
	addl $1, %esi
	movl 164(%rsp), %edx
	addl $1, %edx
	movl 168(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_123:
	movl %r8d, %eax
	movl %esi, %ecx
	movl %edi, %r8d
.main_55:
.main_131:
	movl %eax, %esi
.main_66:
.main_147:
	movl %esi, %edi
.main_89:
.main_153:
	movl 172(%rsp), %esi
.main_92:
.main_154:
	jmp .main_93
.main_51:
	movl 156(%rsp), %edi
	addl $1, %edi
	movl 160(%rsp), %esi
	addl $1, %esi
	movl 164(%rsp), %edx
	addl $1, %edx
	movl 168(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_122:
	movl %r8d, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_55
.main_52:
	movl 144(%rsp), %r13d
	addl $1, %r13d
	movl 148(%rsp), %r12d
	addl $1, %r12d
	movl 152(%rsp), %ebx
	addl $1, %ebx
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_54
.main_53:
	movl %r13d, %esi
	addl $1, %esi
	movl %r12d, %edx
	addl $1, %edx
	movl %ebx, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_125:
	movl %r8d, %eax
	movl %ecx, %edi
	movl %edx, %ecx
	movl %esi, %r8d
.main_56:
.main_130:
	movl %eax, %esi
	movl %edi, %edx
	jmp .main_66
.main_54:
	movl %r13d, %esi
	addl $1, %esi
	movl %r12d, %edx
	addl $1, %edx
	movl %ebx, %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_124:
	movl %r8d, %eax
	movl %ecx, %edi
	movl %edx, %ecx
	movl %esi, %r8d
	jmp .main_56
.main_57:
	movl 136(%rsp), %r10d
	movl %r10d, 72(%rsp)
	addl $1, 72(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 68(%rsp)
	addl $1, 68(%rsp)
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
	movl 72(%rsp), %r10d
	movl %r10d, 176(%rsp)
	addl $1, 176(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 180(%rsp)
	addl $1, 180(%rsp)
	movl %ebp, 184(%rsp)
	addl $1, 184(%rsp)
	movl $1000, 188(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_60
.main_59:
	movl 176(%rsp), %edi
	addl $1, %edi
	movl 180(%rsp), %esi
	addl $1, %esi
	movl 184(%rsp), %edx
	addl $1, %edx
	movl 188(%rsp), %ecx
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
	movl %esi, 172(%rsp)
	jmp .main_89
.main_60:
	movl 176(%rsp), %edi
	addl $1, %edi
	movl 180(%rsp), %esi
	addl $1, %esi
	movl 184(%rsp), %edx
	addl $1, %edx
	movl 188(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_126:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_64
.main_61:
	movl 72(%rsp), %r15d
	addl $1, %r15d
	movl 68(%rsp), %r14d
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
	movl 80(%rsp), %r10d
	movl %r10d, 76(%rsp)
	addl $1, 76(%rsp)
	movl $10, 64(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_78
.main_69:
	movl 76(%rsp), %r10d
	movl %r10d, 192(%rsp)
	addl $1, 192(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 196(%rsp)
	addl $1, 196(%rsp)
	movl $100, 200(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_73
.main_70:
	movl 192(%rsp), %r10d
	movl %r10d, 204(%rsp)
	addl $1, 204(%rsp)
	movl 196(%rsp), %r10d
	movl %r10d, 208(%rsp)
	addl $1, 208(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 212(%rsp)
	addl $1, 212(%rsp)
	movl $1000, 216(%rsp)
	movl $1, %edx
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_72
.main_71:
	movl 204(%rsp), %edi
	addl $1, %edi
	movl 208(%rsp), %esi
	addl $1, %esi
	movl 212(%rsp), %edx
	addl $1, %edx
	movl 216(%rsp), %ecx
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
	movl 204(%rsp), %edi
	addl $1, %edi
	movl 208(%rsp), %esi
	addl $1, %esi
	movl 212(%rsp), %edx
	addl $1, %edx
	movl 216(%rsp), %ecx
	addl $1, %ecx
	movl $10000, %r8d
.main_134:
	movl %r8d, %ebx
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	jmp .main_76
.main_73:
	movl 192(%rsp), %r15d
	addl $1, %r15d
	movl 196(%rsp), %r14d
	addl $1, %r14d
	movl 200(%rsp), %r13d
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
	movl 76(%rsp), %r10d
	movl %r10d, 72(%rsp)
	addl $1, 72(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 68(%rsp)
	addl $1, 68(%rsp)
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
	movl 72(%rsp), %r10d
	movl %r10d, 220(%rsp)
	addl $1, 220(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 224(%rsp)
	addl $1, 224(%rsp)
	movl %ebp, 228(%rsp)
	addl $1, 228(%rsp)
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
	movl 220(%rsp), %edi
	addl $1, %edi
	movl 224(%rsp), %esi
	addl $1, %esi
	movl 228(%rsp), %edx
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
	movl 220(%rsp), %edi
	addl $1, %edi
	movl 224(%rsp), %esi
	addl $1, %esi
	movl 228(%rsp), %edx
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
	movl 72(%rsp), %r15d
	addl $1, %r15d
	movl 68(%rsp), %r14d
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
