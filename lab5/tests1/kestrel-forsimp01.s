.file	"../tests1/kestrel-forsimp01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
.main_1:
	movl $1, %r9d
	movl $0, %r8d
	cmpl %r8d, %r9d
	jnz .main_3
.main_2:
	jmp .main_1
.main_3:
	movl $42, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
