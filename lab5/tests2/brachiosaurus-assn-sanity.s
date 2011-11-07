.file	"../tests2/brachiosaurus-assn-sanity.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	sall $2, %r9d
	sarl $2, %r9d
	orl $7, %r9d
	movl %r9d, %ecx
	andl $7, %ecx
	cmpl %ecx, %ecx
	jz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %ecx, %r9d
	cmpl %ecx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl %ecx, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
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
