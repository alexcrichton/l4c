.file	"../tests1/merlin-short_circuit3.l3"
.globl _c0_main
_c0_i_loop_u_loop:
	addq $-8, %rsp
.i_loop_u_loop_0:
	movl $3, %r9d
.i_loop_u_loop_5:
	movl %r9d, %edx
.i_loop_u_loop_1:
	movl $1, %ecx
	movl $4, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .i_loop_u_loop_3
.i_loop_u_loop_2:
	movl %edx, %r8d
	addl $1, %r8d
	movl %r8d, %r9d
	subl $9, %r9d
	movl %r8d, %r9d
	subl $1, %r9d
.i_loop_u_loop_4:
	movl %r9d, %edx
	jmp .i_loop_u_loop_1
.i_loop_u_loop_3:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
.main_8:
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_2:
	movq %r9, %rbx
	callq _c0_i_loop_u_divzero
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true1
	movq %r9, %rbx
	callq _c0_i_loop_u_loop
	movq %rbx, %r9
	movl %eax, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_4
.main_3:
	addl $1, %r9d
.main_10:
	movl %r9d, %r8d
.main_5:
	movl %r8d, %r9d
	addl $1, %r9d
.main_7:
	jmp .main_1
.main_4:
.main_9:
	movl %r9d, %r8d
	jmp .main_5
.main_6:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_i_loop_u_divzero:
	addq $-8, %rsp
.i_loop_u_divzero_0:
	movl $3, %eax
	jmp .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $0, %r9d
	cltd
	idivl %r9d
	movl $1, %r9d
	cmpl %eax, %r9d
	setl %r9b
	movzbl %r9b, %r9d
.ternary_end4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
