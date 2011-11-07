.file	"../tests2/microceratops-return03.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %esi
	movl $1, %edx
	movl $4, %r8d
	movl $1, %r9d
.main_13:
	movl %r8d, %ecx
	movl %edx, %edi
	movl %esi, %eax
.main_1:
	movl $1, %edx
	movl %eax, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_15
.main_2:
	cltd
	idivl %edi
	movl %edx, %r8d
	movl %r8d, %esi
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %ebx
	movl %ebx, %eax
	movl $1, %edx
	movl %esi, %ecx
	cmpl %eax, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_5
.main_3:
	jmp .main_14
.main_5:
.main_6:
	movl %esi, %r8d
	addl $1, %r8d
	addl $1, %r9d
	movl %eax, %ecx
	addl $1, %ecx
	movl %ecx, %edx
	movl %r9d, %r8d
.main_12:
	movl %edx, %edi
	movl %r8d, %eax
	jmp .main_1
.main_15:
	movl %eax, %r8d
.main_7:
	cmpl %r9d, %r8d
	jz .ternary_true1
	movl %edi, %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %r9d
	cmpl %edx, %r9d
	jnz .main_10
.main_8:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
.main_11:
	movl %r8d, %eax
	addl %edi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_14:
	movl %eax, %ecx
	movl %esi, %r8d
	jmp .main_7
.ident	"15-411 L4 reference compiler"
