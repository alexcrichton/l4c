.file	"../tests1/kestrel-ski2.l4"
.globl _c0_main
_c0_s:
	addq $-8, %rsp
.s_0:
	movq $1, %rdi
	movq $24, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $0, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq $16, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	addq $8, %rsp
	ret
_c0_k:
	addq $-8, %rsp
.k_0:
	movq $1, %rdi
	movq $24, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $1, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq $16, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	addq $8, %rsp
	ret
_c0_i:
	addq $-8, %rsp
.i_0:
	movq $1, %rdi
	movq $24, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $2, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq $16, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	addq $8, %rsp
	ret
_c0_app:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.app_0:
	movq $1, %rdi
	movq $24, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl $3, (%rcx)
	movq $8, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movq %r9, (%rcx)
	movq $16, %r9
	movq %rax, %rcx
	addq %r9, %rcx
	movq %r8, (%rcx)
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_app2:
	addq $-8, %rsp
.app2_0:
	callq _c0_app
	addq $8, %rsp
	ret
_c0_app3:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdx, %r9
.app3_0:
	movq %r9, %rbx
	callq _c0_app
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rsi
	callq _c0_app
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_app4:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rcx, %r9
.app4_0:
	movq %r9, %rbx
	callq _c0_app3
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rsi
	callq _c0_app
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_isS:
	addq $-8, %rsp
.isS_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl $0, %r8d
	movl %r9d, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_isK:
	addq $-8, %rsp
.isK_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl $1, %r8d
	movl %r9d, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_isI:
	addq $-8, %rsp
.isI_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl $2, %r8d
	movl %r9d, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_isApp:
	addq $-8, %rsp
.isApp_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl $3, %r8d
	movl %r9d, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_getE1:
	addq $-8, %rsp
.getE1_0:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rax
	addq $8, %rsp
	ret
_c0_getE2:
	addq $-8, %rsp
.getE2_0:
	movq $16, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rax
	addq $8, %rsp
	ret
_c0_eval:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %rcx
.eval_0:
	movq %rcx, %rdi
	movq %rcx, %rbx
	callq _c0_isS
	movq %rbx, %rcx
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .eval_2
.eval_1:
	movq %rcx, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_2:
	movq %rcx, %rdi
	movq %rcx, %rbx
	callq _c0_isK
	movq %rbx, %rcx
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .eval_4
.eval_3:
	movq %rcx, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_4:
	movq %rcx, %rdi
	movq %rcx, %rbx
	callq _c0_isI
	movq %rbx, %rcx
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .eval_6
.eval_5:
	movq %rcx, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_6:
	movq %rcx, %rdi
	movq %rcx, %rbx
	callq _c0_getE1
	movq %rbx, %rcx
	movq %rax, %rdi
	movq %rcx, %rbx
	callq _c0_eval
	movq %rbx, %rcx
	movq %rax, %r8
	movq %rcx, %rdi
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_getE2
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isI
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .eval_8
.eval_7:
	movq %r9, %rdi
	callq _c0_eval
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_8:
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isApp
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .eval_22
.eval_9:
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_getE1
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq %r8, %rdi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_getE2
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %rdx, %rdi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isK
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .eval_11
.eval_10:
	movq %r8, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_11:
	movq %rdx, %rdi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isApp
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .eval_17
.eval_12:
	movq %rdx, %rdi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_getE1
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rsi
	movq %rdx, %rdi
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_getE2
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq %rsi, %rdi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isS
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .eval_14
.eval_13:
	movq %rdx, %rdi
	movq %r9, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_app
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %r8, %rdi
	movq %r9, %rsi
	movq %rcx, %rbx
	callq _c0_app
	movq %rbx, %rcx
	movq %rcx, %rdi
	movq %rax, %rsi
	callq _c0_app
	movq %rax, %rdi
	callq _c0_eval
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_14:
	movq %rcx, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_17:
	movq %rcx, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.eval_22:
	movq %rcx, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_error:
	addq $-8, %rsp
.error_0:
	movl $0, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_print:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.print_0:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_isS
	movq %rbx, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .print_1
.print_10:
	movl $83, %edi
	callq printchar
.print_12:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.print_1:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_isK
	movq %rbx, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .print_2
.print_8:
	movl $75, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
.print_11:
	jmp .print_12
.print_2:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_isI
	movq %rbx, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .print_3
.print_6:
	movl $73, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
.print_9:
	jmp .print_11
.print_3:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_isApp
	movq %rbx, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .print_5
.print_4:
	movl $40, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_getE1
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rbx
	callq _c0_print
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_getE2
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rbx
	callq _c0_print
	movq %rbx, %r9
	movl $41, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
.print_7:
	jmp .print_9
.print_5:
	movq %r9, %rbx
	callq _c0_error
	movq %rbx, %r9
	jmp .print_7
_c0_println:
	addq $-8, %rsp
.println_0:
	movl $10, %edi
	callq printchar
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_assertTrue:
	addq $-8, %rsp
.assertTrue_0:
	cmpl $0, %edi
	jnz .ternary_true1
	movl $0, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_grow:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rsi, %r9
.grow_0:
	movq $0, %rcx
	cmpq %rcx, %rdi
	jz .ternary_true3
	movq %r9, %rsi
	movq %r9, %rbx
	callq _c0_app
	movq %rbx, %r9
	movq %rax, %r8
	jmp .ternary_end4
.ternary_true3:
	movq %r9, %r8
