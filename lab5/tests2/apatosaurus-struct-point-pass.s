.file	"../tests2/apatosaurus-struct-point-pass.l4"
.globl _c0_main
_c0_edit:
	addq $-8, %rsp
.edit_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $10, (%r8)
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $10, (%r8)
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl $1, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $12, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $25, (%r8)
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $25, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_edit
	movq %rbx, %r9
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $8, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $10, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $15, %r8d
.ternary_end2:
	movl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
