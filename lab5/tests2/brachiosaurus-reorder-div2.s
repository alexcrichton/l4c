.file	"../tests2/brachiosaurus-reorder-div2.l3"
.globl _c0_main
_c0_loupe:
	addq $-8, %rsp
.loupe_0:
.loupe_1:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .loupe_3
.loupe_2:
	jmp .loupe_1
.loupe_3:
	movl $5, %eax
	addq $8, %rsp
	ret
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
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_div
	movl %eax, %r8d
	movq %r8, %rbx
	callq _c0_loupe
	movq %rbx, %r8
	movl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
