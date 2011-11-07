.file	"../tests2/dilophosaurus-args02.l3"
.globl _c0_main
_c0_testFlag:
	addq $-8, %rsp
.testFlag_0:
	movl %edi, %r9d
	andl $8, %r9d
	movl $0, %r8d
	movl %r9d, %eax
	cmpl %r8d, %eax
	setne %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %r9d
	sarl $3, %r9d
	movl %r9d, %edi
	sall $3, %edi
	callq _c0_testFlag
	cmpl $0, %eax
	jnz .ternary_true1
	movl $0, %r9d
	subl $1, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $100, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
