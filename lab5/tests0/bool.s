.file	"../tests0/bool.l4"
.globl _c0_main
_c0_xor:
	addq $-8, %rsp
.xor_0:
	cmpl $0, %edi
	jnz .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r8d
	xorl %esi, %r8d
.ternary_end4:
	cmpl $0, %r8d
	jnz .ternary_true1
	movl $1, %r8d
	cmpl %edi, %r8d
	jnz .ternary_true5
	movl $0, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl %esi, %r9d
.ternary_end6:
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %r9d
	movl $0, %r8d
	movl %r9d, %edi
	movl %r9d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_xor
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .ternary_true11
	movl $0, %ecx
	jmp .ternary_end12
.ternary_true11:
	movl %r9d, %edi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_xor
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
.ternary_end12:
	cmpl $0, %ecx
	jnz .ternary_true9
	movl $0, %ecx
	jmp .ternary_end10
.ternary_true9:
	movl %r8d, %edi
	movl %r9d, %esi
	movq %r8, %rbx
	callq _c0_xor
	movq %rbx, %r8
	movl %eax, %ecx
.ternary_end10:
	cmpl $0, %ecx
	jnz .ternary_true7
	movl $0, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl %r8d, %edi
	movl %r8d, %esi
	callq _c0_xor
	movl $1, %r9d
	xorl %eax, %r9d
.ternary_end8:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_2
.main_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_2:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
