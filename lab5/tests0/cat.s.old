.file	"../tests0/cat.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
.main_1:
	callq eof
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	callq readchar
	movl %eax, %edi
	callq printchar
	jmp .main_1
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
