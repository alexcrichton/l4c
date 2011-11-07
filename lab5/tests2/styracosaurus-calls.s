.file	"../tests2/styracosaurus-calls.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $15, %edi
	callq tofloat
	movl %eax, %r9d
	movl %r9d, %edi
	callq fromfloat
	movl $1, %ecx
	movl $15, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
