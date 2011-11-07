.file	"../tests2/dilophosaurus-null.l4"
.globl _c0_main
_c0_comp:
	addq $-8, %rsp
.comp_0:
	cmpl $0, %edi
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %esi, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r8
	movq $0, %r9
	cmpq %r9, %r8
	sete %dil
	movzbl %dil, %edi
	movl $1, %esi
	callq _c0_comp
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
