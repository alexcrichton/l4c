.file	"../tests2/velociraptor-return_08.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %edi
	movl $5, %edx
	movl $7, %esi
	movl $11, %r9d
	cmpl %r9d, %edi
	jl .ternary_true5
	movl $0, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %edx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
.ternary_end6:
	cmpl $0, %r8d
	jnz .ternary_true3
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r8d
.ternary_end4:
	cmpl $0, %r8d
	jnz .ternary_true1
	movl %edi, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edi, %r8d
	andl %edx, %r8d
	movl %edi, %ecx
	imull %edx, %ecx
	subl %edi, %ecx
	movl %esi, %edx
	sall %cl, %edx
	movl %r9d, %ecx
	sarl %cl, %edx
	orl %edx, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
