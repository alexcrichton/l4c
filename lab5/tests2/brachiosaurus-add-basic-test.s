.file	"../tests2/brachiosaurus-add-basic-test.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %eax
	movl %r9d, %edi
	addl %eax, %edi
	movl %r9d, %r8d
	addl %eax, %r8d
	movl %r8d, %esi
	addl %edi, %esi
	movl %r9d, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	movl %r8d, %edx
	addl %esi, %edx
	movl %r9d, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	movl %r8d, %ecx
	addl %edx, %ecx
	movl %r9d, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	addl %edx, %r8d
	addl %ecx, %r8d
	addl %eax, %r9d
	addl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
