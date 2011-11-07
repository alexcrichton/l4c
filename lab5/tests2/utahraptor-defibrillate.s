.file	"../tests2/utahraptor-defibrillate.l4"
.globl _c0_main
_c0_defibrillate:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %esi, %edi
.defibrillate_0:
	movl $1, %r8d
	movl $1, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .defibrillate_3
.defibrillate_1:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.defibrillate_3:
.defibrillate_4:
	movl %edi, %r8d
	addl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl %edi, %r8d
	subl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %esi, (%r8)
	subl %edx, (%r8)
	movq %r9, %r8
	movl %edi, %esi
	subl $1, %esi
	movq %r8, %rdi
	callq _c0_defibrillate
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $41, %rdi
	movq $4, %rsi
	callq calloc
	movl $40, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %rax, %r8
	addq %r9, %r8
	movl $102334155, (%r8)
	movl $39, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $63245986, (%r9)
	movq %rax, %rdi
	movl $39, %esi
	callq _c0_defibrillate
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
