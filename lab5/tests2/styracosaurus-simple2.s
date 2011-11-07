.file	"../tests2/styracosaurus-simple2.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %ecx
	movl $1, %r9d
	movl %r9d, %r8d
	sall %cl, %r8d
	movl %r8d, %edx
	orl %r9d, %edx
	movl $0, %ecx
	cmpl %ecx, %edx
	jnz .ternary_true1
	movl %r8d, %ecx
	andl %r9d, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %edx
	sarl $2, %edx
	movl $0, %ecx
	cmpl %ecx, %edx
	jnz .ternary_true3
	jmp .ternary_end4
.ternary_true3:
	movl %r8d, %r9d
.ternary_end4:
	movl %r9d, %ecx
.ternary_end2:
	movl %ecx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
