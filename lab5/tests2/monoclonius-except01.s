.file	"../tests2/monoclonius-except01.l3"
.globl _c0_main
_c0_recura:
	addq $-8, %rsp
.recura_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .recura_2
.recura_1:
	callq _c0_recurb
	addq $8, %rsp
	ret
.recura_2:
	subl $1, %edi
	callq _c0_recura
	addq $8, %rsp
	ret
_c0_recurb:
	addq $-8, %rsp
.recurb_0:
	movl $1, %edx
	movl $100, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .recurb_2
.recurb_1:
	callq _c0_recura
	addq $8, %rsp
	ret
.recurb_2:
	addl $1, %edi
	callq _c0_recurb
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %edi
	callq _c0_recura
	movl %eax, %r9d
	movl $6, %edi
	movq %r9, %rbx
	callq _c0_recurb
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
