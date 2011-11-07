.file	"../tests2/utahraptor-return05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
	movl $5, %r8d
	movl $0, %ecx
	cmpl %ecx, %r9d
	jl .ternary_true1
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl $1, %ecx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .main_2
.main_1:
	movl $5, %ecx
	cmpl %r9d, %ecx
	jl .ternary_true3
	movl %r8d, %r9d
	addl $1, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %r8d, %r9d
	subl $1, %r9d
.ternary_end4:
.main_5:
.main_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $10, %r9d
	addl $1, %r9d
.main_4:
	movl %r8d, %r9d
	jmp .main_3
.ident	"15-411 L4 reference compiler"
