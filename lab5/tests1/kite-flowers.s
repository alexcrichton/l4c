.file	"../tests1/kite-flowers.l4"
.globl _c0_main
_c0_ppath:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movq %rdx, %rdi
.ppath_0:
	movl $1, %edx
	movl $0, %ecx
	movl %r8d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .ppath_2
.ppath_1:
	movl %r9d, %edi
	addl $1, %edi
	callq printint
.ppath_3:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ppath_2:
	movl %r8d, %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl %r9d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edx
	movl %r8d, %esi
	subl $1, %esi
	movq %rdi, %r8
	movl %edx, %edi
	movq %r8, %rdx
	movq %r9, %rbx
	callq _c0_ppath
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	addl $1, %edi
	callq printint
	jmp .ppath_3
_c0_main:
	addq $-136, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movq $100, %rdi
	movq $8, %rsi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq calloc
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, %r14
	movq $100, %rdi
	movq $8, %rsi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq calloc
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq $100, %rdi
	movq $8, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, %r13
	movl $0, %esi
.main_32:
	movl %esi, %r15d
.main_1:
	movl $1, %edi
	movl $100, %eax
	movl %r15d, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_3
.main_2:
	movl %r15d, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %r14, %rbx
	addq %rsi, %rbx
	movq $100, %rdi
	movq $4, %rsi
	movq %rdx, 52(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, %rbp
	callq calloc
	movq 52(%rsp), %rdx
	movq 60(%rsp), %rcx
	movq 68(%rsp), %r8
	movq %rbp, %r9
	movq %rax, (%rbx)
	movl %r15d, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %rdx, %rbx
	addq %rsi, %rbx
	movq $100, %rdi
	movq $4, %rsi
	movq %rdx, 52(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, %rbp
	callq calloc
	movq 52(%rsp), %rdx
	movq 60(%rsp), %rcx
	movq 68(%rsp), %r8
	movq %rbp, %r9
	movq %rax, (%rbx)
	movl %r15d, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %r13, %rbx
	addq %rsi, %rbx
	movq $100, %rdi
	movq $4, %rsi
	movq %rdx, 52(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, %rbp
	callq calloc
	movq 52(%rsp), %rdx
	movq 60(%rsp), %rcx
	movq 68(%rsp), %r8
	movq %rbp, %r9
	movq %rax, (%rbx)
	movl %r15d, %esi
	addl $1, %esi
.main_31:
	movl %esi, %r15d
	jmp .main_1
.main_3:
	movq %rdx, 68(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %rbx
	callq readint
	movq 68(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movq %rsi, 60(%rsp)
	movq %rdx, 68(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %rbx
	callq readint
	movq 60(%rsp), %rsi
	movq 68(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movl $0, %eax
.main_34:
	movl %eax, %ebx
.main_4:
	movl $1, %r15d
	movl %ebx, %eax
	cmpl %esi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %r15d
	jnz .main_9
.main_5:
	movl $0, %eax
.main_36:
	movl %eax, %r15d
.main_6:
	movl $1, %ebp
	movl %r15d, %eax
	cmpl %edi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %ebp
	jnz .main_8
.main_7:
	movl %ebx, %eax
	imull $8, %eax
	movslq %eax, %rax
	movq %rdx, %rbp
	addq %rax, %rbp
	movq (%rbp), %rbp
	movq %rdi, 76(%rsp)
	movq %rsi, 84(%rsp)
	movq %rdx, 92(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 68(%rsp)
	callq readint
	movq 76(%rsp), %rdi
	movq 84(%rsp), %rsi
	movq 92(%rsp), %rdx
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 68(%rsp), %r9
	movl %eax, 108(%rsp)
	movl %r15d, %eax
	imull $4, %eax
	movslq %eax, %rax
	movq %rax, 68(%rsp)
	movq %rbp, %rax
	addq 68(%rsp), %rax
	movl 108(%rsp), %r10d
	movl %r10d, (%rax)
	movl %ebx, %eax
	imull $8, %eax
	movslq %eax, %rax
	movq %rax, 68(%rsp)
	movq %r14, %rax
	addq 68(%rsp), %rax
	movq (%rax), %r10
	movq %r10, 60(%rsp)
	movl %r15d, %eax
	imull $4, %eax
	movslq %eax, %rax
	movq %rax, 68(%rsp)
	movq 60(%rsp), %rax
	addq 68(%rsp), %rax
	movl $0, (%rax)
	subl $1000000000, (%rax)
	movl %r15d, %eax
	addl $1, %eax
.main_35:
	movl %eax, %r15d
	jmp .main_6
.main_8:
	movl %ebx, %eax
	addl $1, %eax
.main_33:
	movl %eax, %ebx
	jmp .main_4
.main_9:
	movl $0, %eax
.main_38:
	movl %eax, 112(%rsp)
.main_10:
	movl $1, %ebx
	movl 112(%rsp), %eax
	cmpl %edi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %ebx
	jnz .main_12
.main_11:
	movl $0, %eax
	imull $8, %eax
	movslq %eax, %rbx
	movq %r14, %rax
	addq %rbx, %rax
	movq (%rax), %rbp
	movl $0, %eax
	imull $8, %eax
	movslq %eax, %rbx
	movq %rdx, %rax
	addq %rbx, %rax
	movq (%rax), %r15
	movl 112(%rsp), %eax
	imull $4, %eax
	movslq %eax, %rbx
	movq %r15, %rax
	addq %rbx, %rax
	movl (%rax), %eax
	movl 112(%rsp), %ebx
	imull $4, %ebx
	movslq %ebx, %r15
	movq %rbp, %rbx
	addq %r15, %rbx
	movl %eax, (%rbx)
	movl 112(%rsp), %eax
	addl $1, %eax
.main_37:
	movl %eax, 112(%rsp)
	jmp .main_10
.main_12:
	movl $1, %eax
.main_40:
	movl %eax, 116(%rsp)
.main_13:
	movl $1, %ebx
	movl 116(%rsp), %eax
	cmpl %esi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %ebx
	jnz .main_24
.main_14:
	movl $0, %eax
.main_42:
	movl %eax, 120(%rsp)
.main_15:
	movl $1, %ebx
	movl 120(%rsp), %eax
	cmpl %edi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %ebx
	jnz .main_23
.main_16:
	movl $0, %r15d
	subl $100000000, %r15d
	movl $0, %ebx
	subl $1, %ebx
	movl $0, %eax
.main_44:
	movl %ecx, 124(%rsp)
	movq %r12, 100(%rsp)
	movl %r8d, 128(%rsp)
	movq %r9, 52(%rsp)
	movl %eax, 132(%rsp)
	movl %ebx, 112(%rsp)
	movl %r15d, %ebp
.main_17:
	movl $1, %r8d
	movl 132(%rsp), %r9d
	cmpl 120(%rsp), %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_22
.main_18:
	movl 116(%rsp), %r9d
	subl $1, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r14, %r9
	addq %r8, %r9
	movq (%r9), %r15
	movl 132(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r15, %r9
	addq %r8, %r9
	movl (%r9), %r12d
	movl $1, %r8d
	movl %ebp, %r9d
	cmpl %r12d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_20
.main_19:
	movl 116(%rsp), %r9d
	subl $1, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r14, %r9
	addq %r8, %r9
	movq (%r9), %rax
	movl 132(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl %ecx, %r8d
	movl 132(%rsp), %r9d
.main_46:
	movl %ecx, %ebx
	movl %r9d, %ecx
.main_21:
	movl 132(%rsp), %r9d
	addl $1, %r9d
.main_43:
	movl %ebx, 124(%rsp)
	movq %rax, 100(%rsp)
	movl %r12d, 128(%rsp)
	movq %r15, 52(%rsp)
	movl %r9d, 132(%rsp)
	movl %ecx, 112(%rsp)
	movl %r8d, %ebp
	jmp .main_17
.main_20:
.main_45:
	movl 124(%rsp), %ebx
	movq 100(%rsp), %rax
	movl 112(%rsp), %ecx
	movl %ebp, %r8d
	jmp .main_21
.main_22:
	movl 116(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r14, %r9
	addq %r8, %r9
	movq (%r9), %r15
	movl 116(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r12
	movl 120(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl (%r9), %ebx
	movl 120(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r15, %r9
	addq %r8, %r9
	movl %ebp, (%r9)
	addl %ebx, (%r9)
	movl 116(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl 120(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl 112(%rsp), %r10d
	movl %r10d, (%r9)
	movl 120(%rsp), %eax
	addl $1, %eax
.main_41:
	movl 124(%rsp), %ecx
	movq 100(%rsp), %r12
	movl 128(%rsp), %r8d
	movq 52(%rsp), %r9
	movl %eax, 120(%rsp)
	jmp .main_15
.main_23:
	movl 116(%rsp), %eax
	addl $1, %eax
.main_39:
	movl %eax, 116(%rsp)
	jmp .main_13
.main_24:
	movl $0, %ecx
	subl $1000000000, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl $0, %r9d
.main_48:
	movl %r9d, %ebx
	movl %r8d, %r9d
	movl %ecx, %eax
.main_25:
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_30
.main_26:
	movl %esi, %r8d
	subl $1, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r14, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_28
.main_27:
	movl %esi, %r9d
	subl $1, %r9d
	imull $8, %r9d
	movslq %r9d, %r9
	movq %r14, %r8
	addq %r9, %r8
	movq (%r8), %r8
	movl %ebx, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %ecx
	movl %ecx, %r9d
	movl %ebx, %edx
.main_50:
	movl %edx, %ecx
	movl %r9d, %r8d
.main_29:
	movl %ebx, %r9d
	addl $1, %r9d
.main_47:
	movl %r9d, %ebx
	movl %ecx, %r9d
	movl %r8d, %eax
	jmp .main_25
.main_28:
.main_49:
	movl %r9d, %ecx
	movl %eax, %r8d
	jmp .main_29
.main_30:
	movl %eax, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq printint
	movq %r12, %rsi
	movq %rbx, %r9
	movl $10, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %rsi
	movq %rbx, %r9
	movl %r9d, %edi
	subl $1, %esi
	movq %r13, %rdx
	callq _c0_ppath
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $136, %rsp
	ret
.ident	"15-411 L4 reference compiler"
