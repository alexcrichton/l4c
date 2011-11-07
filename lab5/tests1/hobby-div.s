.file	"../tests1/hobby-div.l3"
.globl _c0_main
_c0_div:
	addq $-8, %rsp
	movl %edi, %eax
.div_0:
	cltd
	idivl %esi
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r8d
	movl $10, %r9d
.main_5:
.main_1:
	movl $1, %edx
	movl $0, %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	movl %r9d, %edi
	movl %r9d, %esi
	subl $3, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_div
	movq %r12, %r8
	movq %rbx, %r9
	addl %eax, %r8d
	subl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
