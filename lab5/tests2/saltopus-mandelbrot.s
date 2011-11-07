.file	"../tests2/saltopus-mandelbrot.l4"
.globl _c0_main
_c0_init:
	addq $-8, %rsp
.init_0:
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $32, (%r8)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $46, (%r8)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $44, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $58, (%r8)
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $59, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $61, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $124, (%r8)
	movl $7, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $105, (%r8)
	movl $8, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $73, (%r8)
	movl $9, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $43, (%r8)
	movl $10, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $104, (%r8)
	movl $11, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $72, (%r8)
	movl $12, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $79, (%r8)
	movl $13, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $69, (%r8)
	movl $14, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $35, (%r8)
	movl $15, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $36, (%r8)
	movl $16, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl $45, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_cksum_start:
	addq $-8, %rsp
.cksum_start_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	addq $8, %rsp
	ret
_c0_cksum_update:
	addq $-8, %rsp
.cksum_update_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %eax
	addl %esi, %eax
	movl $65521, %r8d
	cltd
	idivl %r8d
	movq $0, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl %edx, (%rcx)
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %edx, %eax
	addl %r8d, %eax
	movl $65521, %r8d
	cltd
	idivl %r8d
	movl %edx, %ecx
	movq $4, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl %ecx, (%rdx)
	movq %rdi, %rax
	addq $8, %rsp
	ret
_c0_cksum_finish:
	addq $-8, %rsp
.cksum_finish_0:
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %ecx, %r9d
	sall $16, %r9d
	movl %r9d, %eax
	orl %r8d, %eax
	addq $8, %rsp
	ret
_c0_print_memoriam:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.print_memoriam_0:
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $10, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $73, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $73, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $110, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $109, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $109, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $101, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $109, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $109, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $111, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $114, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $114, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $121, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $121, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $111, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $102, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $102, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $66, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $66, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $101, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $110, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $111, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $105, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $105, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $116, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $77, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $77, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $97, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $97, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $110, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $100, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $100, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $101, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $108, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $98, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $114, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $114, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $111, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $116, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $40, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $40, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $49, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $49, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $57, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $57, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $50, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $50, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $52, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $52, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $45, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $45, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $50, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $50, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $48, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $48, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $49, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $49, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $48, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $48, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $41, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $41, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $10, %esi
	movq %r9, %rbx
	callq _c0_cksum_update
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $10, %esi
	callq _c0_cksum_update
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-136, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $79, %ecx
	movl $36, 88(%rsp)
	movl $0, %edx
	subl $65535, %edx
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_cksum_start
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movq $17, %rdi
	movq $4, %rsi
	movq %rdx, %rbp
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %rbp, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, 56(%rsp)
	movq 56(%rsp), %rdi
	movq %rdx, %rbp
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_init
	movq %rbp, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $0, %esi
.main_15:
	movl %esi, 92(%rsp)
	movl %edx, %r12d
.main_1:
	movl $1, %esi
	movl 92(%rsp), %edx
	cmpl 88(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_13
.main_2:
	movl $0, %esi
	subl $131072, %esi
	movl $0, %edx
.main_17:
	movl %esi, 96(%rsp)
	movl %edx, 100(%rsp)
.main_3:
	movl $1, %esi
	movl 100(%rsp), %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_12
.main_4:
	movl 96(%rsp), %ebp
	movl %r12d, %eax
	movl $0, %edi
	movl $0, %esi
.main_19:
	movl %r15d, %edx
	movl %esi, %r13d
	movl %edi, %r14d
	movl %eax, %r15d
	movl %ebp, %edi
.main_5:
	movl $1, %ebp
	movl $20, %esi
	movl %r13d, %eax
	cmpl %esi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %ebp
	jnz .main_21
.main_6:
	movl %edi, %esi
	sarl $4, %esi
	movl %r15d, %r9d
	sarl $4, %r9d
	movl %esi, %r8d
	imull %esi, %r8d
	movl %r8d, 104(%rsp)
	sarl $8, 104(%rsp)
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r8d, %ebp
	sarl $8, %ebp
	movl 104(%rsp), %r10d
	movl %r10d, 108(%rsp)
	addl %ebp, 108(%rsp)
	movl $1, %edx
	movl $262144, %r8d
	cmpl 108(%rsp), %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_9
.main_7:
	jmp .main_20
.main_9:
.main_10:
	movl %esi, %r8d
	imull %r9d, %r8d
	sarl $8, %r8d
	movl $2, %r9d
	imull %r8d, %r9d
	movl %r9d, %r15d
	addl %r12d, %r15d
	movl 104(%rsp), %r9d
	subl %ebp, %r9d
	movl %r9d, %eax
	addl 96(%rsp), %eax
	movl %r14d, %edi
	addl $1, %edi
	movl %r13d, %esi
	addl $1, %esi
.main_18:
	movl 108(%rsp), %edx
	movl %ebp, %r8d
	movl 104(%rsp), %r9d
	movl %esi, %r13d
	movl %edi, %r14d
	movl %eax, %edi
	jmp .main_5
.main_21:
	movl %edx, 108(%rsp)
	movl %r8d, 112(%rsp)
	movl %r9d, 116(%rsp)
	movl %r15d, 120(%rsp)
	movl %edi, 124(%rsp)
.main_11:
	movl $17, %r9d
	movl %r14d, %eax
	cltd
	idivl %r9d
	movl %edx, 128(%rsp)
	movl 128(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r9, %r15
	callq printchar
	movq %rbp, %rcx
	movq %r15, %r9
	movl %eax, %r8d
	movslq %r8d, %r15
	movl $17, %esi
	movl %r14d, %eax
	cltd
	idivl %esi
	movl %edx, %ebp
	movl %ebp, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 56(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %r10d
	movl %r10d, 104(%rsp)
	movq %rbx, %rdi
	movl 104(%rsp), %esi
	movq %rcx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_cksum_update
	movq 64(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movq %rax, %rsi
	movq %rsi, %rdi
	movl $196608, %eax
	cltd
	idivl %ecx
	movl %eax, 132(%rsp)
	movl 96(%rsp), %eax
	addl 132(%rsp), %eax
	movl 100(%rsp), %edx
	addl $1, %edx
.main_16:
	movl 108(%rsp), %r15d
	movl 112(%rsp), %r8d
	movl 116(%rsp), %r9d
	movl %eax, 96(%rsp)
	movl %edx, 100(%rsp)
	jmp .main_3
.main_12:
	movl $10, %edi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq printchar
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rbx, %rdi
	movl $10, %esi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_cksum_update
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $131072, %eax
	movl 88(%rsp), %esi
	subl $1, %esi
	cltd
	idivl %esi
	movl %r12d, %esi
	addl %eax, %esi
	movl 92(%rsp), %edx
	addl $1, %edx
.main_14:
	movl %edx, 92(%rsp)
	movl %esi, %r12d
	jmp .main_1
.main_13:
	movq %rbx, %rdi
	callq _c0_print_memoriam
	movq %rbx, %rdi
	callq _c0_cksum_finish
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $136, %rsp
	ret
.main_20:
	movl %ebp, 112(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 116(%rsp)
	movl %r9d, 120(%rsp)
	movl %esi, 124(%rsp)
	jmp .main_11
.ident	"15-411 L4 reference compiler"
