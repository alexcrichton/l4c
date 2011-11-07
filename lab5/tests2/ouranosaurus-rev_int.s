.file	"../tests2/ouranosaurus-rev_int.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-264586018, %ecx
	movl $0, %r8d
	movl $31, %r9d
.main_5:
	movl %ecx, %esi
.main_1:
	movl $1, %edx
	movl $0, %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	movl %esi, %ecx
	andl $1, %ecx
	movl %ecx, %edx
	movl %r9d, %ecx
	sall %cl, %edx
	orl %edx, %r8d
	movl %esi, %ecx
	sarl $1, %ecx
	subl $1, %r9d
.main_4:
	movl %ecx, %esi
	jmp .main_1
.main_3:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
