.file	"../tests1/merlin-short_circuit1.l3"
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
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
.main_9:
.main_1:
	movl $1, %edx
	movl $99, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_11
.main_2:
	movl $0, %r8d
	subl $9, %r8d
	cmpl %r8d, %r9d
	jl .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movq %r9, %rbx
	callq _c0_i_loop_u_loop
	movq %rbx, %r9
	movl %eax, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_5
.main_3:
	jmp .main_10
.main_5:
.main_6:
	addl $1, %r9d
.main_8:
	jmp .main_1
.main_11:
.main_7:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
	jmp .main_7
.ident	"15-411 L4 reference compiler"
