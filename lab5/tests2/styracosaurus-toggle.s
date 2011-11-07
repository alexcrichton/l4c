.file	"../tests2/styracosaurus-toggle.l3"
.globl _c0_main
_c0_toggle:
	addq $-8, %rsp
.toggle_0:
	movl $0, %r8d
	cmpl %r8d, %esi
	jl .ternary_true1
	movl $31, %r8d
	movl %r8d, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .toggle_3
.toggle_1:
	movl %edi, %eax
	addq $8, %rsp
	ret
.toggle_3:
.toggle_4:
	movl $1, %r8d
	movl %esi, %ecx
	sall %cl, %r8d
	movl %edi, %esi
	andl %r8d, %esi
	movl $-1, %ecx
	xorl %r8d, %ecx
	movl %edi, %edx
	andl %ecx, %edx
	movl $-1, %r9d
	xorl %esi, %r9d
	movl %r9d, %ecx
	andl %r8d, %ecx
	movl %edx, %r9d
	orl %ecx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $16, %edi
	movl $3, %esi
	callq _c0_toggle
	movl %eax, %r9d
	movl $1, %ecx
	movl $24, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
