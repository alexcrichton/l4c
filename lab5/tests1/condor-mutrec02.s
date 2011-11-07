.file	"../tests1/condor-mutrec02.l3"
.globl _c0_main
_c0_even:
	addq $-8, %rsp
.even_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .even_2
.even_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.even_2:
	subl $1, %edi
	callq _c0_odd
	addq $8, %rsp
	ret
_c0_odd:
	addq $-8, %rsp
.odd_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .odd_2
.odd_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.odd_2:
	subl $1, %edi
	callq _c0_even
	addq $8, %rsp
	ret
_c0_toInt:
	addq $-8, %rsp
.toInt_0:
	cmpl $0, %edi
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
	movl $6, %r9d
	movl %r9d, %edi
	callq _c0_even
	movl %eax, %edi
	callq _c0_toInt
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
