.file	"../tests2/dilophosaurus-ifs.l3"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $0, %r14d
	movl $1, %esi
	movl $2, %edi
	movl %r14d, %eax
	cltd
	idivl %esi
	movl $1, %eax
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_1
.main_23:
	movl %r14d, %r9d
	addl $32, %r9d
.main_40:
	movl %r9d, %edx
.main_25:
	movl %edx, %eax
	addl $2158857, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_1:
	cmpl %r14d, %esi
	jz .ternary_true3
	movl %r14d, %eax
	addl $2, %eax
	movl %edi, %edx
	cmpl %eax, %edx
	setle %dl
	movzbl %dl, %edx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %edx
.ternary_end4:
	cmpl $0, %edx
	jnz .ternary_true1
	movl $0, %eax
	movl $0, %r15d
	cltd
	idivl %r15d
	movl $1, %r15d
	cmpl %r15d, %eax
	sete %al
	movzbl %al, %eax
	jmp .ternary_end2
.ternary_true1:
	movl $1, %eax
.ternary_end2:
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_22
.main_2:
	movl $100, %edx
.main_27:
	movl %edx, %ebx
	movl %r14d, %r15d
.main_3:
	movl $1, %eax
	movl $0, %edx
	cmpl %ebx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_5
.main_4:
	movl $2, %r13d
	movl %ebx, %eax
	cltd
	idivl %r13d
	movl %r15d, %eax
	addl %edx, %eax
	movl %ebx, %edx
	subl $1, %edx
.main_26:
	movl %edx, %ebx
	movl %eax, %r15d
	jmp .main_3
.main_5:
	movl $5, %r13d
.main_29:
.main_6:
	movl $1, %eax
	movl %ebx, %edx
	cmpl %r13d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_21
.main_7:
	movl %r13d, %eax
	cltd
	idivl %r15d
	movl %r15d, %ecx
	addl %ebx, %ecx
	subl %edx, %ecx
	movl %r13d, %ecx
.main_31:
	movl %ecx, %edx
.main_8:
	movl $1, %eax
	movl $0, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %eax
	jnz .main_10
.main_9:
	movl %r15d, %eax
	movl %edx, %ecx
	sall %cl, %eax
	movl %edx, %ecx
	subl $1, %ecx
.main_30:
	movl %ecx, %edx
	movl %eax, %r15d
	jmp .main_8
.main_10:
.main_34:
	movl %edx, %ebp
	movl %r15d, %ecx
.main_11:
	movl $1, %r15d
	movl $42, %eax
	movl %ebp, %edx
	cmpl %eax, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %r15d
	jnz .main_20
.main_12:
	movl %ebp, %r12d
	addl $5, %r12d
	movl $2, %r8d
	movl %r12d, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %r15d
	movl $0, %edx
	movl %r8d, %eax
	cmpl %edx, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %r15d
	jnz .main_14
.main_13:
	jmp .main_33
.main_14:
	movl $3, %r15d
	movl %r12d, %eax
	cltd
	idivl %r15d
	movl %edx, %r15d
	movl $1, %edx
	movl $0, %ebp
	movl %r15d, %eax
	cmpl %ebp, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %edx
	jnz .main_16
.main_15:
	movl %ecx, %eax
	cltd
	idivl %r12d
	movl %eax, %ecx
.main_36:
	movl %ecx, %edx
.main_18:
.main_19:
.main_32:
	movl %eax, %r9d
	movl %r12d, %ebp
	movl %edx, %ecx
	jmp .main_11
.main_16:
	movl %ecx, %edx
	subl %r12d, %edx
.main_35:
	movl %r9d, %eax
	jmp .main_18
.main_20:
	movl %ebx, %edx
	addl $1, %edx
.main_28:
	movl %edx, %ebx
	movl %ecx, %r15d
	jmp .main_6
.main_21:
.main_38:
	movl %r13d, %ebp
	movl %ebx, %eax
	movl %r15d, %edx
.main_24:
.main_39:
	jmp .main_25
.main_22:
	movl %r14d, %edx
	addl $42, %edx
.main_37:
	movl %edi, %ebp
	movl %esi, %eax
	jmp .main_24
.main_33:
	movl %r12d, %ebp
	jmp .main_11
.ident	"15-411 L4 reference compiler"
