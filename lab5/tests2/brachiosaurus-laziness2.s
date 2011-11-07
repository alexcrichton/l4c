.file	"../tests2/brachiosaurus-laziness2.l3"
.globl _c0_main
_c0_div:
	addq $-8, %rsp
.div_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %r9d
	movl $42, %r8d
	cmpl %r8d, %r9d
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	callq _c0_div
	movl %eax, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
