.file	"../tests2/vulcanodon-return03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	movl $1, %r8d
	movl $0, %r9d
.main_9:
	movl %r9d, %edi
	movl %r8d, %r9d
	movl %ecx, %r8d
.main_1:
	movl $1, %esi
	movl $10, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r9d, %ecx
	imull %r9d, %ecx
	imull %r9d, %ecx
	movl %ecx, %edx
	imull %r9d, %edx
	movl %edi, %ecx
	addl %edx, %ecx
	movl %r9d, %esi
	movl %r9d, %edx
	addl $1, %edx
	imull %edx, %esi
	movl $2, %edx
	imull %r9d, %edx
	addl $1, %edx
	movl %esi, %edi
	imull %edx, %edi
	movl $3, %edx
	imull %r9d, %edx
	imull %r9d, %edx
	movl $3, %esi
	imull %r9d, %esi
	addl %esi, %edx
	movl %edx, %esi
	subl $1, %esi
	movl %edi, %eax
	imull %esi, %eax
	movl $30, %esi
	cltd
	idivl %esi
	movl %eax, %edx
	cmpl $0, %r8d
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	addl $1, %r9d
.main_8:
	movl %ecx, %edi
	jmp .main_1
.main_3:
	cmpl $0, %r8d
	jnz .ternary_true5
	movl $0, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $1, %r9d
.ternary_end6:
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_6
.main_4:
	movl $42, %eax
	addq $8, %rsp
	ret
.main_6:
.main_7:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
