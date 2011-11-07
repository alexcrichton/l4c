.file	"../tests2/diplodocus-return01.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	callq _c0_infinite_loop
	movl $1, %r9d
	movl %eax, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_infinite_loop:
	addq $-8, %rsp
.infinite_loop_0:
	movl $1, %r9d
.infinite_loop_1:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .infinite_loop_4
.infinite_loop_2:
	jmp .infinite_loop_1
.infinite_loop_4:
	movl $555, %eax
	addq $8, %rsp
	ret
	jmp .infinite_loop_1
.ident	"15-411 L4 reference compiler"
