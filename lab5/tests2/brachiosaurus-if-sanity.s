.file	"../tests2/brachiosaurus-if-sanity.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %ecx
	movl $1, %r8d
	cmpl %ecx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_2
.main_1:
	movl $2, %r9d
.main_5:
.main_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $3, %r9d
.main_4:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
