.file	"../tests2/utahraptor-return10.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movl %r9d, %r12d
	addl $1, %r12d
	movl %r9d, %r8d
	addl %r12d, %r8d
	movl %r8d, %ebx
	addl $1, %ebx
	movl %r9d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	movl %r8d, %eax
	addl $1, %eax
	movl %r9d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	movl %r8d, %edi
	addl $1, %edi
	movl %r9d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	movl %r8d, %esi
	addl $1, %esi
	movl %r9d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	movl %r8d, %edx
	addl $1, %edx
	movl %r9d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	addl %edx, %r8d
	movl %r8d, %ecx
	addl $1, %ecx
	movl %r9d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	addl %edx, %r8d
	addl %ecx, %r8d
	addl $1, %r8d
	addl %r12d, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	addl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	addl $1, %r9d
	movl $0, %r9d
.main_16:
	movl %r9d, %esi
.main_1:
	movl $5, %r9d
	cmpl %r9d, %esi
	jl .ternary_true1
	movl $10, %r9d
	cmpl %r9d, %esi
	jl .ternary_true3
	movl $15, %r9d
	cmpl %r9d, %esi
	jl .ternary_true5
	movl $20, %r9d
	cmpl %r9d, %esi
	jl .ternary_true7
	movl $25, %r9d
	cmpl %r9d, %esi
	jl .ternary_true9
	movl $30, %r9d
	cmpl %r9d, %esi
	jl .ternary_true11
	movl $35, %r9d
	cmpl %r9d, %esi
	jl .ternary_true13
	movl $40, %r9d
	cmpl %r9d, %esi
	jl .ternary_true15
	movl $45, %r9d
	cmpl %r9d, %esi
	jl .ternary_true17
	movl $50, %r9d
	jmp .ternary_end18
.ternary_true17:
	movl %esi, %r9d
	addl $45, %r9d
.ternary_end18:
	jmp .ternary_end16
.ternary_true15:
	movl %esi, %r9d
	addl $40, %r9d
.ternary_end16:
	jmp .ternary_end14
.ternary_true13:
	movl %esi, %r9d
	addl $35, %r9d
.ternary_end14:
	jmp .ternary_end12
.ternary_true11:
	movl %esi, %r9d
	addl $30, %r9d
.ternary_end12:
	jmp .ternary_end10
.ternary_true9:
	movl %esi, %r9d
	addl $25, %r9d
.ternary_end10:
	jmp .ternary_end8
.ternary_true7:
	movl %esi, %r9d
	addl $20, %r9d
.ternary_end8:
	jmp .ternary_end6
.ternary_true5:
	movl %esi, %r9d
	addl $15, %r9d
.ternary_end6:
	jmp .ternary_end4
.ternary_true3:
	movl %esi, %r9d
	addl $10, %r9d
.ternary_end4:
	movl %r9d, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl %esi, %ecx
	addl $5, %ecx
.ternary_end2:
	movl $1, %r8d
	movl %esi, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_14
.main_2:
	movl $1, %r9d
	sall $31, %r9d
	movl %r9d, %edx
	subl $1, %edx
	movl $2147483647, %ecx
	subl $1, %ecx
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ecx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_3:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_5:
.main_6:
.main_18:
.main_7:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_8:
	movl %edx, %r9d
	addl $1, %r9d
.main_17:
	movl %r9d, %edx
	jmp .main_7
.main_9:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_12
.main_10:
	movl $0, %r9d
	subl $1231, %r9d
	movl $0, %r8d
	subl %r9d, %r8d
	movl $0, %eax
	subl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_12:
.main_13:
	movl %esi, %r9d
	addl $1, %r9d
.main_15:
	movl %r9d, %esi
	jmp .main_1
.main_14:
	movl $1123123, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
