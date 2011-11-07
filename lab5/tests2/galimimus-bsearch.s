.file	"../tests2/galimimus-bsearch.l4"
.globl _c0_main
_c0_bsearch:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
	movl %edx, %ecx
.bsearch_0:
	movl $0, %edx
	movl %ecx, %esi
	subl $1, %esi
	movl $0, %ecx
	subl $1, %ecx
.bsearch_12:
	movl %ecx, %eax
	movl %esi, %ecx
	movl %edx, %esi
.bsearch_1:
	movl $1, %edi
	movl %esi, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .bsearch_10
.bsearch_2:
	movl %esi, %eax
	addl %ecx, %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %eax
	movl $1, %edi
	movl %r8d, %edx
	cmpl %eax, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .bsearch_3
.bsearch_7:
	movl %ebx, %ecx
	subl $1, %ecx
.bsearch_14:
	movl %esi, %edx
.bsearch_9:
.bsearch_11:
	movl %ebx, %eax
	movl %edx, %esi
	jmp .bsearch_1
.bsearch_3:
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edi
	movl $1, %esi
	movl %edi, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .bsearch_4
.bsearch_5:
	movl %ebx, %edx
	addl $1, %edx
.bsearch_8:
.bsearch_13:
	jmp .bsearch_9
.bsearch_4:
	movl %ebx, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.bsearch_10:
	movl %eax, %r8d
	addl $1, %r8d
	movl $0, %eax
	subl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_myassert:
	addq $-8, %rsp
.myassert_0:
	movl $1, %r9d
	movl $1, %r8d
	xorl %edi, %r8d
	cmpl %r8d, %r9d
	jnz .myassert_3
.myassert_1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.myassert_3:
.myassert_4:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $10, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
.main_5:
	movl %r8d, %ecx
.main_1:
	movl $1, %edx
	movl $10, %r8d
	movl %ecx, %esi
	cmpl %r8d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_3
.main_2:
	movl %ecx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl %ecx, (%rdx)
	movl %ecx, %r8d
	addl $1, %r8d
.main_4:
	movl %r8d, %ecx
	jmp .main_1
.main_3:
	movq %r9, %rdi
	movl $0, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $0, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $1, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $2, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $2, %ecx
	movl %ecx, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $3, %ecx
	movl %ecx, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $4, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $4, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $5, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $5, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $6, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $6, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $7, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $7, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $8, %esi
	movl $10, %edx
	movq %r9, %rbx
	callq _c0_bsearch
	movq %rbx, %r9
	movl $8, %r8d
	movl %r8d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $9, %esi
	movl $10, %edx
	callq _c0_bsearch
	movl $9, %r9d
	movl %r9d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	callq _c0_myassert
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
