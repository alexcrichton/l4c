.file	"../tests2/stegosaurus-kittylan.l3"
.globl _c0_main
_c0_c:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.c_0:
	movl $0, %ecx
	cmpl %ecx, %r8d
	jz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $0, %ecx
	movl %ecx, %edx
	cmpl %r9d, %edx
	setle %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .c_3
.c_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.c_3:
.c_4:
	movl $1, %ecx
	movl $2, %esi
	imull %r8d, %esi
	movl %r9d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .c_7
.c_5:
	movl %r9d, %edi
	subl $1, %edi
	movl %r8d, %esi
	subl $1, %esi
	callq _c0_c
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.c_7:
.c_8:
	movl %r9d, %edi
	subl $1, %edi
	movl %r8d, %esi
	subl $1, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_c
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	subl $1, %edi
	movl %r8d, %esi
	movq %rcx, %rbx
	callq _c0_c
	movq %rbx, %rcx
	movl %ecx, %r8d
	addl %eax, %r8d
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $32, %edi
	movl $16, %esi
	callq _c0_c
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
