.file	"../tests2/velociraptor-ordered-vector.l4"
.globl _c0_main
_c0_insert:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r8
	movl %esi, %r9d
.insert_0:
	movq $12, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl (%rdx), %edi
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $1, %edx
	movl %edi, %ecx
	cmpl %esi, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .insert_3
.insert_1:
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_double
	movq %rbx, %r9
	movq %rax, %rdi
	movl %r9d, %esi
	callq _c0_insert
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_3:
.insert_4:
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
.insert_9:
	movl %ecx, %edi
.insert_5:
	movl $0, %ecx
	cmpl %edi, %ecx
	jl .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %edi, %ecx
	subl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %r9d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .insert_7
.insert_6:
	movl %edi, %eax
	subl $1, %eax
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdi
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %eax, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %eax, %ecx
	addl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
.insert_8:
	movl %eax, %edi
	jmp .insert_5
.insert_7:
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl %r9d, (%rcx)
	movq $8, %r9
	movq %r8, %rdx
	addq %r9, %rdx
	movq $8, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, (%rdx)
	addl $1, (%rdx)
	movq %r8, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_init:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.init_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $12, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $2, (%r8)
	movq $12, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %edx
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movslq %edx, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_double:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.double_0:
	movq $12, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $2, %r8d
	imull %ecx, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
.double_5:
	movl %r8d, %esi
.double_1:
	movq $12, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .double_3
.double_2:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl %esi, %r8d
	addl $1, %r8d
.double_4:
	movl %r8d, %esi
	jmp .double_1
.double_3:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $12, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movq $12, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	movl (%rdx), %r11d
	imull $2, %r11d
	movl %r11d, (%rdx)
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_init
	movq %rax, %r9
	movl $0, %r8d
	movq %r9, %rdi
	movl $5, %esi
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
	movl $12, %esi
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
	movl $1, %esi
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
	movl $14, %esi
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
	movl $11, %esi
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
	movl $6, %esi
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
	movl $15, %esi
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
.main_9:
.main_1:
	movl $1, %esi
	movl $20, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_7
.main_2:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rsi
	movq %rdx, %rcx
	addq %rsi, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rdx
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %rdx
	movl (%rdx), %edx
	movl $1, %ecx
	movl %r8d, %esi
	addl $1, %esi
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_5
.main_3:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
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
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
