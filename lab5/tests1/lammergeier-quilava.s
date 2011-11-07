.file	"../tests1/lammergeier-quilava.l3"
.globl _c0_main
_c0_power:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.power_0:
	movl $1, %r8d
	movl $0, %edx
	movl %esi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .power_3
.power_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.power_3:
.power_4:
	movl $1, %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .power_7
.power_5:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.power_7:
.power_8:
	movl %r9d, %edi
	subl $1, %esi
	movq %r9, %rbx
	callq _c0_power
	movq %rbx, %r9
	imull %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_push:
	addq $-8, %rsp
.push_0:
	movl $9, %r8d
	cmpl %edi, %r8d
	jl .ternary_true1
	movl $1, %r8d
	movl %edi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .push_3
.push_1:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.push_3:
.push_4:
	movl %esi, %r8d
	imull $10, %r8d
	movl %r8d, %eax
	addl %edi, %eax
	addq $8, %rsp
	ret
_c0_pop:
	addq $-8, %rsp
	movl %edi, %eax
.pop_0:
	movl $10, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_stackEmpty:
	addq $-8, %rsp
.stackEmpty_0:
	movl $0, %r8d
	movl %edi, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_len:
	addq $-8, %rsp
.len_0:
	movl %edi, %r8d
	movl $0, %r9d
.len_5:
.len_1:
	movl $10, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .len_3
.len_2:
	addl $1, %r9d
	movl $10, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %eax, %r8d
.len_4:
	jmp .len_1
.len_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_head:
	addq $-8, %rsp
	movl %edi, %eax
.head_0:
	movl $10, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_getIndex:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.getIndex_0:
	movl $10, %edi
	movq %r9, %rbx
	callq _c0_power
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $10, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_max:
	addq $-8, %rsp
.max_0:
	movl $0, %r8d
	movl %edi, %r9d
.max_8:
.max_1:
	movl $10, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %edx
	movl $0, %esi
	cmpl %esi, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .max_6
.max_2:
	movl $10, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %esi
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .max_4
.max_3:
	movl %esi, %r8d
.max_10:
	movl %r8d, %ecx
.max_5:
	movl $10, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r9d
.max_7:
	movl %ecx, %r8d
	jmp .max_1
.max_4:
.max_9:
	movl %r8d, %ecx
	jmp .max_5
.max_6:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_printTower:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.printTower_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_len
	movq %rbx, %r9
	movl %eax, %r8d
	movl $91, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %ecx
.printTower_8:
.printTower_1:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .printTower_6
.printTower_2:
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_getIndex
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl %r8d, %esi
	subl $1, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .printTower_4
.printTower_3:
	movl $44, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movslq %eax, %rdx
.printTower_10:
.printTower_5:
	addl $1, %ecx
.printTower_7:
	jmp .printTower_1
.printTower_4:
.printTower_9:
	jmp .printTower_5
.printTower_6:
	movl $93, %edi
	callq printchar
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_printDisc:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.printDisc_0:
	movl $0, %ecx
.printDisc_20:
.printDisc_1:
	movl $1, %edx
	movl %ecx, %esi
	cmpl %r8d, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .printDisc_3
.printDisc_2:
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %ecx
.printDisc_19:
	jmp .printDisc_1
.printDisc_3:
	movl $0, %ecx
.printDisc_22:
.printDisc_4:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .printDisc_6
.printDisc_5:
	movl $45, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %ecx
.printDisc_21:
	jmp .printDisc_4
.printDisc_6:
	movl $10, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %ecx
.printDisc_24:
.printDisc_7:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .printDisc_9
.printDisc_8:
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %ecx
.printDisc_23:
	jmp .printDisc_7
.printDisc_9:
	movl $124, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %ecx
.printDisc_26:
.printDisc_10:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .printDisc_12
.printDisc_11:
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %ecx
.printDisc_25:
	jmp .printDisc_10
.printDisc_12:
	movl $124, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $10, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %ecx
.printDisc_28:
.printDisc_13:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .printDisc_15
.printDisc_14:
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %ecx
.printDisc_27:
	jmp .printDisc_13
.printDisc_15:
	movl $0, %r8d
.printDisc_30:
.printDisc_16:
	movl $1, %ecx
	movl %r8d, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .printDisc_18
.printDisc_17:
	movl $45, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.printDisc_29:
	jmp .printDisc_16
.printDisc_18:
	movl $10, %edi
	callq printchar
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_printDiscs:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.printDiscs_0:
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_max
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_len
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $0, %esi
.printDiscs_5:
	movl %esi, %ebx
.printDiscs_1:
	movl $1, %edi
	movl %ebx, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .printDiscs_3
.printDiscs_2:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_getIndex
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl $2, %edi
	imull %esi, %edi
	movl %edx, %esi
	subl %ebx, %esi
	addl %r8d, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_printDisc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %ebx, %esi
	addl $1, %esi
.printDiscs_4:
	movl %esi, %ebx
	jmp .printDiscs_1
.printDiscs_3:
	movl $1, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_printTowers:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %edx, %ecx
.printTowers_0:
	movl $65, %edi
	movq %rsi, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rsi
	movq %r12, %rcx
	movq %rbx, %r9
	movl $32, %edi
	movq %rsi, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rsi
	movq %r12, %rcx
	movq %rbx, %r9
	movl %r9d, %edi
	movq %rsi, %r12
	movq %rcx, %rbx
	callq _c0_printTower
	movq %r12, %rsi
	movq %rbx, %rcx
	movl $10, %edi
	movq %rsi, %r12
	movq %rcx, %rbx
	callq printchar
	movq %r12, %rsi
	movq %rbx, %rcx
	movl $66, %edi
	movq %rsi, %r12
	movq %rcx, %rbx
	callq printchar
	movq %r12, %rsi
	movq %rbx, %rcx
	movl $32, %edi
	movq %rsi, %r12
	movq %rcx, %rbx
	callq printchar
	movq %r12, %rsi
	movq %rbx, %rcx
	movl %esi, %edi
	movq %rcx, %rbx
	callq _c0_printTower
	movq %rbx, %rcx
	movl $10, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movl $67, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movl $32, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movl %ecx, %edi
	callq _c0_printTower
	movl $10, %edi
	callq printchar
	movl $10, %edi
	callq printchar
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_solved:
	addq $-8, %rsp
.solved_0:
	movl $0, %ecx
	cmpl %ecx, %edi
	jz .ternary_true3
	movl $0, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $0, %r9d
	movl %esi, %ecx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
.ternary_end4:
	movl %ecx, %eax
	addq $8, %rsp
	ret
_c0_legalMove:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.legalMove_0:
	movq %rsi, %rbx
	callq _c0_head
	movq %rbx, %rsi
	movl %eax, %r8d
	movl %esi, %edi
	movq %r8, %rbx
	callq _c0_head
	movq %rbx, %r8
	movl %eax, %edx
	movl $0, %r9d
	cmpl %r9d, %r8d
	jnz .ternary_true5
	movl $0, %ecx
	jmp .ternary_end6
.ternary_true5:
	movl $0, %r9d
	movl %edx, %ecx
	cmpl %r9d, %ecx
	setne %cl
	movzbl %cl, %ecx
.ternary_end6:
	movl $1, %r9d
	cmpl %ecx, %r9d
	jnz .legalMove_3
.legalMove_1:
	movl %r8d, %eax
	cmpl %edx, %eax
	setl %al
	movzbl %al, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.legalMove_3:
