.file	"../tests1/hobby-ackermann.l3"
.globl _c0_main
_c0_ackermann:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.ackermann_0:
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .ackermann_2
.ackermann_1:
	movl %esi, %eax
	addl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ackermann_2:
	movl $1, %r8d
	movl $0, %ecx
	movl %esi, %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r8d
	jnz .ackermann_4
.ackermann_3:
	movl %r9d, %edi
	subl $1, %edi
	movl $1, %esi
	callq _c0_ackermann
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ackermann_4:
	movl %r9d, %edi
	subl $1, %esi
	movq %r9, %rbx
	callq _c0_ackermann
	movq %rbx, %r9
	movl %r9d, %edi
	subl $1, %edi
	movl %eax, %esi
	callq _c0_ackermann
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $3, %edi
	movl $2, %esi
	callq _c0_ackermann
	movl %eax, %r9d
	movl $3, %edi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_ackermann
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
