.file	"../tests2/stegosaurus-heap.l4"
.globl _c0_main
_c0_heapify:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.heapify_0:
.heapify_8:
	movl %edx, %ebx
.heapify_1:
	movl $1, %esi
	movl $2, %edx
	imull %ebx, %edx
	addl $1, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .heapify_3
.heapify_2:
	movl $2, %edx
	imull %ebx, %edx
	addl $2, %edx
	cmpl %r8d, %edx
	jl .ternary_true3
	movl $0, %esi
	jmp .ternary_end4
.ternary_true3:
	movl $2, %edx
	imull %ebx, %edx
	addl $1, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %esi
	movl $2, %edx
	imull %ebx, %edx
	addl $2, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	cmpl %edx, %esi
	setl %sil
	movzbl %sil, %esi
.ternary_end4:
	cmpl $0, %esi
	jnz .ternary_true1
	movl $2, %edx
	imull %ebx, %edx
	addl $1, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $2, %edx
	imull %ebx, %edx
	addl $2, %edx
.ternary_end2:
	movl %edx, %eax
	movl %eax, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edi
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl %edi, (%rdx)
	movl %eax, %edx
.heapify_7:
	movl %edx, %ebx
	jmp .heapify_1
.heapify_3:
.heapify_10:
	movl %ebx, %esi
.heapify_4:
	movl $0, %edx
	cmpl %esi, %edx
	jl .ternary_true5
	movl $0, %edi
	jmp .ternary_end6
.ternary_true5:
	movl %esi, %eax
	subl $1, %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	cmpl %ecx, %edi
	setl %dil
	movzbl %dil, %edi
.ternary_end6:
	movl $1, %edx
	cmpl %edi, %edx
	jnz .heapify_6
.heapify_5:
	movl %esi, %eax
	subl $1, %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edi
	movl %esi, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movl %edi, (%rsi)
	movl %eax, %edx
.heapify_9:
	movl %edx, %esi
	jmp .heapify_4
.heapify_6:
	movl %esi, %edx
	imull $4, %edx
	movslq %edx, %rdx
	addq %rdx, %r9
	movl %ecx, (%r9)
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_order:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.order_0:
	movl %r8d, %ecx
	subl $1, %ecx
.order_8:
	movl %ecx, %ebx
.order_1:
	movl $1, %ecx
	movl $0, %edx
	cmpl %ebx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .order_6
.order_2:
	movl $2, %ecx
	imull %ebx, %ecx
	addl $1, %ecx
	cmpl %r8d, %ecx
	jl .ternary_true7
	movl $0, %edx
	jmp .ternary_end8
.ternary_true7:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $2, %ecx
	imull %ebx, %ecx
	addl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	cmpl %ecx, %esi
	jl .ternary_true9
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $2, %ecx
	imull %ebx, %ecx
	addl $2, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edx
	movl %esi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end10
.ternary_true9:
	movl $1, %ecx
.ternary_end10:
	movl %ecx, %edx
.ternary_end8:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .order_4
.order_3:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %r12d
	movq %r9, %rdi
	movl %r8d, %esi
	movl %ebx, %edx
	movl %r12d, %ecx
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_heapify
	movq %r14, %r8
	movq %r13, %r9
	movslq %eax, %rdx
.order_10:
.order_5:
	movl %ebx, %ecx
	subl $1, %ecx
.order_7:
	movl %ecx, %ebx
	jmp .order_1
.order_4:
.order_9:
	jmp .order_5
.order_6:
	movl %r8d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_push:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %esi, %r9d
	movl %edx, %esi
.push_0:
	movl %r9d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movl %r9d, %esi
	addl $1, %esi
	movq %r9, %rbx
	callq _c0_order
	movq %rbx, %r9
	movl %r9d, %eax
	addl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_heapsort:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.heapsort_0:
	movl %r8d, %ecx
.heapsort_5:
	movl %ecx, %edx
.heapsort_1:
	movl $1, %esi
	movl $0, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .heapsort_3
.heapsort_2:
	movl %edx, %ebx
	subl $1, %ebx
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movl (%rdx), %esi
	movl %ebx, %ecx
	addl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movq %r9, %rdi
	movl %ebx, %esi
	movl $0, %edx
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_heapify
	movq %r13, %r8
	movq %r12, %r9
.heapsort_4:
	movl %ebx, %edx
	jmp .heapsort_1
.heapsort_3:
	movl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $14000, %r9d
	movl %r9d, %r8d
	addl $1, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %edx
	movl $0, %ecx
.main_12:
.main_1:
	movl $1, %edi
	movl %ecx, %esi
	cmpl %r9d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_3
.main_2:
	movq %r8, %rdi
	movl %edx, %esi
	movl %r9d, %eax
	subl %edx, %eax
	movl %eax, %edx
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_push
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	addl $1, %ecx
.main_11:
	jmp .main_1
.main_3:
	movq %r8, %rdi
	movl %edx, %esi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_order
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl %edx, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_heapsort
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
.main_14:
	movl %ecx, %esi
.main_4:
	movl $1, %edx
	movl %esi, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_10
.main_5:
	movl %esi, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl (%rdx), %edx
	movl $1, %ecx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_8
.main_6:
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_8:
.main_9:
	movl %esi, %ecx
	addl $1, %ecx
.main_13:
	movl %ecx, %esi
	jmp .main_4
.main_10:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
