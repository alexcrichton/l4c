.file	"../tests2/utahraptor-return02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	cmpl $0, %r9d
	jnz .ternary_true1
	movl %r9d, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl %r8d, %edx
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $1, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $0, %r8d
.ternary_end4:
	movl %r8d, %ecx
	cmpl $0, %r9d
	jnz .ternary_true9
	movl $0, %r9d
	jmp .ternary_end10
.ternary_true9:
	movl %edx, %r9d
.ternary_end10:
	cmpl $0, %r9d
	jnz .ternary_true7
	movl $1, %r9d
	jmp .ternary_end14
.ternary_true13:
	movl $1, %r9d
.ternary_end14:
	cmpl $0, %r9d
	jnz .ternary_true11
	movl $0, %r9d
	jmp .ternary_end12
.ternary_true11:
	movl $0, %r9d
.ternary_end12:
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r9d
.ternary_end8:
	cmpl $0, %r9d
	jnz .ternary_true5
	movl $0, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %ecx, %r8d
.ternary_end6:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
