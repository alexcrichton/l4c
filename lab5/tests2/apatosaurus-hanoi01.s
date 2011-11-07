.file	"../tests2/apatosaurus-hanoi01.l3"
.globl _c0_main
_c0_hanoi:
	addq $-8, %rsp
.hanoi_0:
	movl $1, %edx
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .hanoi_2
.hanoi_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.hanoi_2:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .hanoi_5
.hanoi_3:
	subl $1, %edi
	callq _c0_hanoi
	movl $2, %r9d
	imull %eax, %r9d
	movl %r9d, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
.hanoi_5:
.hanoi_7:
.hanoi_8:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %edi
	callq _c0_hanoi
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
