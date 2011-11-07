.file	"../tests2/monoclonius-exception01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
	movl $5, %r8d
	cmpl %r8d, %eax
	jz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $0, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_2
.main_1:
	movl $3, %r9d
.main_5:
.main_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
.main_4:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
