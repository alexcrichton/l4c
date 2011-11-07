.file	"../tests2/stegosaurus-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $4, %r8d
	movl $6, %esi
	movl %r8d, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl %esi, %eax
	cltd
	idivl %r9d
	movl %eax, %edi
	movl %esi, %edx
	subl %ecx, %edx
	addl %edx, %r8d
	movl %r8d, %eax
	addl %esi, %eax
	movl %edi, %edx
	subl %r9d, %edx
	movl %edx, %r9d
	subl %ecx, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
