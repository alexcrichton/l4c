.file	"../tests2/styracosaurus-matrix.l4"
.globl _c0_main
_c0_allocate_matrix:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.allocate_matrix_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movq $3, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %rcx
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %rdx
	movq %rcx, %r8
	addq %rdx, %r8
	movq $3, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %rdx
	movl $1, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq $3, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %r8
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movq $3, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_allocate_vector:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.allocate_vector_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movq $3, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_m_multiply:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movq %rdi, 52(%rsp)
	movq %rsi, 60(%rsp)
.m_multiply_0:
	movq %rdx, 68(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_allocate_matrix
	movq 68(%rsp), %rdx
	movq 76(%rsp), %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, 68(%rsp)
	movl $0, %esi
.m_multiply_11:
	movl %esi, %ebx
.m_multiply_1:
	movl $1, %esi
	movl $3, %eax
	movl %ebx, %edi
	cmpl %eax, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .m_multiply_9
.m_multiply_2:
	movl $0, %esi
.m_multiply_13:
	movl %esi, 156(%rsp)
.m_multiply_3:
	movl $1, %edi
	movl $3, %esi
	movl 156(%rsp), %eax
	cmpl %esi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %edi
	jnz .m_multiply_8
.m_multiply_4:
	movl $0, %edi
.m_multiply_15:
	movl %ebp, 160(%rsp)
	movl %r15d, %esi
	movq %r12, 84(%rsp)
	movq %rdx, 92(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 168(%rsp)
	movq %r14, 100(%rsp)
	movl %ecx, 172(%rsp)
	movq 108(%rsp), %rax
	movq %r8, 116(%rsp)
	movq %r9, 124(%rsp)
	movl %edi, %r13d
.m_multiply_5:
	movl $1, %ecx
	movl $3, %r8d
	movl %r13d, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .m_multiply_7
.m_multiply_6:
	movq 68(%rsp), %r9
	movq (%r9), %r12
	movl %ebx, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movq (%r9), %r14
	movq 68(%rsp), %r9
	movq (%r9), %r15
	movl %ebx, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r15, %r9
	addq %r8, %r9
	movq (%r9), %rbp
	movl 156(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 176(%rsp)
	movl %ebx, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq 52(%rsp), %r9
	addq %r8, %r9
	movq (%r9), %r10
	movq %r10, 132(%rsp)
	movl %r13d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 132(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r13d, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq 60(%rsp), %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl 156(%rsp), %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl (%rdx), %ecx
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rcx, 84(%rsp)
	movq %r8, 100(%rsp)
	movq %r9, 140(%rsp)
	callq fmul
	movq 84(%rsp), %rcx
	movq 100(%rsp), %r8
	movq 140(%rsp), %r9
	movl %eax, %edx
	movl 176(%rsp), %edi
	movl %edx, %esi
	movq %rdx, 148(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 100(%rsp)
	movq %r9, 140(%rsp)
	callq fadd
	movq 148(%rsp), %rdx
	movq 84(%rsp), %rcx
	movq 100(%rsp), %r8
	movq 140(%rsp), %r9
	movl 156(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq %r14, %rdi
	addq %rsi, %rdi
	movl %eax, (%rdi)
	movl %r13d, %edi
	addl $1, %edi
.m_multiply_14:
	movl %eax, 160(%rsp)
	movl 176(%rsp), %esi
	movq %rbp, 84(%rsp)
	movq %r15, 92(%rsp)
	movl %edx, 180(%rsp)
	movl %r9d, 168(%rsp)
	movq 132(%rsp), %r10
	movq %r10, 100(%rsp)
	movl %ecx, 172(%rsp)
	movq %r8, %rax
	movq %r14, 116(%rsp)
	movq %r12, 124(%rsp)
	movl %edi, %r13d
	jmp .m_multiply_5
.m_multiply_7:
	movl 156(%rsp), %edi
	addl $1, %edi
.m_multiply_12:
	movl 160(%rsp), %ebp
	movl %esi, %r15d
	movq 84(%rsp), %r12
	movq 92(%rsp), %rdx
	movl 168(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movq 100(%rsp), %r14
	movl 172(%rsp), %ecx
	movq %rax, 108(%rsp)
	movq 116(%rsp), %r8
	movq 124(%rsp), %r9
	movl %edi, 156(%rsp)
	jmp .m_multiply_3
.m_multiply_8:
	movl %ebx, %esi
	addl $1, %esi
.m_multiply_10:
	movl %esi, %ebx
	jmp .m_multiply_1
.m_multiply_9:
	movq 68(%rsp), %rax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_v_multiply:
	addq $-104, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.v_multiply_0:
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_allocate_vector
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl $0, %edx
.v_multiply_8:
	movl %edx, %ebp
.v_multiply_1:
	movl $1, %edi
	movl $3, %esi
	movl %ebp, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .v_multiply_6
.v_multiply_2:
	movl $0, %edx
.v_multiply_10:
	movl %edx, %r14d
.v_multiply_3:
	movl $1, %esi
	movl $3, %edx
	movl %r14d, %edi
	cmpl %edx, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .v_multiply_5
.v_multiply_4:
	movq %rcx, %rdx
	movq (%rdx), %rdx
	movq %rcx, %rsi
	movq (%rsi), %r12
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r15d
	movl %ebp, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %r10
	movq %r10, 60(%rsp)
	movl %r14d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 60(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 100(%rsp)
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl (%rsi), %ebx
	movl 100(%rsp), %edi
	movl %ebx, %esi
	movq %rdx, 68(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 84(%rsp)
	movq %r9, %r13
	callq fmul
	movq 68(%rsp), %rdx
	movq 76(%rsp), %rcx
	movq 84(%rsp), %r8
	movq %r13, %r9
	movl %eax, %r13d
	movl %r15d, %edi
	movl %r13d, %esi
	movq %rdx, 92(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 84(%rsp)
	callq fadd
	movq 92(%rsp), %rdx
	movq 68(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edi
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rax
	movq %rdx, %rsi
	addq %rax, %rsi
	movl %edi, (%rsi)
	movl %r14d, %esi
	addl $1, %esi
.v_multiply_9:
	movl %esi, %r14d
	jmp .v_multiply_3
.v_multiply_5:
	movl %ebp, %edx
	addl $1, %edx
.v_multiply_7:
	movl %edx, %ebp
	jmp .v_multiply_1
.v_multiply_6:
	movq %rcx, %r9
	movq (%r9), %r9
	movq %rcx, %r8
	movq (%r8), %r8
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rdx
	addq %rdx, %r8
	movl (%r8), %edi
	movq %rcx, %r8
	movq (%r8), %rsi
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rsi, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl %r8d, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r12, %rcx
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl %eax, (%r9)
	movq %rcx, %r9
	movq (%r9), %r9
	movq %rcx, %r8
	movq (%r8), %rsi
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rsi, %r8
	addq %rdx, %r8
	movl (%r8), %edi
	movq %rcx, %r8
	movq (%r8), %rsi
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rsi, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl %r8d, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r12, %rcx
	movq %rbx, %r9
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl %eax, (%r9)
	movq %rcx, %r9
	movq (%r9), %r9
	movq %rcx, %r8
	movq (%r8), %r8
	movl $2, %edx
	imull $4, %edx
	movslq %edx, %rdx
	addq %rdx, %r8
	movl (%r8), %esi
	movq %rcx, %r8
	movq (%r8), %r8
	movl $2, %edx
	imull $4, %edx
	movslq %edx, %rdx
	addq %rdx, %r8
	movl (%r8), %r8d
	movl %esi, %edi
	movl %r8d, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r12, %rcx
	movq %rbx, %r9
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl %eax, (%r9)
	movq %rcx, %rax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_printpoint:
	addq $-104, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movq %rdi, %rdx
.printpoint_0:
	movl $46, %r13d
	movl $48, %r14d
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %esi, %edi
	movq %rdx, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %rbx
	callq fromfloat
	movq 60(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %rbx, %r9
	movl %eax, %r15d
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	movq %rcx, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %rbx
	callq fromfloat
	movq 60(%rsp), %rcx
	movq %rbp, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movl $10, %edx
.printpoint_11:
	movl %edx, %ebx
.printpoint_1:
	movl $1, %edi
	movl $0, %edx
	subl $10, %edx
	cmpl %ebx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .printpoint_9
.printpoint_2:
	movl $0, %edx
	subl $10, %edx
.printpoint_13:
	movl %edx, %ebp
.printpoint_3:
	movl $1, %eax
	movl $10, %edi
	movl %ebp, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .printpoint_8
.printpoint_4:
	cmpl %r15d, %ebx
	jz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl %ebp, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %edi
	cmpl %edx, %edi
	jnz .printpoint_6
.printpoint_5:
	movl %r14d, %edi
	movq %rsi, 68(%rsp)
	movq %rdx, 76(%rsp)
	movq %rcx, 60(%rsp)
	callq printchar
	movq 68(%rsp), %rsi
	movq 76(%rsp), %rdx
	movq 60(%rsp), %rcx
	movslq %eax, %r9
.printpoint_15:
	movl %ecx, %edi
	movq %r12, 68(%rsp)
	movl %eax, 100(%rsp)
	movq %r9, 60(%rsp)
.printpoint_7:
	movl %ebp, %eax
	addl $1, %eax
.printpoint_12:
	movl %edi, %ecx
	movq 68(%rsp), %r12
	movl 100(%rsp), %r8d
	movq 60(%rsp), %r9
	movl %eax, %ebp
	jmp .printpoint_3
.printpoint_6:
	movl %r13d, %edi
	movq %rsi, 84(%rsp)
	movq %rdx, 92(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 84(%rsp), %rsi
	movq 92(%rsp), %rdx
	movq 68(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 60(%rsp), %r9
	movl %eax, %edi
	movslq %edi, %rax
.printpoint_14:
	movq %rax, 68(%rsp)
	movl %r8d, 100(%rsp)
	movq %r9, 60(%rsp)
	jmp .printpoint_7
.printpoint_8:
	movl $10, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 68(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %ebx, %edx
	subl $1, %edx
.printpoint_10:
	movl %edx, %ebx
	jmp .printpoint_1
.printpoint_9:
	movl $0, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	callq _c0_allocate_matrix
	movq %rax, %rdx
	movq %rdx, %rbx
	callq _c0_allocate_matrix
	movq %rbx, %rdx
	movq %rax, %r8
	movq %rdx, %r12
	movq %r8, %rbx
	callq _c0_allocate_vector
	movq %r12, %rdx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rcx
	movq (%rcx), %rcx
	movl $2, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %edi
	imull $4, %edi
	movslq %edi, %rdi
	addq %rdi, %rcx
	movl %eax, (%rcx)
	movq %r9, %rcx
	movq (%rcx), %rcx
	movl $2, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r9, %rcx
	movq (%rcx), %rcx
	movl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull $4, %edi
	movslq %edi, %rdi
	addq %rdi, %rcx
	movl %eax, (%rcx)
	movq %r9, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_printpoint
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl $10, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl $10, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl $10, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rdx, %rcx
	movq (%rcx), %rsi
	movl $0, %ecx
	imull $8, %ecx
	movslq %ecx, %rcx
	addq %rcx, %rsi
	movq (%rsi), %rcx
	movl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rsi
	movl $0, %ecx
	imull $8, %ecx
	movslq %ecx, %rcx
	addq %rcx, %rsi
	movq (%rsi), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $0, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	subl $4, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull $4, %edi
	movslq %edi, %rdi
	addq %rdi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $1, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $1, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $1, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	subl $3, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $0, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $2, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $0, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $0, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $1, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $1, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $2, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $1, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $0, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rdi
	movl $2, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rcx
	movl %eax, (%rcx)
	movq %rdx, %rcx
	movq (%rcx), %rcx
	movq (%r8), %r8
	movq %rcx, %rdi
	movq %r8, %rsi
	movq %r9, %rbx
	callq _c0_m_multiply
	movq %rbx, %r9
	movq %rax, %r8
	movq (%r8), %r8
	movq (%r9), %r9
	movq %r8, %rdi
	movq %r9, %rsi
	callq _c0_v_multiply
	movq %rax, %r9
	movq %r9, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_printpoint
	movq %rbx, %r9
	movq %r9, %r8
	movq (%r8), %r8
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl (%r8), %ecx
	movq (%r9), %r9
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %ecx, %edi
	movl %r9d, %esi
	callq fadd
	movl %eax, %edi
	callq fromfloat
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
