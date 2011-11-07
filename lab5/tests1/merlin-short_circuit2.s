.file	"../tests1/merlin-short_circuit2.l3"
.globl _c0_main
_c0_i_loop_u_loop:
	addq $-8, %rsp
.i_loop_u_loop_0:
.i_loop_u_loop_1:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .i_loop_u_loop_7
.i_loop_u_loop_2:
	movl $1, %ecx
	movl $1, %r9d
	movl $0, %r8d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .i_loop_u_loop_5
.i_loop_u_loop_3:
	jmp .i_loop_u_loop_7
.i_loop_u_loop_5:
.i_loop_u_loop_6:
	jmp .i_loop_u_loop_1
.i_loop_u_loop_7:
	movl $0, %eax
	addq $8, %rsp
	ret
	jmp .i_loop_u_loop_7
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r8d
.main_9:
.main_1:
	movl $1, %esi
	movl $99, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_11
.main_2:
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_i_loop_u_return
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	cmpl $0, %ecx
	jnz .ternary_true1
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_i_loop_u_loop
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
	movl %r9d, %esi
	jmp .ternary_end2
.ternary_true1:
	movl $1, %esi
.ternary_end2:
	movl $1, %edx
	cmpl %esi, %edx
	jnz .main_5
.main_3:
	jmp .main_10
.main_5:
.main_6:
	addl $1, %r8d
.main_8:
	jmp .main_1
.main_11:
.main_7:
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
	jmp .main_7
_c0_i_loop_u_return:
	addq $-8, %rsp
.i_loop_u_return_0:
	jmp .ternary_true5
	movl $1, %r9d
	xorl $1, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $1, %r9d
.ternary_end6:
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
	xorl $1, %r9d
	jmp .ternary_end10
.ternary_true9:
	movl $1, %r9d
.ternary_end10:
	cmpl $0, %r9d
	jnz .ternary_true7
	movl $1, %r9d
	xorl $0, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r9d
.ternary_end8:
.ternary_end4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
