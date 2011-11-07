.file	"../tests2/velociraptor-heap-heap-hooray.l4"
.globl _c0_main
_c0_percup:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.percup_0:
	movl $1, %ecx
	movl $1, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .percup_3
.percup_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.percup_3:
.percup_4:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %eax, %ebx
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $1, %edx
	movl %edi, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .percup_7
.percup_5:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %eax
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdi
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl %eax, (%r8)
	movq %r9, %rdi
	movl %ebx, %esi
	callq _c0_percup
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.percup_7:
.percup_8:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_percdown:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %ebx
.percdown_0:
	movl $2, %r12d
	imull %ebx, %r12d
	movq $8, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %ecx
	movl $1, %r8d
	cmpl %r12d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .percdown_3
.percdown_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.percdown_3:
.percdown_4:
	movl %r12d, %eax
	addl $1, %eax
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %rcx
	movl (%rcx), %esi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %r12d, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .percdown_11
.percdown_5:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	cmpl %eax, %r8d
	jle .ternary_true1
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movq (%rcx), %r8
	movl %eax, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %edx, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .percdown_8
.percdown_6:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.percdown_8:
.percdown_9:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rsi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %rcx
	movl (%rcx), %edx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl %edi, (%r8)
	movq %r9, %rdi
	movl %eax, %esi
	callq _c0_percdown
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.percdown_11:
.percdown_12:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	cmpl %eax, %r8d
	jl .ternary_true3
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %r12d, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %esi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %ecx
.ternary_end4:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .percdown_15
.percdown_13:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rsi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %r12d, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %r12d, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl %edi, (%r8)
	movq %r9, %rdi
	movl %r12d, %esi
	callq _c0_percdown
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.percdown_15:
.percdown_16:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rsi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl %edi, (%r8)
	movq %r9, %rdi
	movl %eax, %esi
	callq _c0_percdown
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_insert:
	addq $-8, %rsp
.insert_0:
	movq $8, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movq $8, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rdx)
	addl $1, (%rdx)
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl %esi, (%r8)
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl %ecx, %esi
	callq _c0_percup
	addq $8, %rsp
	ret
_c0_removemin:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.removemin_0:
	movq $0, %r9
	movq %rdi, %r8
	addq %r9, %r8
	movq (%r8), %r9
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rsi
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $8, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl (%rcx), %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movq $8, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	subl $1, (%rdx)
	movl $1, %esi
	movq %r9, %rbx
	callq _c0_percdown
	movq %rbx, %r9
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $12, %rsi
	callq calloc
	movq %rax, %r9
	movl $1, %r8d
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq $21, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movq %r9, %rdi
	movl $5, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $19, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $10, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $15, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $17, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $9, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $13, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $14, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $20, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $18, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $16, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $12, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $11, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $8, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $7, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $6, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $4, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $2, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
.main_9:
.main_1:
	movl $1, %esi
	movl $20, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_7
.main_2:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_removemin
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %ecx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %r8d, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_5
.main_3:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_5:
.main_6:
	addl $1, %r8d
.main_8:
	jmp .main_1
.main_7:
	movl $10, %edi
	callq printchar
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
