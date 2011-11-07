.file	"../tests2/seismosaurus-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
.main_1:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_4
.main_2:
	movl $4, %r8d
	addl $4, %r8d
	jmp .main_4
.main_4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
	jmp .main_4
.ident	"15-411 L4 reference compiler"
