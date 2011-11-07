.file	"../tests2/ouranosaurus-longest_inc_sub.l4"
.globl _c0_main
_c0_search:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
	movl %edx, %esi
.search_0:
	movl $1, %edx
	movl %ecx, %edi
	cmpl %esi, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %edx
	jnz .search_3
.search_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.search_3:
.search_4:
	movl %ecx, %eax
	subl %esi, %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %edx
	movl %esi, %eax
	addl %edx, %eax
	movl %eax, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %ebx
	movl $1, %edx
	movl %r8d, %edi
	cmpl %ebx, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %edx
	jnz .search_6
.search_5:
	movq %r9, %rdi
	movl %r8d, %ecx
	movl %esi, %edx
	movl %eax, %r9d
	subl $1, %r9d
	movl %ecx, %esi
	movl %r9d, %ecx
	callq _c0_search
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.search_6:
	movl %eax, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl $1, %esi
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .search_8
.search_7:
	movq %r9, %rdi
	movl %r8d, %esi
	movl %eax, %edx
	addl $1, %edx
	callq _c0_search
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.search_8:
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_longest_inc_sub:
	addq $-72, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movq %rdi, %rcx
	movl %esi, %edx
.longest_inc_sub_0:
	movslq %edx, %rdi
	movq $4, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, 60(%rsp)
	movl $0, %esi
.longest_inc_sub_20:
	movl %esi, 68(%rsp)
.longest_inc_sub_1:
	movl $1, %edi
	movl 68(%rsp), %esi
	cmpl %edx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .longest_inc_sub_12
.longest_inc_sub_2:
	movl $0, %edi
	movl $0, %esi
.longest_inc_sub_22:
	movl %edi, %ebp
	movl %esi, %r15d
.longest_inc_sub_3:
	movl $1, %edi
	movl %r15d, %esi
	cmpl 68(%rsp), %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .longest_inc_sub_11
.longest_inc_sub_4:
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r14d
	movl 68(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r13d
	movl $1, %edi
	movl %r14d, %esi
	cmpl %r13d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .longest_inc_sub_9
.longest_inc_sub_5:
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 60(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %ebx
	movl $1, %edi
	movl %ebp, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .longest_inc_sub_7
.longest_inc_sub_6:
	movl %r15d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 60(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %r8d, %r9d
.longest_inc_sub_24:
	movl %r8d, %edi
	movl %r9d, %esi
.longest_inc_sub_8:
.longest_inc_sub_26:
	movl %edi, %r12d
	movl %ebx, %eax
	movl %esi, %edi
.longest_inc_sub_10:
	movl %r15d, %esi
	addl $1, %esi
.longest_inc_sub_21:
	movl %r12d, %r8d
	movl %eax, %r9d
	movl %edi, %ebp
	movl %esi, %r15d
	jmp .longest_inc_sub_3
.longest_inc_sub_7:
.longest_inc_sub_23:
	movl %r8d, %edi
	movl %ebp, %esi
	jmp .longest_inc_sub_8
.longest_inc_sub_9:
.longest_inc_sub_25:
	movl %r8d, %r12d
	movl %r9d, %eax
	movl %ebp, %edi
	jmp .longest_inc_sub_10
.longest_inc_sub_11:
	movl 68(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 60(%rsp), %rsi
	addq %rdi, %rsi
	movl %ebp, (%rsi)
	addl $1, (%rsi)
	movl 68(%rsp), %esi
	addl $1, %esi
.longest_inc_sub_19:
	movl %esi, 68(%rsp)
	jmp .longest_inc_sub_1
.longest_inc_sub_12:
	movl $0, %r8d
	movl $0, %r9d
.longest_inc_sub_28:
	movl %r8d, %edi
	movl %r9d, %esi
.longest_inc_sub_13:
	movl $1, %r8d
	movl %esi, %r9d
	cmpl %edx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .longest_inc_sub_18
.longest_inc_sub_14:
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 60(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl $1, %r8d
	movl %edi, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .longest_inc_sub_16
.longest_inc_sub_15:
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 60(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %r8d, %r9d
.longest_inc_sub_30:
	movl %r9d, %r8d
.longest_inc_sub_17:
	movl %esi, %r9d
	addl $1, %r9d
.longest_inc_sub_27:
	movl %r8d, %edi
	movl %r9d, %esi
	jmp .longest_inc_sub_13
.longest_inc_sub_16:
.longest_inc_sub_29:
	movl %edi, %r8d
	jmp .longest_inc_sub_17
.longest_inc_sub_18:
	movl %edi, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $16, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movl $0, (%rcx)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $8, (%r8)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $4, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $12, (%r8)
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $2, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $10, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $6, (%r8)
	movl $7, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movl $14, (%rcx)
	movl $8, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movl $9, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $9, (%r8)
	movl $10, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $5, (%r8)
	movl $11, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $13, (%r8)
	movl $12, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $3, (%r8)
	movl $13, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $11, (%r8)
	movl $14, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $7, (%r8)
	movl $15, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $15, (%r8)
	movq %rax, %rdi
	movl %r9d, %esi
	callq _c0_longest_inc_sub
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
