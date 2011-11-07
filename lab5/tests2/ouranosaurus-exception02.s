.file	"../tests2/ouranosaurus-exception02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-2147483648, %ecx
	movl $-559038737, %r8d
	movl $0, %r9d
.main_5:
	movl %ecx, %eax
.main_1:
	movl $1, %edi
	movl $32, %esi
	movl %r9d, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .main_3
.main_2:
	movl $0, %ecx
	subl $1, %ecx
	movl %r8d, %esi
	andl $1, %esi
	imull %esi, %ecx
	cltd
	idivl %ecx
	movl %eax, %ecx
	sarl $1, %r8d
	addl $1, %r9d
.main_4:
	movl %ecx, %eax
	jmp .main_1
.main_3:
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
