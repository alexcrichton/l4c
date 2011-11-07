.file	"../tests2/velociraptor-return_04.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $7, %r12d
	movl $11, %r15d
	movl $1, %r13d
	movl $1, %esi
	movl $1, %edi
	movl $2, %edx
.main_27:
	movl %edx, %ebx
.main_1:
	movl $1, %eax
	movl %ebx, %edx
	cmpl %r12d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_29
.main_2:
	movl %r12d, %eax
	cltd
	idivl %ebx
	movl %edx, %ecx
	movl $1, %edx
	movl $0, %ebp
	movl %ecx, %eax
	cmpl %ebp, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %edx
	jnz .main_5
.main_3:
	movl $0, %r14d
	jmp .main_28
.main_5:
.main_6:
	movl %ebx, %edx
	addl $1, %edx
.main_26:
	movl %edx, %ebx
	jmp .main_1
.main_29:
	movl %r13d, %ebx
.main_7:
	movl $2, %edx
.main_31:
	movl %edx, %r13d
.main_8:
	movl $1, %eax
	movl %r13d, %edx
	cmpl %r15d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_33
.main_9:
	movl %r15d, %eax
	cltd
	idivl %r13d
	movl %edx, %r8d
	movl $1, %ebp
	movl $0, %eax
	movl %r8d, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ebp
	jnz .main_12
.main_10:
	movl $0, %r9d
	jmp .main_32
.main_12:
.main_13:
	movl %r13d, %edx
	addl $1, %edx
.main_30:
	movl %edx, %r13d
	jmp .main_8
.main_33:
.main_14:
	movl $2, %edx
.main_35:
	movl %edx, %r13d
.main_15:
	movl $1, %ebp
	movl %r12d, %eax
	imull %r15d, %eax
	movl %r13d, %edx
	cmpl %eax, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ebp
	jnz .main_37
.main_16:
	movl %r12d, %eax
	imull %r15d, %eax
	cltd
	idivl %r13d
	movl %edx, %ebp
	movl $1, %eax
	movl $0, %edx
	movl %ebp, 52(%rsp)
	cmpl %edx, 52(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 52(%rsp)
	cmpl 52(%rsp), %eax
	jnz .main_19
.main_17:
	movl $0, %edx
	jmp .main_36
.main_19:
.main_20:
	movl %r13d, %edx
	addl $1, %edx
.main_34:
	movl %edx, %r13d
	jmp .main_15
.main_37:
	movl %edi, %edx
.main_21:
	movl $1, %r9d
	cmpl %edx, %r9d
	jnz .main_23
.main_22:
	movl %r12d, %r9d
	imull %r15d, %r9d
	movl %r12d, %r8d
	subl %r9d, %r8d
	cmpl $0, %ebx
	jnz .ternary_true1
	movl %r15d, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $56, %rsp
	ret
.main_23:
	movl %r12d, %r9d
	imull %r15d, %r9d
	movl %r15d, %r8d
	addl %r9d, %r8d
	cmpl $0, %esi
	jnz .ternary_true3
	movl %r12d, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %r8d, %r9d
.ternary_end4:
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $56, %rsp
	ret
.main_36:
	jmp .main_21
.main_32:
	movl %r9d, %ebx
	jmp .main_14
.main_28:
	movl %r14d, %ebx
	jmp .main_7
.ident	"15-411 L4 reference compiler"
