.file	"../tests0/order-of-eval.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_the_void:
	addq $-8, %rsp
.the_void_0:
.the_void_1:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .the_void_3
.the_void_2:
	jmp .the_void_1
.the_void_3:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movq %r9, %rbx
	callq _c0_the_void
	movq %rbx, %r9
	movl $7, %edi
	addl $4, %edi
	movl %r9d, %esi
	movl $6, %edx
	movl %eax, %ecx
	movl $15, %r8d
	callq _c0_f
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
