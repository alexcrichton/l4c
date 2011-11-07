.file	"../tests2/dilophosaurus-ternary.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .ternary_true1
	movl $9, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $2, %r8d
	movl $3, %r9d
	cmpl %r9d, %r8d
	jl .ternary_true3
	movl $8, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $4, %r8d
	movl $5, %r9d
	cmpl %r9d, %r8d
	jnz .ternary_true5
	movl $7, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $6, %r9d
.ternary_end6:
.ternary_end4:
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