.legalMove_4:
	movl $0, %ecx
	movl %r8d, %eax
	cmpl %ecx, %eax
	setne %al
	movzbl %al, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_solveEven:
	addq $-1160, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.solveEven_0:
	movl %edi, %ebp
	movl %esi, 688(%rsp)
	movl %edx, 692(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq printint
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movl $10, %edi
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq printchar
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movl %ebp, %edi
	movl 688(%rsp), %esi
	movl 692(%rsp), %edx
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_printTowers
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
.solveEven_31:
	movl 692(%rsp), %r10d
	movl %r10d, 696(%rsp)
	movl 688(%rsp), %r10d
	movl %r10d, 700(%rsp)
	movl %ebp, 704(%rsp)
.solveEven_1:
	movl 704(%rsp), %edi
	movl 700(%rsp), %esi
	movl 696(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_solved
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl $1, %esi
	movl $1, %edi
	xorl %eax, %edi
	cmpl %edi, %esi
	jnz .solveEven_46
.solveEven_2:
	movl 704(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 708(%rsp)
	movl $0, %edx
	cmpl %edx, 708(%rsp)
	jnz .ternary_true7
	movl 700(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 712(%rsp)
	movl $0, %edx
	movl 712(%rsp), %r10d
	movl %r10d, 716(%rsp)
	cmpl %edx, 716(%rsp)
	setne %r11b
	movzbl %r11b, %r11d
	movl %r11d, 716(%rsp)
	jmp .ternary_end8
.ternary_true7:
	movl $1, 716(%rsp)
.ternary_end8:
	movl $1, %edx
	cmpl 716(%rsp), %edx
	jnz .solveEven_7
.solveEven_3:
	movl 704(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 720(%rsp)
	movl 720(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl 700(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 728(%rsp)
	movl 728(%rsp), %r10d
	movl %r10d, 732(%rsp)
	movl 704(%rsp), %edi
	movl 700(%rsp), %esi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_legalMove
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 736(%rsp)
	movl $1, %edx
	cmpl 736(%rsp), %edx
	jnz .solveEven_5
.solveEven_4:
	movl $65, %edi
	movq %rcx, 96(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq printchar
	movq 96(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %ebp
	movslq %ebp, %rbp
	movq %rbp, 88(%rsp)
	movl $2, %edi
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, %r15
	callq printint
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq %r15, %r9
	movl %eax, 692(%rsp)
	movl 692(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl $66, %edi
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, %r15
	callq printchar
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq %r15, %r9
	movl %eax, 740(%rsp)
	movl 740(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 112(%rsp)
	movl $10, %edi
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, %r15
	callq printchar
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq %r15, %r9
	movl %eax, %r15d
	movslq %r15d, %r15
	movq %r15, 120(%rsp)
	movl 704(%rsp), %edi
	movq %rcx, 128(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 96(%rsp)
	callq _c0_head
	movq 128(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 96(%rsp), %r9
	movl %eax, 744(%rsp)
	movl 744(%rsp), %r10d
	movl %r10d, 748(%rsp)
	movl 704(%rsp), %edi
	movq %rcx, 136(%rsp)
	movq %r8, 128(%rsp)
	movq %r9, 104(%rsp)
	callq _c0_pop
	movq 136(%rsp), %rcx
	movq 128(%rsp), %r8
	movq 104(%rsp), %r9
	movl %eax, 752(%rsp)
	movl 752(%rsp), %edx
	movl 748(%rsp), %edi
	movl 700(%rsp), %esi
	movq %rdx, 144(%rsp)
	movq %rcx, 152(%rsp)
	movq %r8, 136(%rsp)
	movq %r9, 128(%rsp)
	callq _c0_push
	movq 144(%rsp), %rdx
	movq 152(%rsp), %rcx
	movq 136(%rsp), %r8
	movq 128(%rsp), %r9
	movl %eax, %esi
.solveEven_33:
	movl %eax, 756(%rsp)
	movl 752(%rsp), %r10d
	movl %r10d, 760(%rsp)
	movl 744(%rsp), %r10d
	movl %r10d, 752(%rsp)
	movl %r15d, 744(%rsp)
	movq 120(%rsp), %r15
	movl 740(%rsp), %r10d
	movl %r10d, 764(%rsp)
	movq 112(%rsp), %r10
	movq %r10, 160(%rsp)
	movl 692(%rsp), %r10d
	movl %r10d, 768(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 168(%rsp)
	movl %ebp, 772(%rsp)
	movq 88(%rsp), %r10
	movq %r10, 176(%rsp)
	movl %esi, %edi
	movl %edx, %esi
	movl 748(%rsp), %edx
.solveEven_6:
.solveEven_35:
	movl 776(%rsp), %r10d
	movl %r10d, 780(%rsp)
	movl 784(%rsp), %r10d
	movl %r10d, 788(%rsp)
	movl 792(%rsp), %r10d
	movl %r10d, 796(%rsp)
	movl 800(%rsp), %r10d
	movl %r10d, 804(%rsp)
	movq 184(%rsp), %r10
	movq %r10, 192(%rsp)
	movl 808(%rsp), %r10d
	movl %r10d, 812(%rsp)
	movq 200(%rsp), %r10
	movq %r10, 208(%rsp)
	movl 816(%rsp), %r10d
	movl %r10d, 820(%rsp)
	movq 216(%rsp), %r10
	movq %r10, 224(%rsp)
	movl 824(%rsp), %r10d
	movl %r10d, 828(%rsp)
	movq 232(%rsp), %r10
	movq %r10, 240(%rsp)
	movl 756(%rsp), %r10d
	movl %r10d, 832(%rsp)
	movl 760(%rsp), %r10d
	movl %r10d, 836(%rsp)
	movl 752(%rsp), %r10d
	movl %r10d, 840(%rsp)
	movl 744(%rsp), %r10d
	movl %r10d, 844(%rsp)
	movq %r15, 248(%rsp)
	movl 764(%rsp), %r10d
	movl %r10d, 848(%rsp)
	movq 160(%rsp), %r10
	movq %r10, 256(%rsp)
	movl 768(%rsp), %r10d
	movl %r10d, 852(%rsp)
	movq 168(%rsp), %r10
	movq %r10, 264(%rsp)
	movl 772(%rsp), %r10d
	movl %r10d, 856(%rsp)
	movq 176(%rsp), %r10
	movq %r10, 272(%rsp)
	movl 736(%rsp), %r10d
	movl %r10d, 860(%rsp)
	movl 728(%rsp), %r10d
	movl %r10d, 864(%rsp)
	movl 732(%rsp), %r10d
	movl %r10d, 748(%rsp)
	movl 720(%rsp), %r10d
	movl %r10d, 868(%rsp)
	movl 724(%rsp), %r10d
	movl %r10d, 872(%rsp)
	movl %edi, 876(%rsp)
	movl %esi, 880(%rsp)
	movl %edx, 740(%rsp)
.solveEven_8:
	movl 880(%rsp), %edi
	movl 876(%rsp), %esi
	movl 696(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_printTowers
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 884(%rsp)
	movl 884(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 280(%rsp)
	movl $10, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 888(%rsp)
	movl 888(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 288(%rsp)
	movl 880(%rsp), %edi
	movl 876(%rsp), %esi
	movl 696(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_solved
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 892(%rsp)
	movl $1, %edx
	cmpl 892(%rsp), %edx
	jnz .solveEven_11
.solveEven_9:
	jmp .solveEven_44
.solveEven_11:
.solveEven_12:
	movl 880(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 896(%rsp)
	movl $0, %edx
	cmpl %edx, 896(%rsp)
	jnz .ternary_true9
	movl 696(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 900(%rsp)
	movl $0, %edx
	movl 900(%rsp), %r10d
	movl %r10d, 904(%rsp)
	cmpl %edx, 904(%rsp)
	setne %r11b
	movzbl %r11b, %r11d
	movl %r11d, 904(%rsp)
	jmp .ternary_end10
.ternary_true9:
	movl $1, 904(%rsp)
.ternary_end10:
	movl $1, %edx
	cmpl 904(%rsp), %edx
	jnz .solveEven_17
.solveEven_13:
	movl 880(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 908(%rsp)
	movl 908(%rsp), %r10d
	movl %r10d, 912(%rsp)
	movl 696(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 916(%rsp)
	movl 916(%rsp), %r10d
	movl %r10d, 920(%rsp)
	movl 880(%rsp), %edi
	movl 696(%rsp), %esi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_legalMove
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 924(%rsp)
	movl $1, %edx
	cmpl 924(%rsp), %edx
	jnz .solveEven_15
.solveEven_14:
	movl $65, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, 688(%rsp)
	movl 688(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 80(%rsp)
	movl $2, %edi
	movq %rcx, 296(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq printint
	movq 296(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, %edx
	movslq %edx, %rdx
	movq %rdx, 304(%rsp)
	movl $67, %edi
	movq %rdx, 72(%rsp)
	movq %rcx, 296(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq printchar
	movq 72(%rsp), %rdx
	movq 296(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, 928(%rsp)
	movl 928(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 312(%rsp)
	movl $10, %edi
	movq %rdx, 72(%rsp)
	movq %rcx, 296(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq printchar
	movq 72(%rsp), %rdx
	movq 296(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, 932(%rsp)
	movl 932(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 320(%rsp)
	movl 880(%rsp), %edi
	movq %rdx, 72(%rsp)
	movq %rcx, 296(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_head
	movq 72(%rsp), %rdx
	movq 296(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, 936(%rsp)
	movl 936(%rsp), %r10d
	movl %r10d, 940(%rsp)
	movl 880(%rsp), %edi
	movq %rdx, 328(%rsp)
	movq %rcx, 336(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_pop
	movq 328(%rsp), %rdx
	movq 336(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, %r13d
	movl %r13d, %ebp
	movl 940(%rsp), %edi
	movl 696(%rsp), %esi
	movq %rdx, 344(%rsp)
	movq %rcx, 352(%rsp)
	movq %r8, 328(%rsp)
	movq %r9, 336(%rsp)
	callq _c0_push
	movq 344(%rsp), %rdx
	movq 352(%rsp), %rcx
	movq 328(%rsp), %r8
	movq 336(%rsp), %r9
	movl %eax, %esi
.solveEven_37:
	movl %eax, 944(%rsp)
	movl %r13d, 948(%rsp)
	movl 936(%rsp), %r10d
	movl %r10d, 952(%rsp)
	movl 932(%rsp), %r10d
	movl %r10d, 956(%rsp)
	movq 320(%rsp), %r10
	movq %r10, 360(%rsp)
	movl 928(%rsp), %r10d
	movl %r10d, 960(%rsp)
	movq 312(%rsp), %r10
	movq %r10, 352(%rsp)
	movl %edx, 964(%rsp)
	movq 304(%rsp), %r10
	movq %r10, 312(%rsp)
	movl 688(%rsp), %r10d
	movl %r10d, 928(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 320(%rsp)
	movl %esi, %edi
	movl %ebp, %esi
	movl 940(%rsp), %edx
.solveEven_16:
.solveEven_39:
	movl %r14d, 936(%rsp)
	movl 968(%rsp), %r10d
	movl %r10d, 972(%rsp)
	movl 976(%rsp), %r10d
	movl %r10d, 980(%rsp)
	movl 984(%rsp), %r10d
	movl %r10d, 988(%rsp)
	movq 368(%rsp), %r10
	movq %r10, 376(%rsp)
	movl 992(%rsp), %r10d
	movl %r10d, 996(%rsp)
	movq 384(%rsp), %r10
	movq %r10, 392(%rsp)
	movl 1000(%rsp), %r10d
	movl %r10d, 1004(%rsp)
	movq 400(%rsp), %r10
	movq %r10, 408(%rsp)
	movl 1008(%rsp), %r10d
	movl %r10d, 1012(%rsp)
	movq 416(%rsp), %r10
	movq %r10, 424(%rsp)
	movl 944(%rsp), %r10d
	movl %r10d, 1016(%rsp)
	movl 948(%rsp), %r10d
	movl %r10d, 1020(%rsp)
	movl 952(%rsp), %r10d
	movl %r10d, 1024(%rsp)
	movl 956(%rsp), %r10d
	movl %r10d, 1028(%rsp)
	movq 360(%rsp), %r10
	movq %r10, 432(%rsp)
	movl 960(%rsp), %r10d
	movl %r10d, 1032(%rsp)
	movq 352(%rsp), %r10
	movq %r10, 440(%rsp)
	movl 964(%rsp), %r10d
	movl %r10d, 1036(%rsp)
	movq 312(%rsp), %r10
	movq %r10, 328(%rsp)
	movl 928(%rsp), %r10d
	movl %r10d, 932(%rsp)
	movq 320(%rsp), %r10
	movq %r10, 304(%rsp)
	movl 924(%rsp), %r13d
	movl 916(%rsp), %r10d
	movl %r10d, 1040(%rsp)
	movl 920(%rsp), %r10d
	movl %r10d, 1044(%rsp)
	movl 908(%rsp), %r10d
	movl %r10d, 1048(%rsp)
	movl 912(%rsp), %r10d
	movl %r10d, 1052(%rsp)
	movl %edi, 1056(%rsp)
	movl %esi, 1060(%rsp)
	movl %edx, 1064(%rsp)
.solveEven_18:
	movl 1060(%rsp), %edi
	movl 876(%rsp), %esi
	movl 1056(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_printTowers
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movslq %ebp, %rbp
	movq %rbp, 88(%rsp)
	movl $10, %edi
	movq %rcx, 448(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq printchar
	movq 448(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 692(%rsp)
	movl 692(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl 1060(%rsp), %edi
	movl 876(%rsp), %esi
	movl 1056(%rsp), %edx
	movq %rcx, 456(%rsp)
	movq %r8, 464(%rsp)
	movq %r9, 448(%rsp)
	callq _c0_solved
	movq 456(%rsp), %rcx
	movq 464(%rsp), %r8
	movq 448(%rsp), %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .solveEven_21
.solveEven_19:
	jmp .solveEven_45
.solveEven_21:
.solveEven_22:
	movl 876(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl $0, %edx
	cmpl %edx, %eax
	jnz .ternary_true11
	movl 1056(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	jmp .ternary_end12
.ternary_true11:
	movl $1, %edx
.ternary_end12:
	movl $1, %esi
	cmpl %edx, %esi
	jnz .solveEven_27
.solveEven_23:
	movl 876(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1068(%rsp)
	movl 1068(%rsp), %r10d
	movl %r10d, 1072(%rsp)
	movl 1056(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1076(%rsp)
	movl 1076(%rsp), %r10d
	movl %r10d, 1080(%rsp)
	movl 876(%rsp), %edi
	movl 1056(%rsp), %esi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_legalMove
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1084(%rsp)
	movl $1, %edx
	cmpl 1084(%rsp), %edx
	jnz .solveEven_25
.solveEven_24:
	movl $66, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r12
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r12, %r9
	movl %eax, %edx
	movslq %edx, %rbp
	movl $2, %edi
	movq %rdx, 72(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r12
	callq printint
	movq 72(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r12, %r9
	movl %eax, 688(%rsp)
	movl 688(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 80(%rsp)
	movl $67, %edi
	movq %rdx, 472(%rsp)
	movq %rcx, 480(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, %r12
	callq printchar
	movq 472(%rsp), %rdx
	movq 480(%rsp), %rcx
	movq 72(%rsp), %r8
	movq %r12, %r9
	movl %eax, %r12d
	movslq %r12d, %r12
	movq %r12, 72(%rsp)
	movl $10, %edi
	movq %rdx, 64(%rsp)
	movq %rcx, 488(%rsp)
	movq %r8, 472(%rsp)
	movq %r9, 480(%rsp)
	callq printchar
	movq 64(%rsp), %rdx
	movq 488(%rsp), %rcx
	movq 472(%rsp), %r8
	movq 480(%rsp), %r9
	movl %eax, 1088(%rsp)
	movl 1088(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 472(%rsp)
	movl 876(%rsp), %edi
	movq %rdx, 496(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 488(%rsp)
	callq _c0_head
	movq 496(%rsp), %rdx
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 488(%rsp), %r9
	movl %eax, 1092(%rsp)
	movl 1092(%rsp), %r10d
	movl %r10d, 696(%rsp)
	movl 876(%rsp), %edi
	movq %rdx, 504(%rsp)
	movq %rcx, 512(%rsp)
	movq %r8, 496(%rsp)
	movq %r9, 56(%rsp)
	callq _c0_pop
	movq 504(%rsp), %rdx
	movq 512(%rsp), %rcx
	movq 496(%rsp), %r8
	movq 56(%rsp), %r9
	movl %eax, 700(%rsp)
	movl 700(%rsp), %r10d
	movl %r10d, 704(%rsp)
	movl 696(%rsp), %edi
	movl 1056(%rsp), %esi
	movq %rdx, 520(%rsp)
	movq %rcx, 528(%rsp)
	movq %r8, 504(%rsp)
	movq %r9, 512(%rsp)
	callq _c0_push
	movq 520(%rsp), %rdx
	movq 528(%rsp), %rcx
	movq 504(%rsp), %r8
	movq 512(%rsp), %r9
	movl %eax, %edi
.solveEven_41:
	movl %eax, 1096(%rsp)
	movl 700(%rsp), %r10d
	movl %r10d, 1100(%rsp)
	movl 1092(%rsp), %r10d
	movl %r10d, 1104(%rsp)
	movl 1088(%rsp), %r10d
	movl %r10d, 1092(%rsp)
	movl %r12d, 1088(%rsp)
	movq 72(%rsp), %r12
	movl 688(%rsp), %r10d
	movl %r10d, 1108(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 536(%rsp)
	movl %edx, 1112(%rsp)
	movq %rbp, 520(%rsp)
	movl %edi, %edx
	movl 704(%rsp), %eax
	movl 696(%rsp), %edi
.solveEven_26:
.solveEven_43:
	movl %edx, %esi
	movl %eax, %edx
.solveEven_28:
.solveEven_30:
	movl %esi, 696(%rsp)
	movl %edx, 700(%rsp)
	movl 1060(%rsp), %r10d
	movl %r10d, 704(%rsp)
	jmp .solveEven_1
.solveEven_25:
	movl $67, %edi
	callq printchar
	movl %eax, %r9d
	movslq %r9d, %rdx
	movl $2, %edi
	movq %rdx, %rbp
	movq %r9, %rbx
	callq printint
	movq %rbp, %rdx
	movq %rbx, %r9
	movl %eax, %r8d
	movslq %r8d, %rbp
	movl $66, %edi
	movq %rdx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbx
	callq printchar
	movq 80(%rsp), %rdx
	movq 88(%rsp), %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movslq %ecx, %rcx
	movq %rcx, 88(%rsp)
	movl $10, %edi
	movq %rdx, 544(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, %rbx
	callq printchar
	movq 544(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movslq %ebx, %rbx
	movq %rbx, 80(%rsp)
	movl 1056(%rsp), %edi
	movq %rdx, 552(%rsp)
	movq %rcx, 560(%rsp)
	movq %r8, 544(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_head
	movq 552(%rsp), %rdx
	movq 560(%rsp), %rcx
	movq 544(%rsp), %r8
	movq 72(%rsp), %r9
	movl %eax, 1116(%rsp)
	movl 1116(%rsp), %r10d
	movl %r10d, 940(%rsp)
	movl 1056(%rsp), %edi
	movq %rdx, 568(%rsp)
	movq %rcx, 576(%rsp)
	movq %r8, 552(%rsp)
	movq %r9, 560(%rsp)
	callq _c0_pop
	movq 568(%rsp), %rdx
	movq 576(%rsp), %rcx
	movq 552(%rsp), %r8
	movq 560(%rsp), %r9
	movl %eax, 1120(%rsp)
	movl 1120(%rsp), %r10d
	movl %r10d, 1124(%rsp)
	movl 940(%rsp), %edi
	movl 876(%rsp), %esi
	movq %rdx, 584(%rsp)
	movq %rcx, 568(%rsp)
	movq %r8, 576(%rsp)
	movq %r9, 552(%rsp)
	callq _c0_push
	movq 584(%rsp), %rdx
	movq 568(%rsp), %rcx
	movq 576(%rsp), %r8
	movq 552(%rsp), %r9
	movl %eax, %esi
.solveEven_40:
	movl %eax, 1128(%rsp)
	movl 1120(%rsp), %r10d
	movl %r10d, 1132(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 592(%rsp)
	movl %ecx, 1136(%rsp)
	movq 88(%rsp), %r10
	movq %r10, 560(%rsp)
	movl %r8d, %ecx
	movq %rbp, 568(%rsp)
	movl %r9d, %r8d
	movq %rdx, %r9
	movl 1124(%rsp), %edx
	movl %esi, %eax
	movl 940(%rsp), %edi
	jmp .solveEven_26
.solveEven_27:
.solveEven_42:
	movl 1056(%rsp), %esi
	movl 876(%rsp), %edx
	jmp .solveEven_28
.solveEven_15:
	movl $67, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 940(%rsp)
	movl 940(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 80(%rsp)
	movl $2, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq printint
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 1140(%rsp)
	movslq 1140(%rsp), %rbp
	movl $65, %edi
	movq %rcx, 600(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r14
	callq printchar
	movq 600(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r14, %r9
	movl %eax, 1008(%rsp)
	movl 1008(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 88(%rsp)
	movl $10, %edi
	movq %rcx, 608(%rsp)
	movq %r8, 400(%rsp)
	movq %r9, %r14
	callq printchar
	movq 608(%rsp), %rcx
	movq 400(%rsp), %r8
	movq %r14, %r9
	movl %eax, 1144(%rsp)
	movl 1144(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 608(%rsp)
	movl 696(%rsp), %edi
	movq %rcx, 616(%rsp)
	movq %r8, 384(%rsp)
	movq %r9, %r14
	callq _c0_head
	movq 616(%rsp), %rcx
	movq 384(%rsp), %r8
	movq %r14, %r9
	movl %eax, 1148(%rsp)
	movl 1148(%rsp), %edx
	movl 696(%rsp), %edi
	movq %rdx, 624(%rsp)
	movq %rcx, 632(%rsp)
	movq %r8, 616(%rsp)
	movq %r9, %r14
	callq _c0_pop
	movq 624(%rsp), %rdx
	movq 632(%rsp), %rcx
	movq 616(%rsp), %r8
	movq %r14, %r9
	movl %eax, 1064(%rsp)
	movl 1064(%rsp), %r10d
	movl %r10d, 1060(%rsp)
	movl %edx, %edi
	movl 880(%rsp), %esi
	movq %rdx, 368(%rsp)
	movq %rcx, 640(%rsp)
	movq %r8, 624(%rsp)
	movq %r9, %r14
	callq _c0_push
	movq 368(%rsp), %rdx
	movq 640(%rsp), %rcx
	movq 624(%rsp), %r8
	movq %r14, %r9
	movl %eax, %esi
.solveEven_36:
	movl %eax, %r14d
	movl 1064(%rsp), %r10d
	movl %r10d, 968(%rsp)
	movl 1148(%rsp), %r10d
	movl %r10d, 976(%rsp)
	movl 1144(%rsp), %r10d
	movl %r10d, 984(%rsp)
	movq 608(%rsp), %r10
	movq %r10, 368(%rsp)
	movl 1008(%rsp), %r10d
	movl %r10d, 992(%rsp)
	movq 88(%rsp), %r10
	movq %r10, 384(%rsp)
	movl 1140(%rsp), %r10d
	movl %r10d, 1000(%rsp)
	movq %rbp, 400(%rsp)
	movl 940(%rsp), %r10d
	movl %r10d, 1008(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 416(%rsp)
	movl 1060(%rsp), %edi
	jmp .solveEven_16
.solveEven_17:
.solveEven_38:
	movl 696(%rsp), %r10d
	movl %r10d, 1056(%rsp)
	movl 880(%rsp), %r10d
	movl %r10d, 1060(%rsp)
	movl 740(%rsp), %r10d
	movl %r10d, 1064(%rsp)
	jmp .solveEven_18
.solveEven_5:
	movl $66, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 880(%rsp)
	movl 880(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 648(%rsp)
	movl $2, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printint
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1152(%rsp)
	movl 1152(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 80(%rsp)
	movl $65, %edi
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1156(%rsp)
	movl 1156(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 656(%rsp)
	movl $10, %edi
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 888(%rsp)
	movl 888(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl 700(%rsp), %edi
	movq %rcx, 664(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 664(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl %edx, 688(%rsp)
	movl 700(%rsp), %edi
	movq %rdx, 288(%rsp)
	movq %rcx, 216(%rsp)
	movq %r8, 664(%rsp)
	movq %r9, %rbp
	callq _c0_pop
	movq 288(%rsp), %rdx
	movq 216(%rsp), %rcx
	movq 664(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 824(%rsp)
	movl 824(%rsp), %ebp
	movl 688(%rsp), %edi
	movl 704(%rsp), %esi
	movq %rdx, 672(%rsp)
	movq %rcx, 680(%rsp)
	movq %r8, 288(%rsp)
	movq %r9, 216(%rsp)
	callq _c0_push
	movq 672(%rsp), %rdx
	movq 680(%rsp), %rcx
	movq 288(%rsp), %r8
	movq 216(%rsp), %r9
	movl %eax, %esi
	movl %esi, %eax
.solveEven_32:
	movl %esi, 776(%rsp)
	movl 824(%rsp), %r10d
	movl %r10d, 784(%rsp)
	movl %edx, 792(%rsp)
	movl 888(%rsp), %r10d
	movl %r10d, 800(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 184(%rsp)
	movl 1156(%rsp), %r10d
	movl %r10d, 808(%rsp)
	movq 656(%rsp), %r10
	movq %r10, 200(%rsp)
	movl 1152(%rsp), %r10d
	movl %r10d, 816(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 216(%rsp)
	movl 880(%rsp), %r10d
	movl %r10d, 824(%rsp)
	movq 648(%rsp), %r10
	movq %r10, 232(%rsp)
	movl %ebp, %edi
	movl %eax, %esi
	movl 688(%rsp), %edx
	jmp .solveEven_6
.solveEven_7:
.solveEven_34:
	movl 700(%rsp), %r10d
	movl %r10d, 876(%rsp)
	movl 704(%rsp), %r10d
	movl %r10d, 880(%rsp)
	jmp .solveEven_8
.solveEven_46:
.solveEven_29:
	movl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $1160, %rsp
	ret
.solveEven_45:
	jmp .solveEven_29
.solveEven_44:
	jmp .solveEven_29
_c0_solveOdd:
	addq $-1160, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.solveOdd_0:
	movl %edi, %ebp
	movl %esi, 680(%rsp)
	movl %edx, 684(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq printint
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movl $10, %edi
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq printchar
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movl %ebp, %edi
	movl 680(%rsp), %esi
	movl 684(%rsp), %edx
	movq %rcx, 56(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_printTowers
	movq 56(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
.solveOdd_31:
	movl 684(%rsp), %r10d
	movl %r10d, 688(%rsp)
	movl 680(%rsp), %r10d
	movl %r10d, 692(%rsp)
	movl %ebp, 696(%rsp)
.solveOdd_1:
	movl 696(%rsp), %edi
	movl 692(%rsp), %esi
	movl 688(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_solved
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl $1, %esi
	movl $1, %edi
	xorl %eax, %edi
	cmpl %edi, %esi
	jnz .solveOdd_46
.solveOdd_2:
	movl 696(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 700(%rsp)
	movl $0, %edx
	cmpl %edx, 700(%rsp)
	jnz .ternary_true13
	movl 688(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 704(%rsp)
	movl $0, %edx
	movl 704(%rsp), %r10d
	movl %r10d, 708(%rsp)
	cmpl %edx, 708(%rsp)
	setne %r11b
	movzbl %r11b, %r11d
	movl %r11d, 708(%rsp)
	jmp .ternary_end14
.ternary_true13:
	movl $1, 708(%rsp)
.ternary_end14:
	movl $1, %edx
	cmpl 708(%rsp), %edx
	jnz .solveOdd_7
.solveOdd_3:
	movl 696(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 712(%rsp)
	movl 712(%rsp), %r10d
	movl %r10d, 716(%rsp)
	movl 688(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 720(%rsp)
	movl 720(%rsp), %r10d
	movl %r10d, 724(%rsp)
	movl 696(%rsp), %edi
	movl 688(%rsp), %esi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_legalMove
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 728(%rsp)
	movl $1, %edx
	cmpl 728(%rsp), %edx
	jnz .solveOdd_5
.solveOdd_4:
	movl $65, %edi
	movq %rcx, 96(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq printchar
	movq 96(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %ebp
	movslq %ebp, %rbp
	movq %rbp, 88(%rsp)
	movl $2, %edi
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, %r15
	callq printint
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq %r15, %r9
	movl %eax, 684(%rsp)
	movl 684(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl $67, %edi
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, %r15
	callq printchar
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq %r15, %r9
	movl %eax, 732(%rsp)
	movl 732(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 112(%rsp)
	movl $10, %edi
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, %r15
	callq printchar
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq %r15, %r9
	movl %eax, 736(%rsp)
	movl 736(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 120(%rsp)
	movl 696(%rsp), %edi
	movq %rcx, 128(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, %r15
	callq _c0_head
	movq 128(%rsp), %rcx
	movq 104(%rsp), %r8
	movq %r15, %r9
	movl %eax, %r15d
	movl %r15d, 740(%rsp)
	movl 696(%rsp), %edi
	movq %rcx, 136(%rsp)
	movq %r8, 128(%rsp)
	movq %r9, 104(%rsp)
	callq _c0_pop
	movq 136(%rsp), %rcx
	movq 128(%rsp), %r8
	movq 104(%rsp), %r9
	movl %eax, 744(%rsp)
	movl 744(%rsp), %edx
	movl 740(%rsp), %edi
	movl 688(%rsp), %esi
	movq %rdx, 144(%rsp)
	movq %rcx, 152(%rsp)
	movq %r8, 136(%rsp)
	movq %r9, 128(%rsp)
	callq _c0_push
	movq 144(%rsp), %rdx
	movq 152(%rsp), %rcx
	movq 136(%rsp), %r8
	movq 128(%rsp), %r9
	movl %eax, %edi
.solveOdd_33:
	movl %eax, 748(%rsp)
	movl 744(%rsp), %r10d
	movl %r10d, 752(%rsp)
	movl %r15d, 744(%rsp)
	movq 120(%rsp), %r15
	movl 732(%rsp), %r10d
	movl %r10d, 756(%rsp)
	movq 112(%rsp), %r10
	movq %r10, 160(%rsp)
	movl 684(%rsp), %r10d
	movl %r10d, 760(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 168(%rsp)
	movl %ebp, 764(%rsp)
	movq 88(%rsp), %r10
	movq %r10, 176(%rsp)
	movl 740(%rsp), %esi
.solveOdd_6:
.solveOdd_35:
	movl 768(%rsp), %r10d
	movl %r10d, 772(%rsp)
	movl 776(%rsp), %r10d
	movl %r10d, 780(%rsp)
	movl 784(%rsp), %r10d
	movl %r10d, 788(%rsp)
	movl 792(%rsp), %r10d
	movl %r10d, 796(%rsp)
	movq 184(%rsp), %r10
	movq %r10, 192(%rsp)
	movl 800(%rsp), %r10d
	movl %r10d, 804(%rsp)
	movq 200(%rsp), %r10
	movq %r10, 208(%rsp)
	movl 808(%rsp), %r10d
	movl %r10d, 812(%rsp)
	movq 216(%rsp), %r10
	movq %r10, 224(%rsp)
	movl 816(%rsp), %r10d
	movl %r10d, 820(%rsp)
	movq 232(%rsp), %r10
	movq %r10, 240(%rsp)
	movl 748(%rsp), %r10d
	movl %r10d, 824(%rsp)
	movl 752(%rsp), %r10d
	movl %r10d, 828(%rsp)
	movl 744(%rsp), %r10d
	movl %r10d, 832(%rsp)
	movl 736(%rsp), %r10d
	movl %r10d, 836(%rsp)
	movq %r15, 248(%rsp)
	movl 756(%rsp), %r10d
	movl %r10d, 840(%rsp)
	movq 160(%rsp), %r10
	movq %r10, 256(%rsp)
	movl 760(%rsp), %r10d
	movl %r10d, 844(%rsp)
	movq 168(%rsp), %r10
	movq %r10, 264(%rsp)
	movl 764(%rsp), %r10d
	movl %r10d, 848(%rsp)
	movq 176(%rsp), %r10
	movq %r10, 272(%rsp)
	movl 728(%rsp), %r10d
	movl %r10d, 852(%rsp)
	movl 720(%rsp), %r10d
	movl %r10d, 856(%rsp)
	movl 724(%rsp), %r10d
	movl %r10d, 740(%rsp)
	movl 712(%rsp), %r10d
	movl %r10d, 860(%rsp)
	movl 716(%rsp), %r10d
	movl %r10d, 864(%rsp)
	movl %edi, 868(%rsp)
	movl %edx, 872(%rsp)
	movl %esi, 732(%rsp)
.solveOdd_8:
	movl 872(%rsp), %edi
	movl 692(%rsp), %esi
	movl 868(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_printTowers
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 876(%rsp)
	movl 876(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 280(%rsp)
	movl $10, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 880(%rsp)
	movl 880(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 288(%rsp)
	movl 872(%rsp), %edi
	movl 692(%rsp), %esi
	movl 868(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_solved
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 884(%rsp)
	movl $1, %edx
	cmpl 884(%rsp), %edx
	jnz .solveOdd_11
.solveOdd_9:
	jmp .solveOdd_44
.solveOdd_11:
.solveOdd_12:
	movl 872(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 888(%rsp)
	movl $0, %edx
	cmpl %edx, 888(%rsp)
	jnz .ternary_true15
	movl 692(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 892(%rsp)
	movl $0, %edx
	movl 892(%rsp), %r10d
	movl %r10d, 896(%rsp)
	cmpl %edx, 896(%rsp)
	setne %r11b
	movzbl %r11b, %r11d
	movl %r11d, 896(%rsp)
	jmp .ternary_end16
.ternary_true15:
	movl $1, 896(%rsp)
.ternary_end16:
	movl $1, %edx
	cmpl 896(%rsp), %edx
	jnz .solveOdd_17
.solveOdd_13:
	movl 872(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 900(%rsp)
	movl 900(%rsp), %r10d
	movl %r10d, 904(%rsp)
	movl 692(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 908(%rsp)
	movl 908(%rsp), %r10d
	movl %r10d, 912(%rsp)
	movl 872(%rsp), %edi
	movl 692(%rsp), %esi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_legalMove
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 916(%rsp)
	movl $1, %edx
	cmpl 916(%rsp), %edx
	jnz .solveOdd_15
.solveOdd_14:
	movl $65, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl %eax, %ebp
	movslq %ebp, %rbp
	movq %rbp, 296(%rsp)
	movl $2, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r13
	callq printint
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r13, %r9
	movl %eax, 684(%rsp)
	movl 684(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 304(%rsp)
	movl $66, %edi
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r13
	callq printchar
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r13, %r9
	movl %eax, 920(%rsp)
	movslq 920(%rsp), %rdx
	movl $10, %edi
	movq %rdx, 312(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r13
	callq printchar
	movq 312(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r13, %r9
	movl %eax, 924(%rsp)
	movl 924(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 320(%rsp)
	movl 872(%rsp), %edi
	movq %rdx, 328(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r13
	callq _c0_head
	movq 328(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r13, %r9
	movl %eax, 928(%rsp)
	movl 928(%rsp), %r10d
	movl %r10d, 932(%rsp)
	movl 872(%rsp), %edi
	movq %rdx, 336(%rsp)
	movq %rcx, 344(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r13
	callq _c0_pop
	movq 336(%rsp), %rdx
	movq 344(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r13, %r9
	movl %eax, %r13d
	movl %r13d, 680(%rsp)
	movl 932(%rsp), %edi
	movl 692(%rsp), %esi
	movq %rdx, 352(%rsp)
	movq %rcx, 360(%rsp)
	movq %r8, 336(%rsp)
	movq %r9, 344(%rsp)
	callq _c0_push
	movq 352(%rsp), %rdx
	movq 360(%rsp), %rcx
	movq 336(%rsp), %r8
	movq 344(%rsp), %r9
	movl %eax, %edi
.solveOdd_37:
	movl %eax, 936(%rsp)
	movl %r13d, 940(%rsp)
	movl 928(%rsp), %r10d
	movl %r10d, 944(%rsp)
	movl 924(%rsp), %r10d
	movl %r10d, 948(%rsp)
	movq 320(%rsp), %r10
	movq %r10, 368(%rsp)
	movl 920(%rsp), %r10d
	movl %r10d, 952(%rsp)
	movq %rdx, 360(%rsp)
	movl 684(%rsp), %r10d
	movl %r10d, 956(%rsp)
	movl %ebp, 960(%rsp)
	movq 296(%rsp), %r10
	movq %r10, 312(%rsp)
	movl 680(%rsp), %esi
	movl 932(%rsp), %edx
.solveOdd_16:
.solveOdd_39:
	movl %r14d, 964(%rsp)
	movl 968(%rsp), %r10d
	movl %r10d, 972(%rsp)
	movl 976(%rsp), %r10d
	movl %r10d, 980(%rsp)
	movl 984(%rsp), %r10d
	movl %r10d, 988(%rsp)
	movq 376(%rsp), %r10
	movq %r10, 384(%rsp)
	movl 992(%rsp), %r10d
	movl %r10d, 996(%rsp)
	movq 392(%rsp), %r10
	movq %r10, 400(%rsp)
	movl 1000(%rsp), %r10d
	movl %r10d, 1004(%rsp)
	movq 408(%rsp), %r10
	movq %r10, 416(%rsp)
	movl 1008(%rsp), %r10d
	movl %r10d, 1012(%rsp)
	movq 424(%rsp), %r10
	movq %r10, 432(%rsp)
	movl 936(%rsp), %r10d
	movl %r10d, 1016(%rsp)
	movl 940(%rsp), %r10d
	movl %r10d, 1020(%rsp)
	movl 944(%rsp), %r10d
	movl %r10d, 1024(%rsp)
	movl 948(%rsp), %r10d
	movl %r10d, 1028(%rsp)
	movq 368(%rsp), %r10
	movq %r10, 440(%rsp)
	movl 952(%rsp), %r10d
	movl %r10d, 1032(%rsp)
	movq 360(%rsp), %r10
	movq %r10, 448(%rsp)
	movl 956(%rsp), %r10d
	movl %r10d, 1036(%rsp)
	movq 304(%rsp), %r10
	movq %r10, 336(%rsp)
	movl 960(%rsp), %r10d
	movl %r10d, 932(%rsp)
	movq 312(%rsp), %r10
	movq %r10, 456(%rsp)
	movl 916(%rsp), %r13d
	movl 908(%rsp), %r10d
	movl %r10d, 1040(%rsp)
	movl 912(%rsp), %r10d
	movl %r10d, 1044(%rsp)
	movl 900(%rsp), %r10d
	movl %r10d, 1048(%rsp)
	movl 904(%rsp), %r10d
	movl %r10d, 1052(%rsp)
	movl %edi, 1056(%rsp)
	movl %esi, 1060(%rsp)
	movl %edx, 1064(%rsp)
.solveOdd_18:
	movl 1060(%rsp), %edi
	movl 1056(%rsp), %esi
	movl 868(%rsp), %edx
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_printTowers
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movslq %ebp, %rbp
	movq %rbp, 88(%rsp)
	movl $10, %edi
	movq %rcx, 464(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq printchar
	movq 464(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 684(%rsp)
	movl 684(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl 1060(%rsp), %edi
	movl 1056(%rsp), %esi
	movl 868(%rsp), %edx
	movq %rcx, 472(%rsp)
	movq %r8, 480(%rsp)
	movq %r9, 464(%rsp)
	callq _c0_solved
	movq 472(%rsp), %rcx
	movq 480(%rsp), %r8
	movq 464(%rsp), %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .solveOdd_21
.solveOdd_19:
	jmp .solveOdd_45
.solveOdd_21:
.solveOdd_22:
	movl 1056(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl $0, %edx
	cmpl %edx, %eax
	jnz .ternary_true17
	movl 868(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	jmp .ternary_end18
.ternary_true17:
	movl $1, %edx
.ternary_end18:
	movl $1, %esi
	cmpl %edx, %esi
	jnz .solveOdd_27
.solveOdd_23:
	movl 1056(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1068(%rsp)
	movl 1068(%rsp), %r10d
	movl %r10d, 1072(%rsp)
	movl 868(%rsp), %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1076(%rsp)
	movl 1076(%rsp), %r10d
	movl %r10d, 1080(%rsp)
	movl 1056(%rsp), %edi
	movl 868(%rsp), %esi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_legalMove
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1084(%rsp)
	movl $1, %edx
	cmpl 1084(%rsp), %edx
	jnz .solveOdd_25
.solveOdd_24:
	movl $66, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r12
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r12, %r9
	movl %eax, %edx
	movslq %edx, %rbp
	movl $2, %edi
	movq %rdx, 72(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r12
	callq printint
	movq 72(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r12, %r9
	movl %eax, 680(%rsp)
	movl 680(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 488(%rsp)
	movl $67, %edi
	movq %rdx, 496(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, %r12
	callq printchar
	movq 496(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq %r12, %r9
	movl %eax, 1088(%rsp)
	movslq 1088(%rsp), %r12
	movl $10, %edi
	movq %rdx, 504(%rsp)
	movq %rcx, 496(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq printchar
	movq 504(%rsp), %rdx
	movq 496(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 684(%rsp)
	movl 684(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl 1056(%rsp), %edi
	movq %rdx, 64(%rsp)
	movq %rcx, 512(%rsp)
	movq %r8, 504(%rsp)
	movq %r9, 496(%rsp)
	callq _c0_head
	movq 64(%rsp), %rdx
	movq 512(%rsp), %rcx
	movq 504(%rsp), %r8
	movq 496(%rsp), %r9
	movl %eax, 1092(%rsp)
	movl 1092(%rsp), %r10d
	movl %r10d, 688(%rsp)
	movl 1056(%rsp), %edi
	movq %rdx, 520(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, 512(%rsp)
	movq %r9, 504(%rsp)
	callq _c0_pop
	movq 520(%rsp), %rdx
	movq 56(%rsp), %rcx
	movq 512(%rsp), %r8
	movq 504(%rsp), %r9
	movl %eax, 1096(%rsp)
	movl 1096(%rsp), %r10d
	movl %r10d, 692(%rsp)
	movl 688(%rsp), %edi
	movl 868(%rsp), %esi
	movq %rdx, 528(%rsp)
	movq %rcx, 536(%rsp)
	movq %r8, 520(%rsp)
	movq %r9, 512(%rsp)
	callq _c0_push
	movq 528(%rsp), %rdx
	movq 536(%rsp), %rcx
	movq 520(%rsp), %r8
	movq 512(%rsp), %r9
	movl %eax, %esi
.solveOdd_41:
	movl %eax, 1100(%rsp)
	movl 1096(%rsp), %r10d
	movl %r10d, 1104(%rsp)
	movl 1092(%rsp), %r10d
	movl %r10d, 1108(%rsp)
	movl 684(%rsp), %r10d
	movl %r10d, 1112(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 504(%rsp)
	movl 1088(%rsp), %r10d
	movl %r10d, 1092(%rsp)
	movl 680(%rsp), %r10d
	movl %r10d, 1116(%rsp)
	movq 488(%rsp), %r10
	movq %r10, 544(%rsp)
	movl %edx, 1120(%rsp)
	movq %rbp, 552(%rsp)
	movl 692(%rsp), %edi
	movl 688(%rsp), %edx
.solveOdd_26:
.solveOdd_43:
	movl %esi, %ebp
	movl %edi, 680(%rsp)
.solveOdd_28:
	movl 1060(%rsp), %edi
	movl 680(%rsp), %esi
	movl %ebp, %edx
	movq %rcx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_printTowers
	movq 64(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movl $10, %edi
	movq %rcx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq printchar
	movq 64(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
.solveOdd_30:
	movl %ebp, 688(%rsp)
	movl 680(%rsp), %r10d
	movl %r10d, 692(%rsp)
	movl 1060(%rsp), %r10d
	movl %r10d, 696(%rsp)
	jmp .solveOdd_1
.solveOdd_25:
	movl $67, %edi
	callq printchar
	movl %eax, %r8d
	movslq %r8d, %rbp
	movl $2, %edi
	movq %r8, %rbx
	callq printint
	movq %rbx, %r8
	movl %eax, %ecx
	movslq %ecx, %rcx
	movq %rcx, 88(%rsp)
	movl $66, %edi
	movq %rcx, 80(%rsp)
	movq %r8, %rbx
	callq printchar
	movq 80(%rsp), %rcx
	movq %rbx, %r8
	movl %eax, 684(%rsp)
	movl 684(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl $10, %edi
	movq %rcx, 560(%rsp)
	movq %r8, %rbx
	callq printchar
	movq 560(%rsp), %rcx
	movq %rbx, %r8
	movl %eax, %ebx
	movslq %ebx, %rbx
	movq %rbx, 568(%rsp)
	movl 868(%rsp), %edi
	movq %rcx, 576(%rsp)
	movq %r8, 560(%rsp)
	callq _c0_head
	movq 576(%rsp), %rcx
	movq 560(%rsp), %r8
	movl %eax, %r9d
	movl %r9d, %edx
	movl 868(%rsp), %edi
	movq %rdx, 584(%rsp)
	movq %rcx, 592(%rsp)
	movq %r8, 576(%rsp)
	movq %r9, 560(%rsp)
	callq _c0_pop
	movq 584(%rsp), %rdx
	movq 592(%rsp), %rcx
	movq 576(%rsp), %r8
	movq 560(%rsp), %r9
	movl %eax, 1124(%rsp)
	movl 1124(%rsp), %r10d
	movl %r10d, 1128(%rsp)
	movl %edx, %edi
	movl 1056(%rsp), %esi
	movq %rdx, 600(%rsp)
	movq %rcx, 584(%rsp)
	movq %r8, 592(%rsp)
	movq %r9, 576(%rsp)
	callq _c0_push
	movq 600(%rsp), %rdx
	movq 584(%rsp), %rcx
	movq 592(%rsp), %r8
	movq 576(%rsp), %r9
	movl %eax, %edi
.solveOdd_40:
	movl %eax, 1132(%rsp)
	movl 1124(%rsp), %r10d
	movl %r10d, 1136(%rsp)
	movl %r9d, 1124(%rsp)
	movq 568(%rsp), %r10
	movq %r10, 608(%rsp)
	movl 684(%rsp), %r10d
	movl %r10d, 1140(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 568(%rsp)
	movq 88(%rsp), %r10
	movq %r10, 584(%rsp)
	movq %rbp, %r9
	movl 1128(%rsp), %esi
	jmp .solveOdd_26
.solveOdd_27:
.solveOdd_42:
	movl 868(%rsp), %ebp
	movl 1056(%rsp), %r10d
	movl %r10d, 680(%rsp)
	jmp .solveOdd_28
.solveOdd_15:
	movl $66, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 1144(%rsp)
	movl 1144(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl $2, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq printint
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 1008(%rsp)
	movl 1008(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 408(%rsp)
	movl $65, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 1000(%rsp)
	movl 1000(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 80(%rsp)
	movl $10, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq printchar
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 1148(%rsp)
	movl 1148(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 616(%rsp)
	movl 692(%rsp), %edi
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _c0_head
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, 1064(%rsp)
	movl 1064(%rsp), %edx
	movl 692(%rsp), %edi
	movq %rdx, 624(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _c0_pop
	movq 624(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, %ebp
	movl %ebp, 680(%rsp)
	movl %edx, %edi
	movl 872(%rsp), %esi
	movq %rdx, 376(%rsp)
	movq %rcx, 632(%rsp)
	movq %r8, 624(%rsp)
	movq %r9, %r14
	callq _c0_push
	movq 376(%rsp), %rdx
	movq 632(%rsp), %rcx
	movq 624(%rsp), %r8
	movq %r14, %r9
	movl %eax, %esi
.solveOdd_36:
	movl %eax, %r14d
	movl %ebp, 968(%rsp)
	movl 1064(%rsp), %r10d
	movl %r10d, 976(%rsp)
	movl 1148(%rsp), %r10d
	movl %r10d, 984(%rsp)
	movq 616(%rsp), %r10
	movq %r10, 376(%rsp)
	movl 1000(%rsp), %r10d
	movl %r10d, 992(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 392(%rsp)
	movl 1008(%rsp), %r10d
	movl %r10d, 1000(%rsp)
	movl 1144(%rsp), %r10d
	movl %r10d, 1008(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 424(%rsp)
	movl 680(%rsp), %edi
	jmp .solveOdd_16
.solveOdd_17:
.solveOdd_38:
	movl 692(%rsp), %r10d
	movl %r10d, 1056(%rsp)
	movl 872(%rsp), %r10d
	movl %r10d, 1060(%rsp)
	movl 732(%rsp), %r10d
	movl %r10d, 1064(%rsp)
	jmp .solveOdd_18
.solveOdd_5:
	movl $67, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 872(%rsp)
	movl 872(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 640(%rsp)
	movl $2, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printint
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1152(%rsp)
	movl 1152(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 80(%rsp)
	movl $65, %edi
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 1156(%rsp)
	movl 1156(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 648(%rsp)
	movl $10, %edi
	movq %rcx, 72(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq printchar
	movq 72(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 816(%rsp)
	movl 816(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 72(%rsp)
	movl 688(%rsp), %edi
	movq %rcx, 656(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbp
	callq _c0_head
	movq 656(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl %edx, 680(%rsp)
	movl 688(%rsp), %edi
	movq %rdx, 288(%rsp)
	movq %rcx, 216(%rsp)
	movq %r8, 656(%rsp)
	movq %r9, %rbp
	callq _c0_pop
	movq 288(%rsp), %rdx
	movq 216(%rsp), %rcx
	movq 656(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 880(%rsp)
	movl 880(%rsp), %ebp
	movl 680(%rsp), %edi
	movl 696(%rsp), %esi
	movq %rdx, 664(%rsp)
	movq %rcx, 672(%rsp)
	movq %r8, 288(%rsp)
	movq %r9, 216(%rsp)
	callq _c0_push
	movq 664(%rsp), %rdx
	movq 672(%rsp), %rcx
	movq 288(%rsp), %r8
	movq 216(%rsp), %r9
	movl %eax, %esi
.solveOdd_32:
	movl %eax, 768(%rsp)
	movl 880(%rsp), %r10d
	movl %r10d, 776(%rsp)
	movl %edx, 784(%rsp)
	movl 816(%rsp), %r10d
	movl %r10d, 792(%rsp)
	movq 72(%rsp), %r10
	movq %r10, 184(%rsp)
	movl 1156(%rsp), %r10d
	movl %r10d, 800(%rsp)
	movq 648(%rsp), %r10
	movq %r10, 200(%rsp)
	movl 1152(%rsp), %r10d
	movl %r10d, 808(%rsp)
	movq 80(%rsp), %r10
	movq %r10, 216(%rsp)
	movl 872(%rsp), %r10d
	movl %r10d, 816(%rsp)
	movq 640(%rsp), %r10
	movq %r10, 232(%rsp)
	movl %ebp, %edi
	movl %esi, %edx
	movl 680(%rsp), %esi
	jmp .solveOdd_6
.solveOdd_7:
.solveOdd_34:
	movl 688(%rsp), %r10d
	movl %r10d, 868(%rsp)
	movl 696(%rsp), %r10d
	movl %r10d, 872(%rsp)
	jmp .solveOdd_8
.solveOdd_46:
.solveOdd_29:
	movl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $1160, %rsp
	ret
.solveOdd_45:
	jmp .solveOdd_29
.solveOdd_44:
	jmp .solveOdd_29
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r9d
	movq %r9, %rbx
	callq readint
	movq %rbx, %r9
	movl %eax, %ecx
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_3
.main_2:
	movl %ecx, %edi
	subl %r8d, %edi
	movl %r9d, %esi
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_push
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_printTower
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_3:
	movl %r9d, %edi
	movl $0, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_printDiscs
	movq %r12, %rcx
	movq %rbx, %r9
	movl $2, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl $1, %r8d
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .main_5
.main_4:
	movl %r9d, %edi
	movl $0, %esi
	movl $0, %edx
	callq _c0_solveEven
.main_6:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_5:
	movl %r9d, %edi
	movl $0, %esi
	movl $0, %edx
	callq _c0_solveOdd
	jmp .main_6
.ident	"15-411 L4 reference compiler"
