.file	"../tests2/microceratops-return04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %ecx
	movl $1023, %r8d
	movl $2, %r9d
.main_11:
.main_1:
	movl $1, %esi
	movl %r9d, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_9
.main_2:
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl $1, %edi
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_6:
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %edx
	movl %ecx, %r8d
	addl %r9d, %r8d
.main_15:
	movl %r9d, %edi
	movl %edx, %esi
	movl %r8d, %edx
.main_8:
.main_10:
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %ecx
	jmp .main_1
.main_3:
	movl $1, %edi
	movl $2, %esi
	movl %r9d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_5
.main_4:
	movl %r9d, %edx
	addl $1, %edx
.main_13:
.main_7:
.main_14:
	movl %edx, %edi
	movl %r8d, %esi
	movl %ecx, %edx
	jmp .main_8
.main_5:
	movl %r9d, %edx
	addl $2, %edx
.main_12:
	jmp .main_7
.main_9:
	movl %ecx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
