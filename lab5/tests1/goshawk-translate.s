.file	"../tests1/goshawk-translate.l3"
.globl _c0_main
_c0_readbyte:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.readbyte_0:
	movl $0, %r8d
	movl $0, %r9d
.readbyte_9:
.readbyte_1:
	movl $1, %ecx
	movl $8, %esi
	movl %r9d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .readbyte_7
.readbyte_2:
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %ecx
	imull %r8d, %ecx
	movl %ecx, %r8d
	addl %eax, %r8d
	subl $48, %r8d
	movl $0, %ecx
	cmpl %ecx, %r9d
	jz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movq %r8, %r12
	movq %r9, %rbx
	callq eof
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .readbyte_5
.readbyte_3:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.readbyte_5:
.readbyte_6:
	addl $1, %r9d
.readbyte_8:
	jmp .readbyte_1
.readbyte_7:
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
.main_1:
	callq eof
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_2:
	callq _c0_readbyte
	movl %eax, %edx
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_4
.main_3:
	movl %edx, %edi
	callq printchar
	movslq %eax, %r9
.main_8:
.main_5:
	jmp .main_1
.main_4:
.main_7:
	jmp .main_5
.main_6:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
