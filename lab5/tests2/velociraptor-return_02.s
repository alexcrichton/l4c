.file	"../tests2/velociraptor-return_02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %eax
	movl $2, %edi
	cmpl %eax, %r9d
	jl .ternary_true1
	movl %r9d, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end2
.ternary_true1:
	cmpl %edi, %eax
	jl .ternary_true3
	movl %edi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl %edi, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
.ternary_end4:
.ternary_end2:
	movl %r8d, %esi
	cmpl $0, %esi
	jnz .ternary_true5
	movl %r9d, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %eax, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
.ternary_end6:
	movl %r8d, %edx
	cmpl $0, %edx
	jnz .ternary_true7
	movl %eax, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl %r9d, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
.ternary_end8:
	movl %r8d, %ecx
	cmpl $0, %ecx
	jnz .ternary_true9
	movl %edx, %r8d
	jmp .ternary_end10
.ternary_true9:
	movl %esi, %r8d
.ternary_end10:
	cmpl $0, %r8d
	jnz .ternary_true11
	cmpl $0, %edx
	jnz .ternary_true13
	cmpl $0, %ecx
	jnz .ternary_true15
	movl %r9d, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	jmp .ternary_end16
.ternary_true15:
	movl %edi, %r8d
.ternary_end16:
	jmp .ternary_end14
.ternary_true13:
	movl %eax, %r8d
.ternary_end14:
	jmp .ternary_end12
.ternary_true11:
	movl %r9d, %r8d
.ternary_end12:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
