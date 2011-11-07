.file	"../tests2/styracosaurus-e.l3"
.globl _c0_main
_c0_power:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.power_0:
	movl $1, %edx
	movl $0, %ecx
	movl %r8d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .power_3
.power_1:
	movl $1, %edi
	callq tofloat
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.power_3:
.power_4:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl $1, %ecx
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .power_6
.power_5:
	movl %r9d, %edi
	movl %r9d, %esi
	movq %r8, %rbx
	callq fmul
	movq %rbx, %r8
	movl %eax, %edi
	movl %r8d, %esi
	sarl $1, %esi
	callq _c0_power
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.power_6:
	movl %r9d, %edi
	movl %r9d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fmul
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movl %r8d, %esi
	sarl $1, %esi
	movq %r9, %rbx
	callq _c0_power
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq fmul
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_approx:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.approx_0:
	movl $1, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fadd
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r8d, %edi
	movl %r9d, %esi
	callq _c0_power
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1000000, %edi
	callq _c0_approx
	movl %eax, %r9d
	movl $10, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printfloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
