.file	"../tests1/kestrel-fun1.l3"
.globl _c0_main
_c0_fun1:
	addq $-8, %rsp
.fun1_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .fun1_3
.fun1_1:
	movl $42, %eax
	addq $8, %rsp
	ret
.fun1_3:
.fun1_4:
	callq _c0_fun2
	addq $8, %rsp
	ret
_c0_fun2:
	addq $-8, %rsp
.fun2_0:
	callq _c0_fun3
	addq $8, %rsp
	ret
_c0_fun3:
	addq $-8, %rsp
.fun3_0:
	subl $1, %edi
	callq _c0_fun1
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %edi
	callq _c0_fun1
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
