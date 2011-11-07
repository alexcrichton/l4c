.file	"../tests2/monoclonius-val1.l4"
.globl _c0_main
_c0_alloc_node:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.alloc_node_0:
	movq $1, %rdi
	movq $20, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, (%r8)
	movq $16, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_contains:
	addq $-8, %rsp
.contains_0:
	movl $1, %ecx
	movq $0, %rdx
	movq %rdi, %r8
	cmpq %rdx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .contains_3
.contains_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.contains_3:
.contains_4:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %r8d
	movl %esi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .contains_7
.contains_5:
	movl $1, %eax
	addq $8, %rsp
	ret
.contains_7:
.contains_8:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .contains_10
.contains_9:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_contains
	addq $8, %rsp
	ret
.contains_10:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_contains
	addq $8, %rsp
	ret
_c0_add:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.add_0:
	movq $16, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movl (%rdx), %ecx
	movl $1, %edx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .add_3
.add_1:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.add_3:
.add_4:
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .add_8
.add_5:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .add_7
.add_6:
	movl %r8d, %edi
	movq %r9, %rbx
	callq _c0_alloc_node
	movq %rbx, %r9
	movq $0, %rcx
	addq %rcx, %r9
	movq %rax, (%r9)
.add_11:
.add_13:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.add_7:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_add
	movq %r12, %r8
	movq %rbx, %r9
	jmp .add_11
.add_8:
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .add_10
.add_9:
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_alloc_node
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq %rax, (%rcx)
.add_12:
	jmp .add_13
.add_10:
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_add
	movq %r12, %r8
	movq %rbx, %r9
	jmp .add_12
_c0_main:
	addq $-104, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $0, %r9d
	movl $135, %edi
	movq %r9, %rbx
	callq _c0_alloc_node
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $75, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_contains
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_2
.main_1:
	movl %r9d, %ecx
	addl $1, %ecx
.main_38:
	movl %ecx, %r13d
.main_3:
	movq %r8, %rdi
	movl $75, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_add
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl $135, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_contains
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_5
.main_4:
	movl %r13d, %ecx
	addl $2, %ecx
.main_40:
.main_6:
	movq %r8, %rdi
	movl $140, %esi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_add
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl $76, %esi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_contains
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_8
.main_7:
	movl %ecx, %edx
	addl $4, %edx
.main_42:
	movl %edx, 92(%rsp)
.main_9:
	movq %r8, %rdi
	movl $141, %esi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_add
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl $139, %esi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_contains
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .main_11
.main_10:
	movl 92(%rsp), %edx
	addl $8, %edx
.main_44:
	movl %edx, %ebx
.main_12:
	movq %r8, %rdi
	movl $142, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_add
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movq %r8, %rdi
	movl $142, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_contains
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .main_14
.main_13:
	movl %ebx, %edx
	addl $16, %edx
.main_46:
	movl %edx, %r15d
.main_15:
	movq %r8, %rdi
	movl $143, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_add
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movq %r8, %rdi
	movl $143, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_contains
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_17
.main_16:
	movl %r15d, %edx
	addl $32, %edx
.main_48:
	movl %edx, 96(%rsp)
.main_18:
	movq %r8, %rdi
	movl $0, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_add
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movq %r8, %rdi
	movl $75, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_contains
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_20
.main_19:
	movl 96(%rsp), %edx
	addl $64, %edx
.main_50:
.main_21:
	movq %r8, %rdi
	movl $2, %esi
	movq %rdx, 52(%rsp)
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_add
	movq 52(%rsp), %rdx
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movq %r8, %rdi
	movl $0, %esi
	movq %rdx, 52(%rsp)
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_contains
	movq 52(%rsp), %rdx
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .main_23
.main_22:
	movl %edx, %esi
	addl $128, %esi
.main_52:
	movl %esi, %r12d
.main_24:
	movq %r8, %rdi
	movl $56, %esi
	movq %rdx, 60(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _c0_add
	movq 60(%rsp), %rdx
	movq 52(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movq %r8, %rdi
	movl $1, %esi
	movq %rdx, 60(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _c0_contains
	movq 60(%rsp), %rdx
	movq 52(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl $1, %edi
	cmpl %eax, %edi
	jnz .main_26
.main_25:
	movl %r12d, %esi
	addl $256, %esi
.main_54:
	movl %esi, %r14d
.main_27:
	movq %r8, %rdi
	movl $75, %esi
	movq %rdx, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbp
	callq _c0_add
	movq 68(%rsp), %rdx
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbp, %r9
	movq %r8, %rdi
	movl $75, %esi
	movq %rdx, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbp
	callq _c0_contains
	movq 68(%rsp), %rdx
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbp, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .main_29
.main_28:
	movl %r14d, %esi
	addl $512, %esi
.main_56:
	movl %esi, %ebp
.main_30:
	movq %r8, %rdi
	movl $76, %esi
	movq %rdx, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 52(%rsp)
	callq _c0_add
	movq 76(%rsp), %rdx
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 52(%rsp), %r9
	movq %r8, %rdi
	movl $0, %esi
	movq %rdx, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 52(%rsp)
	callq _c0_contains
	movq 76(%rsp), %rdx
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 52(%rsp), %r9
	movl $1, %edi
	cmpl %eax, %edi
	jnz .main_32
.main_31:
	movl %ebp, %esi
	addl $1024, %esi
.main_58:
	movl %esi, 100(%rsp)
.main_33:
	movq %r8, %rdi
	movl $77, %esi
	movq %rdx, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_add
	movq 84(%rsp), %rdx
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movq %r8, %rdi
	movl $77, %esi
	movq %rdx, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_contains
	movq 84(%rsp), %rdx
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movl $1, %edi
	cmpl %eax, %edi
	jnz .main_35
.main_34:
	movl 100(%rsp), %r9d
	addl $2048, %r9d
.main_60:
	movl %r9d, %esi
.main_36:
	movl %esi, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $104, %rsp
	ret
.main_35:
.main_59:
	movl 100(%rsp), %esi
	jmp .main_36
.main_32:
.main_57:
	movl %ebp, 100(%rsp)
	jmp .main_33
.main_29:
.main_55:
	movl %r14d, %ebp
	jmp .main_30
.main_26:
.main_53:
	movl %r12d, %r14d
	jmp .main_27
.main_23:
.main_51:
	movl %edx, %r12d
	jmp .main_24
.main_20:
.main_49:
	movl 96(%rsp), %edx
	jmp .main_21
.main_17:
.main_47:
	movl %r15d, 96(%rsp)
	jmp .main_18
.main_14:
.main_45:
	movl %ebx, %r15d
	jmp .main_15
.main_11:
.main_43:
	movl 92(%rsp), %ebx
	jmp .main_12
.main_8:
.main_41:
	movl %ecx, 92(%rsp)
	jmp .main_9
.main_5:
.main_39:
	movl %r13d, %ecx
	jmp .main_6
.main_2:
.main_37:
	movl %r9d, %r13d
	jmp .main_3
.ident	"15-411 L4 reference compiler"
