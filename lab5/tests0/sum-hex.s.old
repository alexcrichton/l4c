.file	"../tests0/sum-hex.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
.main_5:
.main_1:
	movq %r9, %rbx
	callq eof
	movq %rbx, %r9
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movq %r9, %rbx
	callq readhex
	movq %rbx, %r9
	movl %eax, %r8d
	addl %r8d, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
