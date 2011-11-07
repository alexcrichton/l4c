.file	"../tests2/triceratops-ret08.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movq $2000, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
.main_14:
	movl %ecx, %edi
.main_1:
	movl $1, %esi
	movl $2000, %ecx
	movl %edi, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_6
.main_2:
	movl $0, %ecx
.main_16:
	movl %ecx, %esi
.main_3:
	movl $1, %eax
	movl $2000, %ecx
	movl %esi, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_5
.main_4:
	movl %edi, %eax
	imull %esi, %eax
	movl $4, %ecx
	cltd
	idivl %ecx
	movl %edx, %ebx
	movl %ebx, %ecx
	imull $16, %ecx
	movslq %ecx, %rcx
	movq %r8, %rax
	addq %rcx, %rax
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl %edi, (%rcx)
	movl (%rcx), %r11d
	imull %esi, %r11d
	movl %r11d, (%rcx)
	movl %esi, %ecx
	addl $1, %ecx
.main_15:
	movl %ecx, %esi
	jmp .main_3
.main_5:
	movl %edi, %ecx
	addl $1, %ecx
.main_13:
	movl %ecx, %edi
	jmp .main_1
.main_6:
	movl $0, %ecx
.main_18:
	movl %r9d, %esi
	movl %ecx, %edi
.main_7:
	movl $1, %edx
	movl $2000, %ecx
	movl %edi, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .main_12
.main_8:
	movl $0, %ecx
.main_20:
	movl %esi, %r9d
.main_9:
	movl $1, %eax
	movl $2000, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_11
.main_10:
	movl %edi, %eax
	imull %ecx, %eax
	movl $4, %esi
	cltd
	idivl %esi
	movl %edx, %esi
	movl %esi, %edx
	imull $16, %edx
	movslq %edx, %rdx
	movq %r8, %rax
	addq %rdx, %rax
	movq $0, %rdx
	addq %rdx, %rax
	movl (%rax), %edx
	addl %edx, %r9d
	addl $1, %ecx
.main_19:
	jmp .main_9
.main_11:
	movl %edi, %edx
	addl $1, %edx
.main_17:
	movl %r9d, %esi
	movl %edx, %edi
	jmp .main_7
.main_12:
	movl %esi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
