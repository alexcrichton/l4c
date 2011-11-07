.file	"../tests2/apatosaurus-array-loop.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $500, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $1, %esi
	movl $0, %r8d
.main_8:
	movl %r8d, %edx
.main_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl (%r8), %r11d
	imull $2, %r11d
	movl %r11d, (%r8)
	movl %edx, %r8d
	addl $1, %r8d
.main_7:
	movl %r8d, %edx
	jmp .main_1
.main_3:
	movl $0, %r8d
.main_10:
	movl %r8d, %edx
.main_4:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_5:
	cmpl $0, %esi
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl %edx, %r8d
	imull $2, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl %r8d, %ecx
	movl %edx, %r8d
	addl $1, %r8d
.main_9:
	movl %ecx, %esi
	movl %r8d, %edx
	jmp .main_4
.main_6:
	cmpl $0, %esi
	jnz .ternary_true3
	movl $0, %r9d
	subl $1, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $500, %r9d
.ternary_end4:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
