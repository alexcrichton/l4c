.file	"../tests2/trex-digits.l3"
.globl _c0_main
_c0_one_at:
	addq $-8, %rsp
	movl %esi, %ecx
.one_at_0:
	movl $0, %edx
	movl $1, %r8d
	sall %cl, %r8d
	movl %edi, %r9d
	andl %r8d, %r9d
	movl %edx, %eax
	cmpl %r9d, %eax
	setl %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_num_ones:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.num_ones_0:
	movl $0, %r8d
	movl $0, %ecx
.num_ones_8:
.num_ones_1:
	movl $1, %edi
	movl $31, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .num_ones_6
.num_ones_2:
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_one_at
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .num_ones_4
.num_ones_3:
	addl $1, %r8d
.num_ones_10:
	movl %r8d, %edx
.num_ones_5:
	addl $1, %ecx
.num_ones_7:
	movl %edx, %r8d
	jmp .num_ones_1
.num_ones_4:
.num_ones_9:
	movl %r8d, %edx
	jmp .num_ones_5
.num_ones_6:
	movl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1337, %edi
	callq _c0_num_ones
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
