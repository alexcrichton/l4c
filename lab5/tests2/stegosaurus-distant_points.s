.file	"../tests2/stegosaurus-distant_points.l4"
.globl _c0_main
_c0_paint:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %esi, %r8d
	movl %ecx, %eax
.paint_0:
	movl %r8d, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %r9, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rdi
	movl %edx, %ecx
	imull $4, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movl (%rcx), %ecx
	movl $1, %edi
	movl $0, %esi
	cmpl %esi, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .paint_2
.paint_1:
	imull $8, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movq (%r9), %rcx
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl %eax, (%r9)
	movl %eax, %r9d
	addl $1, %r9d
.paint_5:
.paint_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.paint_2:
.paint_4:
	movl %eax, %r9d
	jmp .paint_3
_c0_main:
	addq $-104, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $1, %ecx
	sall $12, %ecx
	movl %ecx, 92(%rsp)
	addl $1, 92(%rsp)
	movl $3048952, %r12d
	movslq 92(%rsp), %rdi
	movq $8, %rsi
	movq %r8, %r15
	movq %r9, %r14
	callq calloc
	movq %r15, %r8
	movq %r14, %r9
	movq %rax, %rbp
	movl $0, %edx
	movl 92(%rsp), %r14d
	subl $1, %r14d
	movl $0, %ecx
.main_30:
	movl %ecx, %r15d
.main_1:
	movl $1, %esi
	movl %r15d, %ecx
	cmpl 92(%rsp), %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r15d, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rbp, %rcx
	addq %rsi, %rcx
	movslq 92(%rsp), %rdi
	movq $4, %rsi
	movq %rdx, 52(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq calloc
	movq 52(%rsp), %rdx
	movq 60(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movq %rax, (%rcx)
	movl %r15d, %ecx
	addl $1, %ecx
.main_29:
	movl %ecx, %r15d
	jmp .main_1
.main_3:
	movq %rbp, %rdi
	movl $0, %esi
	movl $0, %eax
	movl %edx, %ecx
	movl %eax, %edx
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_paint
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movl %eax, %ecx
	movq %rbp, %rdi
	movl 92(%rsp), %esi
	subl $1, %esi
	movl 92(%rsp), %edx
	subl $1, %edx
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_paint
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movl %eax, %ecx
	movq %rbp, %rdi
	movl $0, %esi
	movl 92(%rsp), %edx
	subl $1, %edx
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_paint
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movl %eax, %ecx
	movq %rbp, %rdi
	movl 92(%rsp), %esi
	subl $1, %esi
	movl $0, %edx
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_paint
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movl %eax, %ecx
.main_32:
	movl %ecx, %esi
.main_4:
	movl $1, %edx
	movl $2, %ecx
	cmpl %r14d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_18
.main_5:
	movl $0, %ecx
.main_34:
	movl %ecx, %r15d
.main_6:
	movl $1, %edx
	movl %r15d, %ecx
	addl %r14d, %ecx
	cmpl 92(%rsp), %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_11
.main_7:
	movl $0, %r8d
.main_36:
	movl %r13d, 96(%rsp)
	movl %ebx, %eax
	movl 100(%rsp), %edi
.main_8:
	movl $1, %edx
	movl %r8d, %ecx
	addl %r14d, %ecx
	cmpl 92(%rsp), %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_10
.main_9:
	movl $2, %ecx
	movl %r14d, %eax
	cltd
	idivl %ecx
	movl %eax, %ebx
	movl $2, %ecx
	movl %r14d, %eax
	cltd
	idivl %ecx
	movl %eax, %r13d
	movq %rbp, %rdi
	movl %r15d, %eax
	addl %ebx, %eax
	movl %r8d, %edx
	addl %r13d, %edx
	movl %esi, %ecx
	movl %eax, %esi
	movq %r8, 84(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_paint
	movq 84(%rsp), %r8
	movq 76(%rsp), %r9
	movl %eax, %ecx
	addl %r14d, %r8d
.main_35:
	movl %eax, 96(%rsp)
	movl %ebx, %eax
	movl %r13d, %edi
	movl %ecx, %esi
	jmp .main_8
.main_10:
	movl %r15d, %ecx
	addl %r14d, %ecx
.main_33:
	movl 96(%rsp), %r13d
	movl %eax, %ebx
	movl %edi, 100(%rsp)
	movl %ecx, %r15d
	jmp .main_6
.main_11:
	movl $2, %ecx
	movl %r14d, %eax
	cltd
	idivl %ecx
	movl %eax, %r14d
	movl $0, %ecx
.main_38:
	movl %esi, %edi
	movl %ecx, %r15d
.main_12:
	movl $1, %ecx
	movl %r15d, %edx
	cmpl 92(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_17
.main_13:
	movl $0, %ecx
.main_40:
	movl %r9d, %esi
	movl %ecx, 96(%rsp)
.main_14:
	movl $1, %r9d
	movl 96(%rsp), %ecx
	cmpl 92(%rsp), %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r9d
	jnz .main_16
.main_15:
	movq %rbp, %rsi
	movl %r15d, %edx
	movl 96(%rsp), %ecx
	movl %edi, %r9d
	movq %rsi, %rdi
	movl %edx, %esi
	movl %ecx, %edx
	movl %r9d, %ecx
	movq %r8, 68(%rsp)
	callq _c0_paint
	movq 68(%rsp), %r8
	movl %eax, %edx
	movl 96(%rsp), %ecx
	addl %r14d, %ecx
.main_39:
	movl %eax, %esi
	movl %edx, %edi
	movl %ecx, 96(%rsp)
	jmp .main_14
.main_16:
	movl %r15d, %ecx
	addl %r14d, %ecx
.main_37:
	movl %esi, %r9d
	movl %ecx, %r15d
	jmp .main_12
.main_17:
.main_31:
	movl %edi, %esi
	jmp .main_4
.main_18:
	movl $0, %r9d
.main_42:
	movl %r9d, %esi
.main_19:
	movl $1, %r8d
	movl %esi, %r9d
	cmpl 92(%rsp), %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_28
.main_20:
	movl $0, %r9d
.main_44:
	movl %r9d, %ecx
.main_21:
	movl $1, %r9d
	movl %ecx, %r8d
	cmpl 92(%rsp), %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .main_27
.main_22:
	movl %esi, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %rdx
	movl %ecx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %edi
	movl $1, %r8d
	movl %edi, %r9d
	cmpl %r12d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_25
.main_23:
	movl %esi, %r9d
	imull 92(%rsp), %r9d
	movl %r9d, %eax
	addl %ecx, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $104, %rsp
	ret
.main_25:
.main_26:
	movl %ecx, %r9d
	addl $1, %r9d
.main_43:
	movl %r9d, %ecx
	jmp .main_21
.main_27:
	movl %esi, %r9d
	addl $1, %r9d
.main_41:
	movl %r9d, %esi
	jmp .main_19
.main_28:
	movl $0, %eax
	subl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $104, %rsp
	ret
.ident	"15-411 L4 reference compiler"
