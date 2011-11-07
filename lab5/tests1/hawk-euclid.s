.file	"../tests1/hawk-euclid.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2147483647, %r9d
	movl $1882341361, %r8d
.main_8:
	movl %r8d, %esi
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_6
.main_2:
.main_10:
	movl %edx, %ecx
.main_3:
	movl $1, %r8d
	movl %esi, %r9d
	cmpl %ecx, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_4:
	movl %ecx, %r9d
	subl %esi, %r9d
.main_9:
	movl %r9d, %ecx
	jmp .main_3
.main_5:
	movl %ecx, %r9d
	movl %esi, %r8d
.main_7:
	movl %r9d, %esi
	movl %r8d, %edx
	jmp .main_1
.main_6:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
