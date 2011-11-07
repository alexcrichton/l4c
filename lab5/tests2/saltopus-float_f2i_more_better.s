.file	"../tests2/saltopus-float_f2i_more_better.l3"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $1, %edi
	callq tofloat
	movl %eax, %r9d
	movl $10, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq fdiv
	movl %eax, %r9d
	movl $650000, %r8d
	movl $0, %ecx
	subl %r8d, %ecx
.main_9:
	movl %ecx, %edx
.main_1:
	movl $1, %esi
	movl %edx, %ecx
	cmpl %r8d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_7
.main_2:
	movl %edx, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %ecx, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_float_f2i
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	cmpl %edx, %eax
	jnz .ternary_true3
	movl %ecx, %edi
	movl %r9d, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq fsub
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_float_f2i
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movl $0, %edi
	cmpl %edx, %edi
	setl %dil
	movzbl %dil, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq booltoint
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %edx, %edi
	subl %eax, %edi
	cmpl %edi, %esi
	setne %sil
	movzbl %sil, %esi
	jmp .ternary_end4
.ternary_true3:
	movl $1, %esi
.ternary_end4:
	cmpl $0, %esi
	jnz .ternary_true1
	movl %ecx, %edi
	movl %r9d, %esi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq fadd
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_float_f2i
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $0, %edi
	movl %edx, %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	movl %esi, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq booltoint
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %edx, %esi
	addl %eax, %esi
	cmpl %esi, %ecx
	setne %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %esi
	cmpl %ecx, %esi
	jnz .main_5
.main_3:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_5:
.main_6:
	movl %edx, %ecx
	addl $1, %ecx
.main_8:
	movl %ecx, %edx
	jmp .main_1
.main_7:
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_float_f2i:
	addq $-280, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.float_f2i_0:
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
	movl $0, 128(%rsp)
	movl $0, 132(%rsp)
	movl $0, 136(%rsp)
	movl $0, 140(%rsp)
	movl $0, 144(%rsp)