.ternary_end4:
	movq %r8, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_parseUntil:
	addq $-152, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %esi, %r15d
.parseUntil_0:
	movq %rdi, 64(%rsp)
	movq %rdx, 72(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_s
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rdx
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, 72(%rsp)
	movq %rdi, 80(%rsp)
	movq %rdx, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_k
	movq 80(%rsp), %rdi
	movq 64(%rsp), %rdx
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, 88(%rsp)
	movq %rdi, 80(%rsp)
	movq %rdx, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_i
	movq 80(%rsp), %rdi
	movq 64(%rsp), %rdx
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, %rbx
.parseUntil_33:
	movq %rdi, %r13
.parseUntil_1:
	movq %rdx, 96(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %rbp
	callq eof
	movq 96(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %esi
	movl $1, %eax
	movl $1, %edi
	xorl %esi, %edi
	cmpl %edi, %eax
	jnz .parseUntil_27
.parseUntil_2:
	movq %rdx, 96(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %rbp
	callq readchar
	movq 96(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $1, %esi
	movl $10, %eax
	movl %ebp, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .parseUntil_4
.parseUntil_3:
	movq $0, %r9
	movq %r13, %r8
	cmpq %r9, %r8
	setne %dil
	movzbl %dil, %edi
	callq _c0_assertTrue
	movl $10, %r8d
	movl %r15d, %edi
	cmpl %r8d, %edi
	sete %dil
	movzbl %dil, %edi
	callq _c0_assertTrue
	movq %r13, %rax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.parseUntil_4:
	movl $1, %eax
	movl $83, %edi
	movl %ebp, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .parseUntil_6
.parseUntil_5:
	movq 72(%rsp), %r12
	movq %r13, %rdi
	movq %r12, %rsi
	movq %rcx, 80(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_grow
	movq 80(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 64(%rsp), %r9
	movq %rax, %rdx
	movq %rdx, 104(%rsp)
	jmp .parseUntil_32
.parseUntil_6:
	movl $1, %eax
	movl $75, %edi
	movl %ebp, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .parseUntil_8
.parseUntil_7:
	movq 88(%rsp), %r10
	movq %r10, 112(%rsp)
	movq %r13, %rdi
	movq 112(%rsp), %rsi
	movq %rdx, 80(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %r14
	callq _c0_grow
	movq 80(%rsp), %rdx
	movq 64(%rsp), %r8
	movq %r14, %r9
	movq %rax, %r14
	movq %r14, %rcx
	jmp .parseUntil_31
.parseUntil_8:
	movl $1, %eax
	movl $73, %edi
	movl %ebp, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .parseUntil_10
.parseUntil_9:
	movq %rbx, 120(%rsp)
	movq %r13, %rdi
	movq 120(%rsp), %rsi
	movq %rdx, 80(%rsp)
	movq %rcx, 64(%rsp)
	callq _c0_grow
	movq 80(%rsp), %rdx
	movq 64(%rsp), %rcx
	movq %rax, %r8
	movq %r8, %r9
	jmp .parseUntil_30
.parseUntil_10:
	movl $1, %eax
	movl $40, %edi
	movl %ebp, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .parseUntil_12
.parseUntil_11:
	movq $0, %rdi
	movl $41, %esi
	movq %rdx, 128(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_parseUntil
	movq 128(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 64(%rsp), %r9
	movq %rax, 64(%rsp)
	movq 64(%rsp), %r10
	movq %r10, 80(%rsp)
	movq %r13, %rdi
	movq 80(%rsp), %rsi
	movq %rdx, 136(%rsp)
	movq %rcx, 144(%rsp)
	movq %r8, 128(%rsp)
	movq %r9, 96(%rsp)
	callq _c0_grow
	movq 136(%rsp), %rdx
	movq 144(%rsp), %rcx
	movq 128(%rsp), %r8
	movq 96(%rsp), %r9
	movq %rax, %rdi
	jmp .parseUntil_29
.parseUntil_12:
	movl $1, %eax
	movl $41, %edi
	movl %ebp, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .parseUntil_15
.parseUntil_13:
	movq $0, %r9
	movq %r13, %r8
	cmpq %r9, %r8
	setne %dil
	movzbl %dil, %edi
	callq _c0_assertTrue
	movl $41, %r9d
	movl %r15d, %edi
	cmpl %r9d, %edi
	sete %dil
	movzbl %dil, %edi
	callq _c0_assertTrue
	movq %r13, %rax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.parseUntil_15:
.parseUntil_17:
.parseUntil_19:
.parseUntil_21:
.parseUntil_23:
.parseUntil_25:
.parseUntil_26:
.parseUntil_28:
	jmp .parseUntil_1
.parseUntil_27:
	movq $0, %r8
	movq %r13, %r9
	cmpq %r8, %r9
	setne %dil
	movzbl %dil, %edi
	callq _c0_assertTrue
	movq %r13, %rax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.parseUntil_29:
	movq %rdi, %r13
	jmp .parseUntil_1
.parseUntil_30:
	movq %r9, %r13
	jmp .parseUntil_1
.parseUntil_31:
	movq %rcx, %r13
	jmp .parseUntil_1
.parseUntil_32:
	movq 104(%rsp), %r13
	jmp .parseUntil_1
_c0_parseLine:
	addq $-8, %rsp
.parseLine_0:
	movq $0, %rdi
	movl $10, %esi
	callq _c0_parseUntil
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_parseLine
	movq %rax, %r9
	movq %r9, %rdi
	callq _c0_print
	callq _c0_println
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
