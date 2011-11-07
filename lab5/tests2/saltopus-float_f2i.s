.file	"../tests2/saltopus-float_f2i.l2"
.globl _c0_main
_c0_main:
	addq $-280, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movl $1245691747, %eax
	movl $0, 64(%rsp)
	movl $0, 68(%rsp)
	movl $0, 72(%rsp)
	movl $0, 76(%rsp)
	movl $0, 80(%rsp)
	movl $0, %ecx
	movl $0, 84(%rsp)
	movl $0, 88(%rsp)
	movl $0, 92(%rsp)
	movl $0, 96(%rsp)
	movl $0, 100(%rsp)
	movl $0, 104(%rsp)
	movl $0, 108(%rsp)
	movl $0, 112(%rsp)
	movl $0, 116(%rsp)
	movl $0, 120(%rsp)
	movl $0, 124(%rsp)
	movl $0, %ebp
	movl $0, %r14d
	movl $0, %r13d
	movl $0, %r12d
	movl $0, %ebx
.main_133:
	movl %ebx, 128(%rsp)
	movl %r13d, 132(%rsp)
	movl %r14d, 136(%rsp)
	movl %ebp, 140(%rsp)
	movl 124(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 120(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 104(%rsp), %ebx
	movl 100(%rsp), %r12d
	movl 96(%rsp), %r13d
	movl 92(%rsp), %r14d
	movl %ecx, %ebp
	movl 72(%rsp), %r10d
	movl %r10d, 80(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 68(%rsp)
.main_1:
	movl $1, 64(%rsp)
	movl $1, %ecx
	cmpl %ecx, 64(%rsp)
	jnz .main_122
.main_2:
	movl 68(%rsp), %r10d
	movl %r10d, 64(%rsp)
	movl 72(%rsp), %r10d
	subl %r10d, 64(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 124(%rsp)
	movl 72(%rsp), %r10d
	andl %r10d, 124(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 120(%rsp)
	movl 80(%rsp), %ecx
	sarl %cl, 120(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 116(%rsp)
	movl 80(%rsp), %ecx
	sall %cl, 116(%rsp)
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 108(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_3
.main_10:
.main_137:
	movl 152(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 160(%rsp)
.main_12:
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 144(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_13
.main_48:
.main_141:
	movl 144(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl %ebp, 168(%rsp)
.main_50:
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_51
.main_119:
	movl %eax, 72(%rsp)
	movl $2139095040, %ebp
	movl $1, %ecx
.main_175:
	movl %ecx, 172(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl %ebx, 84(%rsp)
	movl %r12d, 88(%rsp)
	movl %r13d, 92(%rsp)
	movl %r14d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl %ebp, 104(%rsp)
	movl 72(%rsp), %ecx
.main_121:
.main_123:
	movl 172(%rsp), %r10d
	movl %r10d, 128(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 112(%rsp)
	movl 76(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 84(%rsp), %ebx
	movl 88(%rsp), %r12d
	movl 92(%rsp), %r13d
	movl 96(%rsp), %r14d
	movl 168(%rsp), %ebp
	movl 100(%rsp), %r10d
	movl %r10d, 80(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl %ecx, 68(%rsp)
	jmp .main_1
.main_51:
	movl $1, 100(%rsp)
	movl $1, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_56
.main_52:
	movl $1, 100(%rsp)
	movl $2139095040, 104(%rsp)
	movl 124(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_55
.main_53:
	movl $-2147483648, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.main_55:
.main_117:
	movl 124(%rsp), %r10d
	movl %r10d, 184(%rsp)
	movl $23, 104(%rsp)
	movl $2, %ecx
.main_173:
	movl %ecx, 172(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl %ebx, 84(%rsp)
	movl %r12d, 88(%rsp)
	movl %r13d, 92(%rsp)
	movl %r14d, 96(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 184(%rsp), %ecx
.main_120:
.main_174:
	jmp .main_121
.main_56:
	movl $1, 100(%rsp)
	movl $2, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_57
.main_115:
	movl 120(%rsp), %r10d
	movl %r10d, 184(%rsp)
	movl $127, 104(%rsp)
	movl $3, %ecx
.main_171:
	movl %ecx, 172(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl %ebx, 84(%rsp)
	movl %r12d, 88(%rsp)
	movl %r13d, 92(%rsp)
	movl %r14d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 184(%rsp), %ecx
.main_118:
.main_172:
	jmp .main_120
.main_57:
	movl $1, 100(%rsp)
	movl $3, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_58
.main_113:
	movl 64(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl %eax, 184(%rsp)
	movl $8388607, 104(%rsp)
	movl $4, %ecx
.main_169:
	movl %ecx, 172(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl %ebx, 84(%rsp)
	movl %r12d, 88(%rsp)
	movl %r13d, 92(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 184(%rsp), %ecx
.main_116:
.main_170:
	jmp .main_118
.main_58:
	movl $1, 100(%rsp)
	movl $4, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_59
.main_111:
	movl 124(%rsp), %r10d
	movl %r10d, 184(%rsp)
	movl $8388608, 172(%rsp)
	movl $1, 104(%rsp)
	movl $5, %ecx
.main_167:
	movl %ecx, 176(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl %ebx, 88(%rsp)
	movl %r12d, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 172(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 184(%rsp), %ecx
.main_114:
.main_168:
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 76(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 84(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 88(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 92(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl %r14d, 96(%rsp)
	jmp .main_116
.main_59:
	movl $1, 100(%rsp)
	movl $5, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_60
.main_109:
	movl 168(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl %r14d, 100(%rsp)
	movl $1, 104(%rsp)
	movl $6, %ecx
.main_165:
	movl %ecx, 180(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl %ebx, 88(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
.main_112:
.main_166:
	movl 180(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 180(%rsp)
	jmp .main_114
.main_60:
	movl $1, 100(%rsp)
	movl $6, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_65
.main_61:
	movl $1, %ecx
	cmpl 156(%rsp), %ecx
	jnz .main_64
.main_62:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.main_64:
.main_107:
	movl %r14d, 180(%rsp)
	movl $31, 104(%rsp)
	movl $7, %ecx
.main_163:
	movl %ecx, 76(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl %ebx, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 180(%rsp), %ecx
.main_110:
.main_164:
	movl 76(%rsp), %r10d
	movl %r10d, 180(%rsp)
	movl 84(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 88(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 92(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl %r12d, 92(%rsp)
	jmp .main_112
.main_65:
	movl $1, 100(%rsp)
	movl $7, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_66
.main_105:
	movl 64(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $1, 104(%rsp)
	movl $8, %ecx
.main_161:
	movl %ecx, 76(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl %ebx, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
.main_108:
.main_162:
	jmp .main_110
.main_66:
	movl $1, 100(%rsp)
	movl $8, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_71
.main_67:
	movl $1, %ecx
	cmpl 156(%rsp), %ecx
	jnz .main_68
.main_69:
.main_103:
	movl %r14d, 180(%rsp)
	movl $23, 104(%rsp)
	movl $9, %ecx
.main_159:
	movl %ecx, 76(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl %ebx, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 180(%rsp), %ecx
.main_106:
.main_160:
	jmp .main_108
.main_68:
	movl $-2147483648, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.main_71:
	movl $1, 100(%rsp)
	movl $9, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_72
.main_101:
	movl 64(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $1, 104(%rsp)
	movl $10, %ecx
.main_157:
	movl %ecx, 76(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl %ebx, 92(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
.main_104:
.main_158:
	jmp .main_106
.main_72:
	movl $1, 100(%rsp)
	movl $10, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_76
.main_73:
	movl $1, %ecx
	cmpl 156(%rsp), %ecx
	jnz .main_75
.main_74:
	movl $0, 100(%rsp)
	movl %r13d, %ecx
.main_151:
	movl %ecx, 104(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 84(%rsp)
.main_99:
	movl $11, %ecx
.main_155:
	movl %ecx, 88(%rsp)
	movl %ebx, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 84(%rsp), %ecx
.main_102:
.main_156:
	movl 88(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 88(%rsp)
	jmp .main_104
.main_75:
.main_150:
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 84(%rsp)
	jmp .main_99
.main_76:
	movl $1, 100(%rsp)
	movl $11, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_80
.main_77:
	movl $1, %ecx
	cmpl 156(%rsp), %ecx
	jnz .main_79
.main_78:
	movl 64(%rsp), %ecx
.main_147:
	movl %ecx, 100(%rsp)
.main_97:
	movl %r12d, 84(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl $12, %ecx
.main_153:
	movl %ecx, 88(%rsp)
	movl %ebx, 92(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 84(%rsp), %ecx
.main_100:
.main_154:
	jmp .main_102
.main_79:
.main_146:
	movl %r13d, 100(%rsp)
	jmp .main_97
.main_80:
	movl $1, 100(%rsp)
	movl $12, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_84
.main_81:
	movl $1, %ecx
	cmpl 156(%rsp), %ecx
	jnz .main_83
.main_82:
	movl 120(%rsp), %ecx
.main_143:
	movl %ecx, 100(%rsp)
.main_95:
	movl %eax, 92(%rsp)
	movl $-2147483648, 104(%rsp)
	movl $13, %ecx
.main_149:
	movl %ecx, 96(%rsp)
	movl 92(%rsp), %ecx
.main_98:
.main_152:
	movl 96(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl %r13d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	jmp .main_100
.main_83:
	movl 116(%rsp), %ecx
.main_142:
	movl %ecx, 100(%rsp)
	jmp .main_95
.main_84:
	movl $1, 100(%rsp)
	movl $13, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_89
.main_85:
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 124(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_86
.main_87:
.main_93:
	movl $0, 96(%rsp)
	movl %ebx, 104(%rsp)
	movl $14, %ecx
.main_145:
	movl %ecx, 100(%rsp)
	movl 96(%rsp), %ecx
.main_96:
.main_148:
	movl 100(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl %ebx, 100(%rsp)
	jmp .main_98
.main_86:
	movl %ebx, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.main_89:
	movl $1, 100(%rsp)
	movl $14, 104(%rsp)
	movl 128(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_92
.main_90:
	movl 64(%rsp), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.main_92:
.main_94:
.main_144:
	movl 128(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
	jmp .main_96
.main_13:
	movl $1, 100(%rsp)
	movl $1, %ecx
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	cmpl %ecx, 104(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 104(%rsp)
	movl 104(%rsp), %r10d
	cmpl %r10d, 100(%rsp)
	jnz .main_15
.main_14:
	movl 68(%rsp), %r10d
	movl %r10d, 188(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 192(%rsp)
	movl $0, 196(%rsp)
	movl $1, 200(%rsp)
	movl $2, 204(%rsp)
	jmp .main_131
.main_15:
	movl $1, 100(%rsp)
	movl $2, 104(%rsp)
	movl 144(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_17
.main_16:
	movl 64(%rsp), %r10d
	movl %r10d, 208(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 212(%rsp)
	movl 208(%rsp), %r10d
	movl %r10d, 216(%rsp)
	movl $3, 220(%rsp)
	jmp .main_130
.main_17:
	movl $1, %ecx
	movl $3, 100(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 104(%rsp)
	cmpl 104(%rsp), %ecx
	jnz .main_19
.main_18:
	movl $0, 224(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 228(%rsp)
	movl $4, 232(%rsp)
	jmp .main_129
.main_19:
	movl $1, %ecx
	movl $4, 100(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 104(%rsp)
	cmpl 104(%rsp), %ecx
	jnz .main_21
.main_20:
	movl 64(%rsp), %r15d
	movl 136(%rsp), %edi
	movl 148(%rsp), %r10d
	movl %r10d, 236(%rsp)
	movl $5, 240(%rsp)
	jmp .main_128
.main_21:
	movl $1, 104(%rsp)
	movl $5, %ecx
	movl 144(%rsp), %r10d
	movl %r10d, 100(%rsp)
	cmpl %ecx, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	jnz .main_23
.main_22:
	movl $0, 244(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 248(%rsp)
	movl $6, 252(%rsp)
	jmp .main_127
.main_23:
	movl $1, 100(%rsp)
	movl $6, %ecx
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	cmpl %ecx, 104(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 104(%rsp)
	movl 104(%rsp), %r10d
	cmpl %r10d, 100(%rsp)
	jnz .main_25
.main_24:
	movl 64(%rsp), %r10d
	movl %r10d, 256(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 260(%rsp)
	movl 256(%rsp), %esi
	movl $7, 264(%rsp)
	jmp .main_126
.main_25:
	movl $1, 100(%rsp)
	movl $7, 104(%rsp)
	movl 144(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_27
.main_26:
	movl 124(%rsp), %r10d
	movl %r10d, 268(%rsp)
	movl 148(%rsp), %r10d
	movl %r10d, 272(%rsp)
	movl $8, %edx
	jmp .main_125
.main_27:
	movl $1, %ecx
	movl $8, 104(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 104(%rsp), %r10d
	cmpl %r10d, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	cmpl 100(%rsp), %ecx
	jnz .main_29
.main_28:
	movl $0, 276(%rsp)
	movl 64(%rsp), %r8d
	movl $9, %r9d
	jmp .main_124
.main_29:
	movl $1, %ecx
	movl $9, 104(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 104(%rsp), %r10d
	cmpl %r10d, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	cmpl 100(%rsp), %ecx
	jnz .main_31
.main_30:
	movl 64(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $0, %ecx
.main_139:
	movl %ecx, 104(%rsp)
	movl 100(%rsp), %ecx
.main_33:
.main_35:
.main_37:
.main_39:
.main_41:
.main_43:
.main_45:
.main_47:
.main_49:
.main_140:
	movl 104(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl %ecx, 168(%rsp)
	jmp .main_50
.main_31:
.main_138:
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl %ebp, %ecx
	jmp .main_33
.main_3:
	movl $1, 100(%rsp)
	movl $1, 104(%rsp)
	movl 108(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .main_5
.main_4:
	movl 112(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $31, 104(%rsp)
	movl $2, %ecx
	jmp .main_132
.main_5:
	movl $1, %ecx
	movl $2, 156(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 160(%rsp)
	movl 156(%rsp), %r10d
	cmpl %r10d, 160(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 160(%rsp)
	cmpl 160(%rsp), %ecx
	jnz .main_7
.main_6:
	movl $0, %ecx
	movl 120(%rsp), %r10d
	movl %r10d, 160(%rsp)
	cmpl %ecx, 160(%rsp)
	setne %r11b
	movzbl %r11b, %r11d
	movl %r11d, 160(%rsp)
	movl $0, %ecx
.main_135:
.main_9:
.main_11:
.main_136:
	movl 160(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl %ecx, 160(%rsp)
	jmp .main_12
.main_7:
.main_134:
	movl 152(%rsp), %r10d
	movl %r10d, 160(%rsp)
	movl 108(%rsp), %ecx
	jmp .main_9
.main_122:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.main_132:
	movl %ecx, 108(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 80(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_124:
	movl %r9d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %r8d, 72(%rsp)
	movl 276(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_125:
	movl %edx, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 272(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 268(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_126:
	movl 264(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %esi, 72(%rsp)
	movl 260(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_127:
	movl 252(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 248(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 244(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_128:
	movl %r15d, 132(%rsp)
	movl 240(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 236(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl %edi, 68(%rsp)
	jmp .main_1
.main_129:
	movl 232(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 228(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 224(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_130:
	movl 220(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 208(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 212(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.main_131:
	movl 192(%rsp), %r10d
	movl %r10d, 136(%rsp)
	movl 188(%rsp), %r10d
	movl %r10d, 140(%rsp)
	movl 204(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 196(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .main_1
.ident	"15-411 L4 reference compiler"
