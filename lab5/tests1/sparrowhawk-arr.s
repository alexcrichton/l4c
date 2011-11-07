.file	"../tests1/sparrowhawk-arr.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1000, %rdi
	movq $4, %rsi
	callq calloc
	movl $0, %edi
	movl $0, %r9d
.main_14:
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $1000, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl %edx, (%r9)
	addl $1, (%r9)
	movl %edx, %r9d
	addl $1, %r9d
.main_13:
	movl %r9d, %edx
	jmp .main_1
.main_3:
	movl $0, %r9d
.main_16:
	movl %r9d, %esi
.main_4:
	movl $1, %ecx
	movl $999, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_5:
	movl $0, %r9d
.main_18:
	movl %r9d, %edx
.main_6:
	movl $1, %ecx
	movl $999, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_8
.main_7:
	movl %edx, %r9d
	addl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl %ecx, (%r9)
	movl %edx, %r9d
	addl $1, %r9d
.main_17:
	movl %r9d, %edx
	jmp .main_6
.main_8:
	movl %esi, %r9d
	addl $1, %r9d
.main_15:
	movl %r9d, %esi
	jmp .main_4
.main_9:
	movl $0, %r9d
.main_20:
	movl %edi, %esi
	movl %r9d, %edx
.main_10:
	movl $1, %ecx
	movl $1000, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_12
.main_11:
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %esi, %r8d
	addl %r9d, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_19:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_10
.main_12:
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
