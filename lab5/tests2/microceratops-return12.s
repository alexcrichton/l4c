.file	"../tests2/microceratops-return12.l3"
.globl _c0_main
_c0_revBits:
	addq $-8, %rsp
	movl %edi, %r9d
.revBits_0:
	movl $0, %ecx
	movl $0, %r8d
.revBits_5:
	movl %ecx, %edi
	movl %r8d, %esi
	movl %r9d, %edx
.revBits_1:
	movl $1, %ecx
	movl $32, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .revBits_3
.revBits_2:
	movl %edi, %ecx
	addl $1, %ecx
	movl %esi, %r8d
	sall $1, %r8d
	movl %edx, %r9d
	andl $1, %r9d
	orl %r9d, %r8d
	movl %edx, %r9d
	sarl $1, %r9d
.revBits_4:
	movl %ecx, %edi
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .revBits_1
.revBits_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $242, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_revBits
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_revBits
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_revBits
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_revBits
	movq %rbx, %r9
	movl %eax, %edi
	cmpl %r9d, %edi
	sete %dil
	movzbl %dil, %edi
	callq booltoint
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
