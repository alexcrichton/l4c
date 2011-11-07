.file	"../tests2/velociraptor-return_17.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r9d
	movl $1, %esi
	movl $8, %edx
	movl $0, %ecx
	movl $0, %r8d
	cmpl %r8d, %ecx
	jz .ternary_true1
	movl %edx, %r8d
	addl %esi, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %r9d, %r8d
	subl %esi, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
