.file	"../tests1/eagle-logical-ops.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r9d
	movl $2, %r8d
	cmpl %r8d, %r9d
	jz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $3, %edx
	movl %eax, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_3
.main_1:
	movl $2, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $6, %r8d
	cmpl %r8d, %r9d
	jz .ternary_true3
	movl $0, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $5, %r8d
	movl %eax, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %ecx
.ternary_end4:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_7
.main_5:
	jmp .ternary_true5
	movl $0, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %r9d, %r8d
.ternary_end6:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.main_7:
.main_8:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
