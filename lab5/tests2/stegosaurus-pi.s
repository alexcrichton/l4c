.file	"../tests2/stegosaurus-pi.l3"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $1, %edi
	callq tofloat
	movl %eax, %r9d
	movl $0, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %ecx
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %edi
	movl $20000000, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_2:
	movl $2, %edx
	imull %r8d, %edx
	movl %edx, %edi
	addl $1, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $2, %esi
	movl %r8d, %eax
	cltd
	idivl %esi
	movl $1, %esi
	movl $0, %edi
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_4
.main_3:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq fdiv
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edx
	movl %ecx, %edi
	movl %edx, %esi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq fadd
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %ecx
.main_10:
	movl %ecx, %edx
.main_5:
	addl $1, %r8d
.main_7:
	movl %edx, %ecx
	jmp .main_1
.main_4:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq fdiv
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edx
	movl %ecx, %edi
	movl %edx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq fsub
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edi
.main_9:
	movl %edi, %edx
	jmp .main_5
.main_6:
	movl $4, %edi
	movq %rcx, %rbx
	callq tofloat
	movq %rbx, %rcx
	movl %ecx, %edi
	movl %eax, %esi
	callq fmul
	movl %eax, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq printfloat
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
