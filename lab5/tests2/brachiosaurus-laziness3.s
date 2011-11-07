.file	"../tests2/brachiosaurus-laziness3.l3"
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
	jz .ternary_true3
	callq _c0_div
	movl $42, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $1, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
