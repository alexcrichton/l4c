.file	"../tests2/ouranosaurus-bit_count.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-264586018, %r9d
	movl $0, %ecx
	movl $0, %r8d
.main_5:
	movl %ecx, %edi
	movl %r8d, %esi
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $32, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %r9d
	andl $1, %r9d
	movl %edi, %ecx
	addl %r9d, %ecx
	movl %edx, %r8d
	sarl $1, %r8d
	movl %esi, %r9d
	addl $1, %r9d
.main_4:
	movl %ecx, %edi
	movl %r9d, %esi
	movl %r8d, %edx
	jmp .main_1
.main_3:
	movl %edi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
