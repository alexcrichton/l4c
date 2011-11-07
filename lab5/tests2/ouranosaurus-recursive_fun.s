.file	"../tests2/ouranosaurus-recursive_fun.l3"
.globl _c0_main
_c0_f1:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.f1_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f3
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_f2
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_f3
	movq %rbx, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .f1_3
.f1_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.f1_3:
.f1_4:
	movl %r9d, %edi
	subl $1, %edi
	callq _c0_f1
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_f2:
	addq $-8, %rsp
.f2_0:
	movl $1, %r8d
	cmpl %edi, %r8d
	jnz .f2_3
.f2_1:
	movl $6, %eax
	addq $8, %rsp
	ret
.f2_3:
.f2_4:
	movl $3, %eax
	addq $8, %rsp
	ret
_c0_f3:
	addq $-8, %rsp
	movl %edi, %eax
.f3_0:
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $0, %r8d
	movl %edx, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %edi
	callq _c0_f1
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
