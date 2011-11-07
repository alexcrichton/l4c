.file	"../tests0/return10.l3"
.globl _c0_main
_c0_fac:
	addq $-8, %rsp
.fac_0:
	movl $1, %r8d
.fac_5:
	movl %r8d, %edx
	movl %edi, %ecx
.fac_1:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .fac_3
.fac_2:
	movl %edx, %r8d
	imull %ecx, %r8d
	movl %ecx, %r9d
	subl $1, %r9d
.fac_4:
	movl %r8d, %edx
	movl %r9d, %ecx
	jmp .fac_1
.fac_3:
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %edi
	callq _c0_fac
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
