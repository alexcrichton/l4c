.file	"../tests2/brachiosaurus-the-wizards-apprentice.l3"
.globl _c0_main
_c0_divide_stuff:
	addq $-8, %rsp
	movl %edi, %eax
	movl %edx, %ecx
.divide_stuff_0:
	cltd
	idivl %esi
	addl %ecx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1024, %edi
	movl $8, %esi
	movl $128, %edx
	callq _c0_divide_stuff
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
