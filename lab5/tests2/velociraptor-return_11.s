.file	"../tests2/velociraptor-return_11.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl $0, %edx
	subl $9, %edx
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %edx, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_3
.main_2:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
	movl $4, %eax
	addq $8, %rsp
	ret
.main_6:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %edx, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_8
.main_7:
	movl $2, %eax
	addq $8, %rsp
	ret
.main_8:
	movl $3, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
