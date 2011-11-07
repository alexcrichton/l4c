.file	"../tests2/apatosaurus-null-return.l4"
.globl _c0_main
_c0_nullret:
	addq $-8, %rsp
.nullret_0:
	movq $0, %rax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_nullret
	movq %rax, %r9
	movq %r9, %rbx
	callq _c0_nullret
	movq %rbx, %r9
	cmpq %rax, %r9
	jz .ternary_true1
	movl $0, %r9d
	subl $1, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $50, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
