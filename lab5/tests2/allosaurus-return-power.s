.file	"../tests2/allosaurus-return-power.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	movl $3, %ecx
	movl %r9d, %r8d
.main_5:
	movl %r8d, %esi
	movl %ecx, %edx
.main_1:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %esi, %ecx
	imull %r9d, %ecx
	movl %edx, %r8d
	subl $1, %r8d
.main_4:
	movl %ecx, %esi
	movl %r8d, %edx
	jmp .main_1
.main_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
