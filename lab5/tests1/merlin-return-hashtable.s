.file	"../tests1/merlin-return-hashtable.l4"
.globl _c0_main
_c0_chain_insert:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.chain_insert_0:
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	movq $0, %rdx
	movq %rdi, %rcx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .chain_insert_2
.chain_insert_1:
	movq %r8, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.chain_insert_2:
.chain_insert_9:
.chain_insert_3:
	movq $0, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .chain_insert_5
.chain_insert_4:
	movq $0, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
.chain_insert_8:
	movq %rcx, %rdi
	jmp .chain_insert_3
.chain_insert_5:
	movq $0, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq %r8, (%rcx)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_chain_search:
	addq $-8, %rsp
.chain_search_0:
	movq %rsi, %r8
.chain_search_9:
	movq %r8, %rdx
.chain_search_1:
	movq $0, %r8
	cmpq %r8, %rdx
	jnz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movq $8, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %ecx
	cmpl %edi, %ecx
	setne %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .chain_search_3
.chain_search_2:
	movq $0, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq (%r8), %r8
.chain_search_8:
	movq %r8, %rdx
	jmp .chain_search_1
.chain_search_3:
	movl $1, %ecx
	movq $0, %r8
	movq %rdx, %r9
	cmpq %r8, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .chain_search_5
.chain_search_4:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.chain_search_5:
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_hash:
	addq $-8, %rsp
.hash_0:
	movl %edi, %ecx
	addl $2127912214, %ecx
	movl %edi, %r8d
	sall $12, %r8d
	movl %ecx, %r9d
	addl %r8d, %r9d
	movl %r9d, %r8d
	xorl $-949894596, %r8d
	sarl $19, %r9d
	xorl %r9d, %r8d
	movl %r8d, %r9d
	addl $374761393, %r9d
	sall $5, %r8d
	addl %r8d, %r9d
	movl %r9d, %r8d
	addl $-744332180, %r8d
	sall $9, %r9d
	xorl %r9d, %r8d
	movl %r8d, %r9d
	addl $-42973499, %r9d
	sall $3, %r8d
	addl %r8d, %r9d
	movl %r9d, %r8d
	xorl $-1252372727, %r8d
	sarl $16, %r9d
	movl %r8d, %edx
	xorl %r9d, %edx
	movl $1, %ecx
	movl $0, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .hash_2
.hash_1:
	movl $0, %eax
	subl %edx, %eax
	addq $8, %rsp
	ret
.hash_2:
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_insert:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
	movq %rdx, %rcx
.insert_0:
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_hash
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl %r8d, %edx
	imull $12, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq $0, %rsi
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rdx, %rdi
	movq %rcx, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_chain_insert
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %ecx
	imull $12, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r9
	movq $0, %rcx
	addq %rcx, %r9
	movq %rax, (%r9)
	movl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_lookup:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %edx, %ecx
.lookup_0:
	movl %ecx, %edi
	movq %rsi, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_hash
	movq %r13, %rsi
	movq %r12, %rcx
	movq %rbx, %r9
	cltd
	idivl %esi
	movl %edx, %r8d
	imull $12, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movq $0, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movl %ecx, %edi
	movq %r9, %rsi
	callq _c0_chain_search
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_get_new:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.get_new_0:
	movq $1, %rdi
	movq $12, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $64, %r9d
	movq $64, %rdi
	movq $12, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
.main_15:
	movl %ecx, %edi
.main_1:
	movl $1, %ecx
	movl %edi, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_3
.main_2:
	movl %edi, %ecx
	imull $12, %ecx
	movslq %ecx, %rcx
	movq %r8, %rsi
	addq %rcx, %rsi
	movq $8, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	subl $1, (%rcx)
	movl %edi, %ecx
	imull $12, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movq $0, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.main_14:
	movl %ecx, %edi
	jmp .main_1
.main_3:
	movl $0, %ecx
.main_17:
.main_4:
	movl $1, %edi
	movl $-889275714, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_5:
	movl %ecx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_get_new
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl %r9d, %esi
	movq %rax, %rdx
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %ecx
.main_16:
	jmp .main_4
.main_6:
	movl $0, %ecx
.main_19:
.main_7:
	movl $1, %edi
	movl $-889275714, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_13
.main_8:
	movq %r8, %rdi
	movl %r9d, %esi
	movl %ecx, %edx
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_lookup
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %edx
	movl %eax, %esi
	cmpl %edx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_11
.main_9:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_11:
.main_12:
	addl $1, %ecx
.main_18:
	jmp .main_7
.main_13:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
