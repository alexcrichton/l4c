.file	"../tests2/galimimus-madness.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
	subl $4, %r8d
.main_8:
	movl %r8d, %edx
	movl %r9d, %edi
.main_1:
	movl $1, %ecx
	movl $8, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_6
.main_2:
	movl %edi, %r9d
.main_10:
	movl %edx, %esi
	movl %r9d, %edx
.main_3:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_4:
	movl %esi, %r8d
	addl %edx, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_9:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_3
.main_5:
	movl %edi, %r9d
	addl $1, %r9d
.main_7:
	movl %esi, %edx
	movl %r9d, %edi
	jmp .main_1
.main_6:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
