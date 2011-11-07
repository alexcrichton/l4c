.file	"../tests1/kestrel-fun3.l3"
.globl _c0_main
_c0_count:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.count_0:
	movl $1, %r9d
	movl $0, %ecx
	movl %edi, %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r9d
	jnz .count_3
.count_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.count_3:
.count_4:
	movl $2, %r9d
	movl %edi, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	jz .ternary_true1
	movl $1, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r9d
.ternary_end2:
	movl $2, %ecx
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_count
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $195935983, %edi
	callq _c0_count
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
