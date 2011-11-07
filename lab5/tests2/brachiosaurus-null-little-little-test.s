.file	"../tests2/brachiosaurus-null-little-little-test.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movl $1, %ecx
	movq $0, %r8
	movq %rax, %r9
	cmpq %r8, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $75, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $426, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
