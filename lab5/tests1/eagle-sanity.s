.file	"../tests1/eagle-sanity.l3"
.globl _c0_main
_c0_add:
	addq $-8, %rsp
.add_0:
	movl %edi, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
_c0_mod:
	addq $-8, %rsp
	movl %edi, %eax
.mod_0:
	cltd
	idivl %esi
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_div:
	addq $-8, %rsp
	movl %edi, %eax
.div_0:
	cltd
	idivl %esi
	addq $8, %rsp
	ret
_c0_sub:
	addq $-8, %rsp
.sub_0:
	movl %edi, %eax
	subl %esi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %edi
	movl $2, %esi
	callq _c0_sub
	movl $5, %edi
	movl %eax, %esi
	callq _c0_mod
	movl $6, %edi
	movl %eax, %esi
	callq _c0_div
	movl $3, %edi
	movl %eax, %esi
	callq _c0_add
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
