.file	"../tests2/velociraptor-return_07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $6, %eax
	movl $1, %edi
	movl $18, %esi
	movl $36, %edx
	cmpl %edx, %esi
	jl .ternary_true1
	movl %edi, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl %r9d, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_1
.main_4:
	movl %esi, %r8d
	addl %eax, %r8d
.main_10:
	movl %edx, %ecx
.main_6:
	cmpl $0, %r9d
	jnz .ternary_true5
	cmpl $0, %edi
	jnz .ternary_true7
	movl %ecx, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl %r8d, %r9d
.ternary_end8:
	jmp .ternary_end6
.ternary_true5:
	movl %eax, %r9d
.ternary_end6:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_1:
	cmpl $0, %r9d
	jnz .ternary_true3
	movl %esi, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl %eax, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
.ternary_end4:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_3
.main_2:
	movl %edx, %r8d
	addl %esi, %r8d
.main_8:
.main_5:
.main_9:
	movl %r8d, %ecx
	movl %esi, %r8d
	jmp .main_6
.main_3:
.main_7:
	movl %edx, %r8d
	jmp .main_5
.ident	"15-411 L4 reference compiler"
