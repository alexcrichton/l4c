.file	"../tests0/exception03.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_5:
	movl %r9d, %ecx
.main_1:
	movl $0, %r9d
	cmpl %ecx, %r9d
	jl .ternary_true3
	movl $0, %r8d
	movl %ecx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %r9d
	movl %ecx, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_2:
	movl %ecx, %r9d
	addl $1, %r9d
.main_4:
	movl %r9d, %ecx
	jmp .main_1
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
