.file	"../tests2/ouranosaurus-binary_search.l3"
.globl _c0_main
_c0_search:
	addq $-8, %rsp
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %esi
.search_0:
	movl %esi, %eax
	subl %r8d, %eax
	movl $2, %ecx
	cltd
	idivl %ecx
	movl %r8d, %edi
	addl %eax, %edi
	movl $1, %edx
	movl %esi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .search_2
.search_1:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.search_2:
	movl $1, %edx
	movl %edi, %ecx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .search_4
.search_3:
	movl %edi, %eax
	addq $8, %rsp
	ret
.search_4:
	movl $1, %edx
	movl %r9d, %ecx
	cmpl %edi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .search_6
.search_5:
	movl %r9d, %ecx
	movl %r8d, %esi
	movl %edi, %edx
	subl $1, %edx
	movl %ecx, %edi
	callq _c0_search
	addq $8, %rsp
	ret
.search_6:
	movl %r9d, %ecx
	movl %edi, %r8d
	addl $1, %r8d
	movl %esi, %edx
	movl %ecx, %edi
	movl %r8d, %esi
	callq _c0_search
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1029, %edi
	movl $0, %esi
	movl $1000000, %edx
	callq _c0_search
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
