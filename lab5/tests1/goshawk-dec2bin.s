.file	"../tests1/goshawk-dec2bin.l3"
.globl _c0_main
_c0_dec2bin:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.dec2bin_0:
	movl $1, %ecx
	movl $0, %r8d
	movl %r9d, %edx
	cmpl %r8d, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .dec2bin_3
.dec2bin_1:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.dec2bin_3:
.dec2bin_4:
	movl $2, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_dec2bin
	movq %rbx, %r9
	movl $2, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1337, %edi
	callq _c0_dec2bin
	movl $10, %edi
	callq printchar
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
