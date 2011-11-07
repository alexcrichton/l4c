.file	"../tests2/apatosaurus-fn-sum01.l3"
.globl _c0_main
_c0_sum:
	addq $-8, %rsp
	movl %esi, %r8d
	movl %edx, %esi
.sum_0:
	movl $1, %ecx
	movl %r8d, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .sum_2
.sum_1:
	movl %esi, %eax
	addq $8, %rsp
	ret
.sum_2:
	movl %edi, %edx
	addl $1, %edx
	movl %r8d, %ecx
	movl %esi, %r8d
	addl %edi, %r8d
	movl %edx, %edi
	movl %ecx, %esi
	movl %r8d, %edx
	callq _c0_sum
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movl $1, %edi
	movl $100, %esi
	movl $0, %edx
	movq %r9, %rbx
	callq _c0_sum
	movq %rbx, %r9
	movl %eax, %r8d
	movl $100, %eax
	imull $101, %eax
	movl $2, %ecx
	cltd
	idivl %ecx
	movl $1, %ecx
	cmpl %eax, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	movl $1, %r8d
.main_13:
	movl %r8d, %esi
.main_5:
	movl $1, %edx
	movl $999, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_6:
	addl %esi, %r9d
	movl %esi, %r8d
	addl $1, %r8d
.main_12:
	movl %r8d, %esi
	jmp .main_5
.main_7:
	movl $1, %edi
	movl $999, %esi
	movl $0, %edx
	movq %r9, %rbx
	callq _c0_sum
	movq %rbx, %r9
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %r9d, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_10
.main_8:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
.main_11:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
