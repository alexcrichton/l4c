.file	"../tests2/utahraptor-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1996, %r9d
	movl $4, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $0, %ecx
	cmpl %ecx, %edx
	jz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $100, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $0, %ecx
	cmpl %ecx, %edx
	jz .ternary_true3
	movl $1, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $400, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $0, %ecx
	movl %edx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end4:
.ternary_end2:
	movl $1900, %ecx
	movl $4, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	jz .ternary_true5
	movl $0, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $100, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	jz .ternary_true7
	movl $1, %edx
	jmp .ternary_end8
.ternary_true7:
	movl $400, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	sete %dl
	movzbl %dl, %edx
.ternary_end8:
	movl %edx, %r9d
.ternary_end6:
	movl %r9d, %ecx
	movl $2000, %esi
	movl $4, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	jz .ternary_true9
	movl $0, %r9d
	jmp .ternary_end10
.ternary_true9:
	movl $100, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	jz .ternary_true11
	movl $1, %edx
	jmp .ternary_end12
.ternary_true11:
	movl $400, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movl $0, %r9d
	cmpl %r9d, %edx
	sete %dl
	movzbl %dl, %edx
.ternary_end12:
	movl %edx, %r9d
.ternary_end10:
	movl %r9d, %edx
	cmpl $0, %r8d
	jnz .ternary_true15
	movl $0, %r9d
	jmp .ternary_end16
.ternary_true15:
	movl $1, %r9d
	xorl %ecx, %r9d
.ternary_end16:
	cmpl $0, %r9d
	jnz .ternary_true13
	movl $0, %r9d
	jmp .ternary_end14
.ternary_true13:
	movl %edx, %r9d
.ternary_end14:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_3
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
