.file	"../tests1/kestrel-runtime4.l3"
.globl _c0_main
_c0_summer:
	addq $-8, %rsp
.summer_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .summer_3
.summer_1:
	movl %edi, %eax
	addq $8, %rsp
	ret
.summer_3:
.summer_4:
	subl $1, %edi
	callq _c0_summer
	movl $1, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $195935983, %edi
	callq _c0_summer
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
