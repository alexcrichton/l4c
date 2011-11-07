.file	"../tests2/galimimus-pass-by-value.l4"
.globl _c0_main
_c0_rob_fail:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.rob_fail_0:
	movq %rdi, %r9
	movl (%r9), %r9d
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, (%r8)
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movl $1000, (%r8)
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_rob_fail
	movq %rbx, %r9
	movl $1, %edx
	movl $1000, %ecx
	movl %eax, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_2
.main_1:
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
.main_3:
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_2:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
