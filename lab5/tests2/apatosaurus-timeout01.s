.file	"../tests2/apatosaurus-timeout01.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_5:
	movl %r9d, %r8d
.main_1:
	movl $1, %ecx
	movl $1, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %r8d, %edi
	callq tofloat
	movl %eax, %r9d
.main_4:
	movl %r9d, %r8d
	jmp .main_1
.main_3:
	movl $5, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
