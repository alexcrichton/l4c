.file	"../tests2/seismosaurus-return09.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl $0, %edx
	subl $100, %edx
	movl $1234, %ecx
	movl $10, %r8d
	cmpl %r9d, %r8d
	jl .ternary_true1
	movl $0, %r9d
	movl %edx, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_7
.main_1:
	movl $1500, %r8d
	movl %ecx, %r9d
	addl %edx, %r9d
	cmpl %r9d, %r8d
	jl .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r8d
.ternary_end4:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_4
.main_2:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.main_4:
.main_5:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_7:
.main_8:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
