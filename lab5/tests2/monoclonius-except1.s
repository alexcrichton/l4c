.file	"../tests2/monoclonius-except1.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r9
	movq $0, %r8
	movl $4, %ecx
	addl $7, %ecx
	addl $9, %ecx
	movl $3, %edx
	imull %ecx, %edx
	movl $3, %ecx
	imull $19, %ecx
	movl %edx, %eax
	subl %ecx, %eax
	movl $3, %ecx
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_2
.main_1:
	movl (%r9), %r9d
.main_5:
.main_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
	movq %r8, %r9
	movl (%r9), %r9d
.main_4:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
