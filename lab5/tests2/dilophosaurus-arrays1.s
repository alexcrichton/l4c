.file	"../tests2/dilophosaurus-arrays1.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $100, %rdi
	movq $4, %rsi
	callq calloc
	movl $0, %r9d
.main_5:
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $100, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl $0, %r9d
	cmpl %edx, %r9d
	jl .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl %edx, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %ecx
.ternary_end2:
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl %edx, (%r9)
	subl %ecx, (%r9)
	movl %edx, %r9d
	addl $1, %r9d
.main_4:
	movl %r9d, %edx
	jmp .main_1
.main_3:
	movl $99, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
