.file	"../tests1/kestrel-table3.l4"
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
_c0_mark_failure:
	addq $-8, %rsp
.mark_failure_0:
	movq $16, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl %esi, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_mark_failed:
	addq $-8, %rsp
.mark_failed_0:
	movl $1, %esi
	callq _c0_mark_failure
	addq $8, %rsp
	ret
_c0_mark_succeeded:
	addq $-8, %rsp
.mark_succeeded_0:
	movl $0, %esi
	callq _c0_mark_failure
	addq $8, %rsp
	ret
_c0_failed:
	addq $-8, %rsp
.failed_0:
	movq $16, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %r9d
	movl %r9d, %eax
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
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.get_0:
	movl $0, %ecx
	cmpl %esi, %ecx
	jle .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %esi, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .get_2
.get_1:
	movq %r9, %rdi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_mark_succeeded
	movq %r12, %rsi
	movq %rbx, %r9
	movq $8, %rcx
	addq %rcx, %r9
	movq (%r9), %rcx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.get_2:
	movq %r9, %rdi
	callq _c0_mark_failed
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_set:
	addq $-8, %rsp
	movl %esi, %r8d
	movl %edx, %esi
.set_0:
	movl $0, %ecx
	cmpl %r8d, %ecx
	jle .ternary_true3
	movl $0, %edx
	jmp .ternary_end4
.ternary_true3:
	movq $0, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
.ternary_end4:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .set_2
.set_1:
	movq $8, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl %esi, (%r8)
	callq _c0_mark_succeeded
	movl $0, %eax
	addq $8, %rsp
	ret
.set_2:
	callq _c0_mark_failed
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
	movq $24, %rsi
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
	movq $0, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl %r9d, (%rdx)
	movq $8, %r9
	movq %r8, %rdx
	addq %r9, %rdx
	movq %rcx, (%rdx)
	movq $16, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r9)
	movq %r8, %rdi
	movq %r8, %rbx
	callq _c0_mark_succeeded
	movq %rbx, %r8
	movq %r8, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_assertTrue:
	addq $-8, %rsp
.assertTrue_0:
	cmpl $0, %edi
	jnz .ternary_true5
	movl $0, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $0, %r9d
.ternary_end6:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_assertFalse:
	addq $-8, %rsp
.assertFalse_0:
	movl $1, %r8d
	xorl %edi, %r8d
	movl %r8d, %edi
	callq _c0_assertTrue
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $1111, (%r8)
	movl $1, %edi
	movq %rax, %rsi
	callq _c0_makeTable
	movq %rax, %r9
	movq %r9, %rdi
	movl $9001, %esi
	movl $1337, %edx
	movq %r9, %rbx
	callq _c0_set
	movq %rbx, %r9
	movq %r9, %rdi
	callq _c0_failed
	movl %eax, %edi
	callq _c0_assertFalse
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
