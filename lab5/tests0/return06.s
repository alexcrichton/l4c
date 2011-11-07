.file	"../tests0/return06.l3"
.globl _c0_main
_c0_newline:
	addq $-8, %rsp
.newline_0:
	movl $10, %edi
	callq printchar
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_isprint:
	addq $-8, %rsp
.isprint_0:
	movl $32, %r8d
	cmpl %edi, %r8d
	jle .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $126, %r8d
	movl %edi, %ecx
	cmpl %r8d, %ecx
	setle %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl %ecx, %eax
	addq $8, %rsp
	ret
_c0_print_ascii:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %esi, %r9d
.print_ascii_0:
.print_ascii_8:
	movl %edi, %r8d
.print_ascii_1:
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .print_ascii_6
.print_ascii_2:
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $61, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r8d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isprint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .print_ascii_4
.print_ascii_3:
	movl %r8d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
.print_ascii_10:
.print_ascii_5:
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_newline
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.print_ascii_7:
	jmp .print_ascii_1
.print_ascii_4:
.print_ascii_9:
	jmp .print_ascii_5
.print_ascii_6:
	movl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $32, %edi
	movl $127, %esi
	callq _c0_print_ascii
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
