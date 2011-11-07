.file	"../tests2/brachiosaurus-the-wizards-apprentice-2-electric-boogaloo.l3"
.globl _c0_main
_c0_shift_stuff:
	addq $-8, %rsp
	movl %esi, %r8d
	movl %edx, %esi
	movl %ecx, %edx
.shift_stuff_0:
	movl %edi, %r9d
	movl %r8d, %ecx
	sall %cl, %r9d
	movl %esi, %ecx
	sarl %cl, %r9d
	movl %r9d, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1024, %edi
	movl $21, %esi
	movl $23, %edx
	movl $512, %ecx
	callq _c0_shift_stuff
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
