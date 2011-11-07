.file	"../tests2/stegosaurus-ackermann.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %edi
	movl $11, %esi
	callq _c0_a
	addq $8, %rsp
	ret
_c0_a:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %edx
.a_0:
	movl $1, %ecx
	movl $0, %r8d
	movl %r9d, %esi
	cmpl %r8d, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .a_3
.a_1:
	movl %edx, %eax
	addl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.a_3:
.a_4:
	movl $0, %r8d
	cmpl %r9d, %r8d
	jl .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %ecx
	movl %edx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl $1, %ecx
	cmpl %r8d, %ecx
	jnz .a_7
.a_5:
	movl %r9d, %edi
	subl $1, %edi
	movl $1, %esi
	callq _c0_a
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.a_7:
.a_8:
	movl %r9d, %edi
	movl %edx, %esi
	subl $1, %esi
	movq %r9, %rbx
	callq _c0_a
	movq %rbx, %r9
	movl %r9d, %edi
	subl $1, %edi
	movl %eax, %esi
	callq _c0_a
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
