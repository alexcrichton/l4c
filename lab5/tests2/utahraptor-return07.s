.file	"../tests2/utahraptor-return07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
	movl $10, %r8d
	cmpl %r8d, %r9d
	jl .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $1, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_3
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $10, %r8d
	cmpl %r8d, %r9d
	jz .ternary_true3
	movl $0, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $1, %r9d
	movl %r9d, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r8d
.ternary_end4:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_7
.main_5:
	movl $2, %eax
	addq $8, %rsp
	ret
.main_7:
.main_8:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
