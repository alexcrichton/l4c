.file	"../tests2/diplodocus-selection_sort.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $2000, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %rbx
	movl $0, %r9d
.main_14:
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $2000, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl $2000, (%r9)
	subl %edx, (%r9)
	movl %edx, %r9d
	addl $1, %r9d
.main_13:
	movl %r9d, %edx
	jmp .main_1
.main_3:
	movl $0, %r9d
.main_16:
	movl %r9d, %eax
.main_4:
	movl $1, %ecx
	movl $2000, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_12
.main_5:
	movl %eax, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %r8d
	movl %eax, %r9d
	addl $1, %r9d
.main_18:
	movl %r8d, %edi
	movl %r9d, %esi
.main_6:
	movl $1, %ecx
	movl $2000, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_11
.main_7:
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %edx
	movl %eax, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_9
.main_8:
	movl %esi, %r9d
.main_20:
	movl %r9d, %r8d
.main_10:
	movl %esi, %r9d
	addl $1, %r9d
.main_17:
	movl %r8d, %edi
	movl %r9d, %esi
	jmp .main_6
.main_9:
.main_19:
	movl %edi, %r8d
	jmp .main_10
.main_11:
	movl %eax, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %edx
	movl %edi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl %eax, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl %ecx, (%r9)
	movl %edi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl %edx, (%r9)
	movl %eax, %r9d
	addl $1, %r9d
.main_15:
	movl %r9d, %eax
	jmp .main_4
.main_12:
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
