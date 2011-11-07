.file	"../tests2/trex-project_euler_9.l3"
.globl _c0_main
_c0_sum2:
	addq $-8, %rsp
.sum2_0:
	movl %edi, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
_c0_sum3:
	addq $-8, %rsp
.sum3_0:
	movl %edi, %r9d
	addl %esi, %r9d
	movl %r9d, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
_c0_product3:
	addq $-8, %rsp
.product3_0:
	movl %edi, %r9d
	imull %esi, %r9d
	movl %r9d, %eax
	imull %edx, %eax
	addq $8, %rsp
	ret
_c0_square:
	addq $-8, %rsp
.square_0:
	movl %edi, %eax
	imull %edi, %eax
	addq $8, %rsp
	ret
_c0_is_triplet:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.is_triplet_0:
	movl %edx, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_square
	movq %r12, %rsi
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rsi, %r12
	movq %rcx, %rbx
	callq _c0_square
	movq %r12, %rsi
	movq %rbx, %rcx
	movl %eax, %r9d
	movl %esi, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_square
	movq %r12, %rcx
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %rcx, %rbx
	callq _c0_sum2
	movq %rbx, %rcx
	movl %ecx, %r8d
	cmpl %eax, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_find_triplet:
	addq $-216, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edi, %r15d
.find_triplet_0:
	movl $1, %edx
.find_triplet_23:
	movl %edx, 124(%rsp)
.find_triplet_1:
	movl $1, %esi
	movl 124(%rsp), %edx
	cmpl %r15d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .find_triplet_21
.find_triplet_2:
	movl $1, %edx
.find_triplet_25:
	movl %edx, 128(%rsp)
.find_triplet_3:
	movl $1, %esi
	movl 128(%rsp), %edx
	cmpl %r15d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .find_triplet_31
.find_triplet_4:
	movl 124(%rsp), %edi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_square
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, 132(%rsp)
	movl 128(%rsp), %edi
	movq %rcx, %rbp
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_square
	movq %rbp, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, 136(%rsp)
	movl 136(%rsp), %r10d
	cmpl %r10d, 132(%rsp)
	jle .ternary_true1
	movl 124(%rsp), %edi
	movl 128(%rsp), %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_sum2
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl %r15d, %r13d
	cmpl %r12d, %r13d
	setle %r13b
	movzbl %r13b, %r13d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r13d
.ternary_end2:
	movl $1, %edx
	cmpl %r13d, %edx
	jnz .find_triplet_7
.find_triplet_5:
	jmp .find_triplet_30
.find_triplet_7:
.find_triplet_8:
	movl $1, 140(%rsp)
