.file	"../tests2/dilophosaurus-namespace.l3"
.globl _c0_main
_c0_x:
	addq $-8, %rsp
	movl %edi, %eax
.x_0:
	cltd
	idivl %esi
	addq $8, %rsp
	ret
_c0_i:
	addq $-8, %rsp
.i_0:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $100, %r9d
.main_5:
.main_1:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_i
	movq %rbx, %r9
	movl $1, %ecx
	movl $5, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	sarl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl %r9d, %edi
	callq _c0_i
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
