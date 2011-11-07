.file	"../tests2/seismosaurus-return03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %ecx
	movl $1000, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_6
.main_2:
	movl $5, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl $0, %ecx
	cmpl %ecx, %edx
	jz .ternary_true1
	movl $3, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl $0, %ecx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .main_4
.main_3:
	addl %r8d, %r9d
.main_10:
	movl %r9d, %ecx
.main_5:
	addl $1, %r8d
.main_7:
	movl %ecx, %r9d
	jmp .main_1
.main_4:
.main_9:
	movl %r9d, %ecx
	jmp .main_5
.main_6:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
