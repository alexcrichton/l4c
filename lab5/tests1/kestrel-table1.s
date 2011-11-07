.file	"../tests1/kestrel-table1.l4"
.globl _c0_main
_c0_arraycopy:
	addq $-8, %rsp
	movl %edi, %r9d
	movq %rsi, %r8
	movq %rdx, %rax
.arraycopy_0:
	movl $0, %ecx
.arraycopy_5:
	movl %ecx, %edi
.arraycopy_1:
	movl $1, %edx
	movl %edi, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .arraycopy_3
.arraycopy_2:
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.arraycopy_4:
	movl %ecx, %edi
	jmp .arraycopy_1
.arraycopy_3:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_size:
	addq $-8, %rsp
.size_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_get:
	addq $-8, %rsp
.get_0:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_set:
	addq $-8, %rsp
	movl %esi, %r8d
	movl %edx, %esi
.set_0:
	movl $0, %ecx
	cmpl %r8d, %ecx
	jle .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .set_2
.set_1:
	movq $8, %rcx
	movq %rdi, %r9
	addq %rcx, %r9
	movq (%r9), %rcx
	movl %r8d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl %esi, (%r9)
	movl $1, %eax
	addq $8, %rsp
	ret
.set_2:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_makeTable:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movq %rsi, %rdx
.makeTable_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %rdx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rdx
	movq %rbx, %r9
	movq %rax, %r8
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl %r9d, %edi
	movq %rdx, %rsi
	movq %rcx, %rdx
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_arraycopy
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %r8, %rsi
	addq %rdx, %rsi
	movl %r9d, (%rsi)
	movq $8, %r9
	movq %r8, %rdx
	addq %r9, %rdx
	movq %rcx, (%rdx)
	movq %r8, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $42, (%r9)
	movl $1, %edi
	movq %rax, %rsi
	callq _c0_makeTable
	movq %rax, %r9
	movq %r9, %rdi
	movl $0, %esi
	callq _c0_get
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
