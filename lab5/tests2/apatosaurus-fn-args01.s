.file	"../tests2/apatosaurus-fn-args01.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl %esi, %r8d
	imull %edx, %r8d
	movl %edi, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r8d
	movl $0, %r9d
	cmpl $0, %r8d
	jnz .ternary_true3
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $3, %r8d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $3, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
.ternary_end2:
	movl %r8d, %edi
	movl %r9d, %esi
	movl $3, %edx
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
