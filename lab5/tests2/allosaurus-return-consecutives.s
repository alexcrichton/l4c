.file	"../tests2/allosaurus-return-consecutives.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $10022, %r9d
	movl $0, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl $10, %edx
.main_8:
	movl %edx, %ebx
.main_1:
	movl %r9d, %eax
	cltd
	idivl %ebx
	movl $1, %edi
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_2:
	movl %r9d, %eax
	cltd
	idivl %ebx
	movl %edx, %esi
	movl $10, %edi
	movl %ebx, %eax
	cltd
	idivl %edi
	movl %eax, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %eax, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %r8d, %edx
	jl .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %r8d
	cmpl %edx, %r8d
	jnz .main_4
.main_3:
	movl %ecx, %r8d
	addl $1, %r8d
.main_10:
	movl %r8d, %edx
.main_5:
	movl %esi, %r8d
	movl %ebx, %edi
	imull $10, %edi
.main_7:
	movl %edx, %ecx
	movl %edi, %ebx
	jmp .main_1
.main_4:
.main_9:
	movl %ecx, %edx
	jmp .main_5
.main_6:
	movl %ecx, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
