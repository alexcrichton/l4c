.file	"../tests2/seismosaurus-return10.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	movl $42, %r9d
	movl $2, %r8d
.main_12:
.main_1:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_6
.main_2:
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $1, %edi
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_4
.main_3:
	movl $0, %ecx
.main_14:
	movl %ecx, %edx
.main_5:
	addl $1, %r8d
.main_11:
	movl %edx, %ecx
	jmp .main_1
.main_4:
.main_13:
	movl %ecx, %edx
	jmp .main_5
.main_6:
	movl $1, %edx
	movl $1, %r8d
	movl %ecx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .main_8
.main_7:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_8:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
