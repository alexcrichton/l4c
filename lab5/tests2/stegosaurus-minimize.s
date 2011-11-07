.file	"../tests2/stegosaurus-minimize.l3"
.globl _c0_main
_c0_f:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.f_0:
	movl %r9d, %edi
	movl %r9d, %esi
	movq %r9, %rbx
	callq fmul
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r8d, %edi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fmul
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $0, %edi
	subl $8, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movl %r8d, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq fmul
	movq %r12, %rcx
	movq %rbx, %r9
	movl %ecx, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fadd
	movq %rbx, %r9
	movl %eax, %r8d
	movl $5, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movl %r9d, %esi
	movq %r8, %rbx
	callq fmul
	movq %rbx, %r8
	movl %r8d, %edi
	movl %eax, %esi
	callq fadd
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %edi
	callq tofloat
	movl %eax, %edi
	callq _c0_localmin
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
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_localmin:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.localmin_0:
	movl %edi, %r9d
	movl $1, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %r8d
	movl $10000, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fdiv
	movq %rbx, %r9
	movl %eax, %r8d
	movl $-2147483648, %ecx
.localmin_12:
	movl %r9d, %ebx
.localmin_1:
	movl $1, %edx
	movl $1, %r9d
	cmpl %r9d, %edx
	jnz .localmin_10
.localmin_2:
	movl %ebx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	callq _c0_f
	movq %r13, %rcx
	movq %r12, %r8
	movl %eax, %r9d
	movl %ebx, %edi
	movl %r8d, %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq fsub
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edx
	movl %ebx, %edi
	movl %r8d, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq fadd
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl %edx, %edi
	movl %r9d, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq fsub
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %edi
	movl %eax, %edx
	andl %ecx, %edx
	movl $0, %esi
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .localmin_3
.localmin_7:
	movl %ebx, %edi
	movl %r8d, %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq fsub
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl %eax, %esi
.localmin_14:
	movl %esi, %edx
.localmin_9:
.localmin_11:
	movl %edx, %ebx
	jmp .localmin_1
.localmin_3:
	movl %r12d, %edi
	movl %r9d, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq fsub
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl $1, %eax
	movl %edx, %edi
	andl %ecx, %edi
	movl $0, %esi
	cmpl %esi, %edi
	setne %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .localmin_4
.localmin_5:
	movl %ebx, %edi
	movl %r8d, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq fadd
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %esi
.localmin_8:
.localmin_13:
	movl %esi, %edx
	jmp .localmin_9
.localmin_4:
	movl %ebx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.localmin_10:
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