.float_f2i_133:
	movl 144(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 128(%rsp), %r10d
	movl %r10d, 160(%rsp)
	movl 124(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 120(%rsp), %r10d
	movl %r10d, 168(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 140(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 136(%rsp)
	movl 92(%rsp), %r10d
	movl %r10d, 132(%rsp)
	movl %ecx, 128(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 80(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 68(%rsp)
.float_f2i_1:
	movl $1, 64(%rsp)
	movl $1, %ecx
	cmpl %ecx, 64(%rsp)
	jnz .float_f2i_122
.float_f2i_2:
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
	jnz .float_f2i_3
.float_f2i_10:
.float_f2i_137:
	movl 172(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 180(%rsp)
.float_f2i_12:
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 164(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_13
.float_f2i_48:
.float_f2i_141:
	movl 164(%rsp), %r10d
	movl %r10d, 184(%rsp)
	movl 128(%rsp), %r10d
	movl %r10d, 188(%rsp)
.float_f2i_50:
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_51
.float_f2i_119:
	movl %edi, 72(%rsp)
	movl $2139095040, 128(%rsp)
	movl $1, %ecx
.float_f2i_175:
	movl %ecx, 192(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 128(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 72(%rsp), %ecx
.float_f2i_121:
.float_f2i_123:
	movl 192(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 196(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 112(%rsp)
	movl 76(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 84(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 88(%rsp), %r10d
	movl %r10d, 140(%rsp)
	movl 92(%rsp), %r10d
	movl %r10d, 136(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 132(%rsp)
	movl 188(%rsp), %r10d
	movl %r10d, 128(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 80(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl %ecx, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_51:
	movl $1, 100(%rsp)
	movl $1, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_56
.float_f2i_52:
	movl $1, 100(%rsp)
	movl $2139095040, 104(%rsp)
	movl 124(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_55
.float_f2i_53:
	movl $-2147483648, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.float_f2i_55:
.float_f2i_117:
	movl 124(%rsp), %r10d
	movl %r10d, 204(%rsp)
	movl $23, 104(%rsp)
	movl $2, %ecx
.float_f2i_173:
	movl %ecx, 192(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 204(%rsp), %ecx
.float_f2i_120:
.float_f2i_174:
	jmp .float_f2i_121
.float_f2i_56:
	movl $1, 100(%rsp)
	movl $2, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_57
.float_f2i_115:
	movl 120(%rsp), %r10d
	movl %r10d, 204(%rsp)
	movl $127, 104(%rsp)
	movl $3, %ecx
.float_f2i_171:
	movl %ecx, 192(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 204(%rsp), %ecx
.float_f2i_118:
.float_f2i_172:
	jmp .float_f2i_120
.float_f2i_57:
	movl $1, 100(%rsp)
	movl $3, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_58
.float_f2i_113:
	movl 64(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl %edi, 204(%rsp)
	movl $8388607, 104(%rsp)
	movl $4, %ecx
.float_f2i_169:
	movl %ecx, 192(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 204(%rsp), %ecx
.float_f2i_116:
.float_f2i_170:
	jmp .float_f2i_118
.float_f2i_58:
	movl $1, 100(%rsp)
	movl $4, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_59
.float_f2i_111:
	movl 124(%rsp), %r10d
	movl %r10d, 204(%rsp)
	movl $8388608, 192(%rsp)
	movl $1, 104(%rsp)
	movl $5, %ecx
.float_f2i_167:
	movl %ecx, 196(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 204(%rsp), %ecx
.float_f2i_114:
.float_f2i_168:
	movl 196(%rsp), %r10d
	movl %r10d, 192(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 76(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 84(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 88(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 92(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 96(%rsp)
	jmp .float_f2i_116
.float_f2i_59:
	movl $1, 100(%rsp)
	movl $5, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_60
.float_f2i_109:
	movl 188(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $1, 104(%rsp)
	movl $6, %ecx
.float_f2i_165:
	movl %ecx, 200(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
.float_f2i_112:
.float_f2i_166:
	movl 200(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 200(%rsp)
	jmp .float_f2i_114
.float_f2i_60:
	movl $1, 100(%rsp)
	movl $6, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_65
.float_f2i_61:
	movl $1, %ecx
	cmpl 176(%rsp), %ecx
	jnz .float_f2i_64
.float_f2i_62:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.float_f2i_64:
.float_f2i_107:
	movl 132(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl $31, 104(%rsp)
	movl $7, %ecx
.float_f2i_163:
	movl %ecx, 76(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 200(%rsp), %ecx
.float_f2i_110:
.float_f2i_164:
	movl 76(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 84(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 88(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 92(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 92(%rsp)
	jmp .float_f2i_112
.float_f2i_65:
	movl $1, 100(%rsp)
	movl $7, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_66
.float_f2i_105:
	movl 64(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $1, 104(%rsp)
	movl $8, %ecx
.float_f2i_161:
	movl %ecx, 76(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
.float_f2i_108:
.float_f2i_162:
	jmp .float_f2i_110
.float_f2i_66:
	movl $1, 100(%rsp)
	movl $8, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_71
.float_f2i_67:
	movl $1, %ecx
	cmpl 176(%rsp), %ecx
	jnz .float_f2i_68
.float_f2i_69:
.float_f2i_103:
	movl 132(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl $23, 104(%rsp)
	movl $9, %ecx
.float_f2i_159:
	movl %ecx, 76(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 200(%rsp), %ecx
.float_f2i_106:
.float_f2i_160:
	jmp .float_f2i_108
.float_f2i_68:
	movl $-2147483648, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.float_f2i_71:
	movl $1, 100(%rsp)
	movl $9, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_72
.float_f2i_101:
	movl 64(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl $1, 104(%rsp)
	movl $10, %ecx
.float_f2i_157:
	movl %ecx, 76(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
.float_f2i_104:
.float_f2i_158:
	jmp .float_f2i_106
.float_f2i_72:
	movl $1, 100(%rsp)
	movl $10, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_76
.float_f2i_73:
	movl $1, %ecx
	cmpl 176(%rsp), %ecx
	jnz .float_f2i_75
.float_f2i_74:
	movl $0, 100(%rsp)
	movl 136(%rsp), %ecx
.float_f2i_151:
	movl %ecx, 104(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 84(%rsp)
.float_f2i_99:
	movl $11, %ecx
.float_f2i_155:
	movl %ecx, 88(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 84(%rsp), %ecx
.float_f2i_102:
.float_f2i_156:
	movl 88(%rsp), %r10d
	movl %r10d, 76(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 88(%rsp)
	jmp .float_f2i_104
.float_f2i_75:
.float_f2i_150:
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %r10d
	movl %r10d, 84(%rsp)
	jmp .float_f2i_99
.float_f2i_76:
	movl $1, 100(%rsp)
	movl $11, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_80
.float_f2i_77:
	movl $1, %ecx
	cmpl 176(%rsp), %ecx
	jnz .float_f2i_79
.float_f2i_78:
	movl 64(%rsp), %ecx
.float_f2i_147:
	movl %ecx, 100(%rsp)
.float_f2i_97:
	movl 140(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl $12, %ecx
.float_f2i_153:
	movl %ecx, 88(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 84(%rsp), %ecx
.float_f2i_100:
.float_f2i_154:
	jmp .float_f2i_102
.float_f2i_79:
.float_f2i_146:
	movl 136(%rsp), %r10d
	movl %r10d, 100(%rsp)
	jmp .float_f2i_97
.float_f2i_80:
	movl $1, 100(%rsp)
	movl $12, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_84
.float_f2i_81:
	movl $1, %ecx
	cmpl 176(%rsp), %ecx
	jnz .float_f2i_83
.float_f2i_82:
	movl 120(%rsp), %ecx
.float_f2i_143:
	movl %ecx, 100(%rsp)
.float_f2i_95:
	movl %edi, 92(%rsp)
	movl $-2147483648, 104(%rsp)
	movl $13, %ecx
.float_f2i_149:
	movl %ecx, 96(%rsp)
	movl 92(%rsp), %ecx
.float_f2i_98:
.float_f2i_152:
	movl 96(%rsp), %r10d
	movl %r10d, 88(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 92(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 100(%rsp)
	jmp .float_f2i_100
.float_f2i_83:
	movl 116(%rsp), %ecx
.float_f2i_142:
	movl %ecx, 100(%rsp)
	jmp .float_f2i_95
.float_f2i_84:
	movl $1, 100(%rsp)
	movl $13, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_89
.float_f2i_85:
	movl $1, 100(%rsp)
	movl $0, 104(%rsp)
	movl 124(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_86
.float_f2i_87:
.float_f2i_93:
	movl $0, 96(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl $14, %ecx
.float_f2i_145:
	movl %ecx, 100(%rsp)
	movl 96(%rsp), %ecx
.float_f2i_96:
.float_f2i_148:
	movl 100(%rsp), %r10d
	movl %r10d, 96(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 100(%rsp)
	jmp .float_f2i_98
.float_f2i_86:
	movl 144(%rsp), %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.float_f2i_89:
	movl $1, 100(%rsp)
	movl $14, 104(%rsp)
	movl 148(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_92
.float_f2i_90:
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
.float_f2i_92:
.float_f2i_94:
.float_f2i_144:
	movl 148(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 68(%rsp), %ecx
	jmp .float_f2i_96
.float_f2i_13:
	movl $1, 100(%rsp)
	movl $1, 104(%rsp)
	movl 164(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_15
.float_f2i_14:
	movl 68(%rsp), %r10d
	movl %r10d, 208(%rsp)
	movl 72(%rsp), %r10d
	movl %r10d, 212(%rsp)
	movl $0, 216(%rsp)
	movl $1, 220(%rsp)
	movl $2, 224(%rsp)
	jmp .float_f2i_131
.float_f2i_15:
	movl $1, 100(%rsp)
	movl $2, 104(%rsp)
	movl 164(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_17
.float_f2i_16:
	movl 64(%rsp), %r10d
	movl %r10d, 228(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 232(%rsp)
	movl 228(%rsp), %r10d
	movl %r10d, 236(%rsp)
	movl $3, 240(%rsp)
	jmp .float_f2i_130
.float_f2i_17:
	movl $1, 104(%rsp)
	movl $3, %ecx
	movl 164(%rsp), %r10d
	movl %r10d, 100(%rsp)
	cmpl %ecx, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	jnz .float_f2i_19
.float_f2i_18:
	movl $0, 244(%rsp)
	movl 64(%rsp), %r14d
	movl $4, %r13d
	jmp .float_f2i_129
.float_f2i_19:
	movl $1, 100(%rsp)
	movl $4, 104(%rsp)
	movl 164(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_21
.float_f2i_20:
	movl 64(%rsp), %ebx
	movl 156(%rsp), %eax
	movl 168(%rsp), %r10d
	movl %r10d, 248(%rsp)
	movl $5, 252(%rsp)
	jmp .float_f2i_128
.float_f2i_21:
	movl $1, %ecx
	movl $5, 104(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 104(%rsp), %r10d
	cmpl %r10d, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	cmpl 100(%rsp), %ecx
	jnz .float_f2i_23
.float_f2i_22:
	movl $0, 256(%rsp)
	movl 64(%rsp), %r10d
	movl %r10d, 260(%rsp)
	movl $6, 264(%rsp)
	jmp .float_f2i_127
.float_f2i_23:
	movl $1, %ecx
	movl $6, 100(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 104(%rsp)
	cmpl 104(%rsp), %ecx
	jnz .float_f2i_25
.float_f2i_24:
	movl 64(%rsp), %ebp
	movl 152(%rsp), %r12d
	movl %ebp, %esi
	movl $7, 268(%rsp)
	jmp .float_f2i_126
.float_f2i_25:
	movl $1, 104(%rsp)
	movl $7, %ecx
	movl 164(%rsp), %r10d
	movl %r10d, 100(%rsp)
	cmpl %ecx, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	jnz .float_f2i_27
.float_f2i_26:
	movl 124(%rsp), %r10d
	movl %r10d, 272(%rsp)
	movl 168(%rsp), %r15d
	movl $8, %edx
	jmp .float_f2i_125
.float_f2i_27:
	movl $1, 104(%rsp)
	movl $8, %ecx
	movl 164(%rsp), %r10d
	movl %r10d, 100(%rsp)
	cmpl %ecx, 100(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 100(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	jnz .float_f2i_29
.float_f2i_28:
	movl $0, 276(%rsp)
	movl 64(%rsp), %r8d
	movl $9, %r9d
	jmp .float_f2i_124
.float_f2i_29:
	movl $1, 100(%rsp)
	movl $9, 104(%rsp)
	movl 164(%rsp), %ecx
	cmpl 104(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 100(%rsp)
	jnz .float_f2i_31
.float_f2i_30:
	movl 64(%rsp), %ecx
	movl $0, 104(%rsp)
.float_f2i_139:
.float_f2i_33:
.float_f2i_35:
.float_f2i_37:
.float_f2i_39:
.float_f2i_41:
.float_f2i_43:
.float_f2i_45:
.float_f2i_47:
.float_f2i_49:
.float_f2i_140:
	movl 104(%rsp), %r10d
	movl %r10d, 184(%rsp)
	movl %ecx, 188(%rsp)
	jmp .float_f2i_50
.float_f2i_31:
.float_f2i_138:
	movl 164(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 128(%rsp), %ecx
	jmp .float_f2i_33
.float_f2i_3:
	movl $1, %ecx
	movl $1, 100(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 100(%rsp), %r10d
	cmpl %r10d, 104(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 104(%rsp)
	cmpl 104(%rsp), %ecx
	jnz .float_f2i_5
.float_f2i_4:
	movl 112(%rsp), %ecx
	movl $31, 104(%rsp)
	movl $2, 100(%rsp)
	jmp .float_f2i_132
.float_f2i_5:
	movl $1, 180(%rsp)
	movl $2, 176(%rsp)
	movl 108(%rsp), %ecx
	cmpl 176(%rsp), %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, 180(%rsp)
	jnz .float_f2i_7
.float_f2i_6:
	movl $0, 180(%rsp)
	movl 120(%rsp), %ecx
	cmpl 180(%rsp), %ecx
	setne %cl
	movzbl %cl, %ecx
	movl $0, 180(%rsp)
.float_f2i_135:
	movl %ecx, 176(%rsp)
	movl 180(%rsp), %ecx
.float_f2i_9:
.float_f2i_11:
.float_f2i_136:
	movl %ecx, 180(%rsp)
	jmp .float_f2i_12
.float_f2i_7:
.float_f2i_134:
	movl 172(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 108(%rsp), %ecx
	jmp .float_f2i_9
.float_f2i_122:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $280, %rsp
	ret
.float_f2i_132:
	movl 100(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 80(%rsp)
	movl %ecx, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_124:
	movl %r9d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %r8d, 72(%rsp)
	movl 276(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_125:
	movl %edx, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %r15d, 72(%rsp)
	movl 272(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_126:
	movl 268(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %esi, 72(%rsp)
	movl %r12d, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_127:
	movl 264(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 260(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 256(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_128:
	movl %ebx, 152(%rsp)
	movl 252(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 248(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl %eax, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_129:
	movl %r13d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %r14d, 72(%rsp)
	movl 244(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_130:
	movl 240(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 228(%rsp), %r10d
	movl %r10d, 168(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 236(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 232(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .float_f2i_1
.float_f2i_131:
	movl 212(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 208(%rsp), %r10d
	movl %r10d, 160(%rsp)
	movl 224(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 220(%rsp), %r10d
	movl %r10d, 72(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 68(%rsp)
	jmp .float_f2i_1
.ident	"15-411 L4 reference compiler"
