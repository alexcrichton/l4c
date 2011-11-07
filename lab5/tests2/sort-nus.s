.file	"../tests2/sort-nus.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $50, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
.main_5:
	movl %r8d, %esi
.main_1:
	movl $1, %edx
	movl $50, %r8d
	movl %esi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $50, (%r8)
	subl %esi, (%r8)
	movl %esi, %r8d
	addl $1, %r8d
.main_4:
	movl %r8d, %esi
	jmp .main_1
.main_3:
	movq %r9, %rdi
	movl $50, %esi
	movq %r9, %rbx
	callq _c0_sort
	movq %rbx, %r9
	movl $41, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_sort:
	addq $-88, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movq %rdi, %rcx
	movl %esi, %ebx
.sort_0:
	movslq %ebx, %rdi
	movq $4, %rsi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, %rdx
	movslq %ebx, %rdi
	movq $4, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, 60(%rsp)
	movl $0, %r13d
	movl $0, %eax
	movl $1, 68(%rsp)
	movl %r13d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl $0, (%rsi)
	movl %eax, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 60(%rsp), %rsi
	addq %rdi, %rsi
	movl %ebx, (%rsi)
	subl $1, (%rsi)
	movl %r13d, %edi
	addl $1, %edi
	movl %eax, %esi
	addl $1, %esi
.sort_17:
	movl %esi, %r13d
	movl %edi, %ebx
.sort_1:
	movl $0, %esi
	cmpl %esi, %ebx
	jnz .ternary_true1
	movl $0, %edi
	jmp .ternary_end2
.ternary_true1:
	movl $0, %esi
	movl %r13d, %edi
	cmpl %esi, %edi
	setne %dil
	movzbl %dil, %edi
.ternary_end2:
	movl $1, %esi
	cmpl %edi, %esi
	jnz .sort_15
.sort_2:
	movl %ebx, %esi
	subl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %esi, %eax
	movl %r13d, %esi
	subl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 60(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %eax, 72(%rsp)
	movl %ebx, 76(%rsp)
	subl $1, 76(%rsp)
	movl %r13d, 80(%rsp)
	subl $1, 80(%rsp)
.sort_19:
	movl %esi, 84(%rsp)
	movl %eax, %ebp
.sort_3:
	movl $1, %edi
	movl %ebp, %esi
	cmpl 84(%rsp), %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .sort_11
.sort_4:
	movl 84(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r15d
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r14d
	movl $1, %edi
	movl %r15d, %esi
	cmpl %r14d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .sort_5
.sort_8:
	movl %ebp, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %eax
	movl %eax, %edi
	movl 84(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %esi
	movl %ebp, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl %esi, (%r9)
	movl 84(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl %edi, (%r9)
.sort_23:
	movl %esi, %r13d
	movl %eax, %ebx
	movl %edi, %eax
	movl 84(%rsp), %edi
	movl %ebp, %esi
.sort_10:
.sort_18:
	movl %r13d, %r12d
	movl %ebx, %r8d
	movl %eax, %r9d
	movl %edi, 84(%rsp)
	movl %esi, %ebp
	jmp .sort_3
.sort_5:
	movl $1, %esi
	cmpl 68(%rsp), %esi
	jnz .sort_7
.sort_6:
	movl %ebp, %esi
	addl $1, %esi
.sort_21:
	movl 84(%rsp), %edi
.sort_9:
.sort_22:
	movl %r12d, %r13d
	movl %r8d, %ebx
	movl %r9d, %eax
	jmp .sort_10
.sort_7:
	movl 84(%rsp), %esi
	subl $1, %esi
.sort_20:
	movl %esi, %edi
	movl %ebp, %esi
	jmp .sort_9
.sort_11:
	movl $1, %edi
	movl %ebp, %esi
	cmpl 72(%rsp), %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .sort_13
.sort_12:
	movl 76(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl 72(%rsp), %r10d
	movl %r10d, (%rsi)
	movl 80(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 60(%rsp), %rdi
	addq %rsi, %rdi
	movl %ebp, (%rdi)
	subl $1, (%rdi)
	movl 76(%rsp), %edi
	addl $1, %edi
	movl 80(%rsp), %esi
	addl $1, %esi
.sort_25:
.sort_14:
.sort_16:
	movl %esi, %r13d
	movl %edi, %ebx
	jmp .sort_1
.sort_13:
.sort_24:
	movl 80(%rsp), %esi
	movl 76(%rsp), %edi
	jmp .sort_14
.sort_15:
	movl $1, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
