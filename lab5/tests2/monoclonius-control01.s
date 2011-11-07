.file	"../tests2/monoclonius-control01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_1:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_19
.main_2:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_6:
	movl $5, %r8d
.main_15:
.main_8:
	movl $1, %edx
	movl $5, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_10
.main_9:
	movl $1, %r8d
.main_17:
.main_11:
	jmp .main_18
.main_10:
.main_16:
	movl %r9d, %r8d
	jmp .main_11
.main_3:
.main_4:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_7
.main_5:
	jmp .main_4
.main_7:
	movl $7, %r8d
.main_14:
	jmp .main_8
.main_19:
.main_13:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_18:
	movl %r8d, %r9d
	jmp .main_13
.ident	"15-411 L4 reference compiler"