.find_triplet_27:
	movl 144(%rsp), %ebp
	movl 148(%rsp), %r14d
	movl 152(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 168(%rsp), %r10d
	movl %r10d, 172(%rsp)
	movl 176(%rsp), %eax
	movl 180(%rsp), %edi
	movl %ebx, %esi
	movl 184(%rsp), %edx
.find_triplet_9:
	movl $1, 188(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 192(%rsp)
	cmpl %r15d, 192(%rsp)
	setle %r11b
	movzbl %r11b, %r11d
	movl %r11d, 192(%rsp)
	movl 192(%rsp), %r10d
	cmpl %r10d, 188(%rsp)
	jnz .find_triplet_29
.find_triplet_10:
	movl 124(%rsp), %edi
	movq %rcx, 52(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 68(%rsp)
	callq _c0_square
	movq 52(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 68(%rsp), %r9
	movl %eax, 188(%rsp)
	movl 140(%rsp), %edi
	movq %rcx, 76(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_square
	movq 76(%rsp), %rcx
	movq 52(%rsp), %r8
	movq 60(%rsp), %r9
	movl %eax, 192(%rsp)
	movl 128(%rsp), %edi
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 52(%rsp)
	callq _c0_square
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 52(%rsp), %r9
	movl %eax, 196(%rsp)
	movl 192(%rsp), %edi
	movl 196(%rsp), %esi
	movq %rcx, 92(%rsp)
	movq %r8, 84(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_sum2
	movq 92(%rsp), %rcx
	movq 84(%rsp), %r8
	movq 76(%rsp), %r9
	movl %eax, 172(%rsp)
	movl 172(%rsp), %r10d
	cmpl %r10d, 188(%rsp)
	jl .ternary_true3
	movl 140(%rsp), %edi
	movl 128(%rsp), %esi
	movl 124(%rsp), %edx
	movq %rcx, 92(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 100(%rsp)
	callq _c0_sum3
	movq 92(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 100(%rsp), %r9
	movl %eax, 200(%rsp)
	movl %r15d, 204(%rsp)
	movl 200(%rsp), %r10d
	cmpl %r10d, 204(%rsp)
	setl %r11b
	movzbl %r11b, %r11d
	movl %r11d, 204(%rsp)
	jmp .ternary_end4
.ternary_true3:
	movl $1, 204(%rsp)
.ternary_end4:
	movl $1, %edx
	cmpl 204(%rsp), %edx
	jnz .find_triplet_13
.find_triplet_11:
	jmp .find_triplet_28
.find_triplet_13:
.find_triplet_14:
	movl 140(%rsp), %edi
	movl 128(%rsp), %esi
	movl 124(%rsp), %edx
	movq %rcx, 108(%rsp)
	movq %r8, %rbp
	movq %r9, %r14
	callq _c0_is_triplet
	movq 108(%rsp), %rcx
	movq %rbp, %r8
	movq %r14, %r9
	movl %eax, %r14d
	cmpl $0, %r14d
	jnz .ternary_true5
	movl $0, %edx
	jmp .ternary_end6
.ternary_true5:
	movl 140(%rsp), %edi
	movl 128(%rsp), %esi
	movl 124(%rsp), %edx
	movq %rcx, 116(%rsp)
	movq %r8, 108(%rsp)
	movq %r9, %rbp
	callq _c0_sum3
	movq 116(%rsp), %rcx
	movq 108(%rsp), %r8
	movq %rbp, %r9
	movl %eax, 208(%rsp)
	movl 208(%rsp), %edx
	cmpl %r15d, %edx
	sete %dl
	movzbl %dl, %edx
.ternary_end6:
	movl $1, %esi
	cmpl %edx, %esi
	jnz .find_triplet_17
.find_triplet_15:
	movl 140(%rsp), %edi
	movl 128(%rsp), %esi
	movl 124(%rsp), %edx
	callq _c0_product3
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $216, %rsp
	ret
.find_triplet_17:
.find_triplet_18:
	addl $1, 140(%rsp)
.find_triplet_26:
	movl 208(%rsp), %ebp
	movl %edx, 156(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 192(%rsp), %eax
	movl 196(%rsp), %edi
	movl 188(%rsp), %esi
	movl 204(%rsp), %edx
	jmp .find_triplet_9
.find_triplet_29:
	movl %edx, 188(%rsp)
.find_triplet_19:
	movl 128(%rsp), %edx
	addl $1, %edx
.find_triplet_24:
	movl %ebp, 144(%rsp)
	movl %r14d, 148(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 164(%rsp), %r10d
	movl %r10d, 160(%rsp)
	movl 172(%rsp), %r10d
	movl %r10d, 168(%rsp)
	movl %eax, 176(%rsp)
	movl %edi, 180(%rsp)
	movl %esi, %ebx
	movl 188(%rsp), %r10d
	movl %r10d, 184(%rsp)
	movl %r12d, %ecx
	movl 136(%rsp), %r10d
	movl %r10d, 212(%rsp)
	movl 132(%rsp), %r8d
	movl %r13d, %r9d
	movl %edx, 128(%rsp)
	jmp .find_triplet_3
.find_triplet_31:
.find_triplet_20:
	movl 124(%rsp), %edx
	addl $1, %edx
.find_triplet_22:
	movl %edx, 124(%rsp)
	jmp .find_triplet_1
.find_triplet_21:
	movl $0, %eax
	subl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $216, %rsp
	ret
.find_triplet_28:
	movl 200(%rsp), %r10d
	movl %r10d, 164(%rsp)
	movl 192(%rsp), %eax
	movl 196(%rsp), %edi
	movl 188(%rsp), %esi
	movl 204(%rsp), %r10d
	movl %r10d, 188(%rsp)
	jmp .find_triplet_19
.find_triplet_30:
	jmp .find_triplet_20
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1000, %edi
	callq _c0_find_triplet
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
