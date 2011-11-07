.file	"../tests2/saltopus-main.l3"
.globl _c0_main
_c0_lol:
	addq $-8, %rsp
.lol_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .lol_3
.lol_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.lol_3:
.lol_4:
	subl $1, %edi
	callq _c0_lol
	movl $1, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $8, %edi
	callq _c0_lol
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
