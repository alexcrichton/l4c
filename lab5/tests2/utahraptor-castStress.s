.file	"../tests2/utahraptor-castStress.l3"
.globl _c0_main
_c0_castInt:
	addq $-8, %rsp
.castInt_0:
	movl $1, %r8d
	movl %edi, %eax
	cmpl %r8d, %eax
	setne %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_castBool:
	addq $-8, %rsp
.castBool_0:
	movl $1, %r8d
	cmpl %edi, %r8d
	jnz .castBool_3
.castBool_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.castBool_3:
.castBool_4:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r8d
	movl $0, %r9d
.main_5:
	movl %r8d, %esi
.main_1:
	movl $1, %edx
	movl $100000000, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_castInt
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_castBool
	movq %rbx, %r9
	movl %eax, %r8d
	addl $1, %r9d
.main_4:
	movl %r8d, %esi
	jmp .main_1
.main_3:
	movl %esi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
