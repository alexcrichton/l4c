.file	"../tests1/hobby-its-mutual.l3"
.globl _c0_main
_c0_even:
	addq $-8, %rsp
.even_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .even_3
.even_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.even_3:
.even_4:
	subl $1, %edi
	callq _c0_odd
	addq $8, %rsp
	ret
_c0_odd:
	addq $-8, %rsp
.odd_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .odd_3
.odd_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.odd_3:
.odd_4:
	subl $1, %edi
	callq _c0_even
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $13, %edi
	callq _c0_even
	movl %eax, %r9d
	movl $17, %edi
	movq %r9, %rbx
	callq _c0_odd
	movq %rbx, %r9
	movl %eax, %r8d
	cmpl $0, %r9d
	jnz .ternary_true1
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_1:
	movl $26, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	movl $3, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
