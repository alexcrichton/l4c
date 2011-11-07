.file	"../tests1/merlin-argument-order.l3"
.globl _c0_main
_c0_snooze:
	addq $-8, %rsp
.snooze_0:
.snooze_1:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .snooze_3
.snooze_2:
	jmp .snooze_1
.snooze_3:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_go_deeper:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.go_deeper_0:
	movl $1, %r9d
	movq %r9, %rbx
	callq _c0_go_deeper
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_die:
	addq $-8, %rsp
.die_0:
	movl $10, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_inception:
	addq $-8, %rsp
.inception_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_die
	movl %eax, %r9d
	movl $1, %edi
	movq %r9, %rbx
	callq _c0_snooze
	movq %rbx, %r9
	movl %eax, %r8d
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_go_deeper
	movq %r12, %r8
	movq %rbx, %r9
	movl $3, %edi
	movl %r9d, %esi
	movl %r8d, %edx
	movl %eax, %ecx
	callq _c0_inception
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
