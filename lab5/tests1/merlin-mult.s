.file	"../tests1/merlin-mult.l3"
.globl _c0_main
_c0_mult:
	addq $-8, %rsp
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %esi
.mult_0:
	movl $1, %ecx
	movl $0, %edi
	movl %esi, %edx
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .mult_2
.mult_1:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.mult_2:
	movl %r9d, %edi
	addl %r9d, %r8d
	movl %esi, %edx
	subl $1, %edx
	movl %r8d, %esi
	callq _c0_mult
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %r9d
	movl $99999, %ecx
	movl %r9d, %edi
	movl $0, %esi
	movl %ecx, %edx
	callq _c0_mult
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
