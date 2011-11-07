.file	"../tests2/stegosaurus-queens.l3"
.globl _c0_main
_c0_abs:
	addq $-8, %rsp
.abs_0:
	movl $0, %r8d
	cmpl %edi, %r8d
	jl .ternary_true1
	movl $0, %r8d
	subl %edi, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edi, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_threaten:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r8d
	movl %esi, %r9d
.threaten_0:
	movl $1, %edi
	movl %r8d, %esi
	cmpl %edx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .threaten_3
.threaten_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.threaten_3:
.threaten_4:
	movl $1, %edi
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .threaten_7
.threaten_5:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.threaten_7:
.threaten_8:
	movl %r8d, %edi
	subl %edx, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_abs
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	subl %ecx, %edi
	movq %r8, %rbx
	callq _c0_abs
	movq %rbx, %r8
	movl $1, %ecx
	cmpl %eax, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .threaten_11
.threaten_9:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.threaten_11:
.threaten_12:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_queens:
	addq $-88, %rsp
	movq %rbp, 28(%rsp)
	movq %r15, 36(%rsp)
	movq %r14, 44(%rsp)
	movq %r13, 52(%rsp)
	movq %r12, 60(%rsp)
	movq %rbx, 68(%rsp)
	movl %edi, %ebx
	movl %esi, %r12d
	movl %edx, 76(%rsp)
	movl %ecx, %r13d
	movl %r8d, %ebp
	movl %r9d, 80(%rsp)
	movl 96(%rsp), %r10d
	movl %r10d, 84(%rsp)
	movl 104(%rsp), %r14d
.queens_0:
	movl $0, %r9d
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl %ebx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .queens_6
.queens_1:
	movl $0, %r8d
.queens_170:
	movl %r9d, %ebx
	movl %r8d, %r15d
.queens_2:
	movl $1, %ecx
	movl $8, %r8d
	movl %r15d, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .queens_4
.queens_3:
	movl %r15d, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %ebx, %r8d
	addl %eax, %r8d
	movl %r15d, %r9d
	addl $1, %r9d
.queens_169:
	movl %r8d, %ebx
	movl %r9d, %r15d
	jmp .queens_2
.queens_4:
	movl %ebx, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_6:
.queens_7:
	movl $1, %r8d
	movl $0, %edx
	subl $1, %edx
	movl %r12d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .queens_13
.queens_8:
	movl $0, %r8d
.queens_172:
	movl %r9d, %r12d
	movl %r8d, %r15d
.queens_9:
	movl $1, %ecx
	movl $8, %r8d
	movl %r15d, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .queens_11
.queens_10:
	movl %ebx, %edi
	movl %r15d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %r12d, %r8d
	addl %eax, %r8d
	movl %r15d, %r9d
	addl $1, %r9d
.queens_171:
	movl %r8d, %r12d
	movl %r9d, %r15d
	jmp .queens_9
.queens_11:
	movl %r12d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_13:
.queens_14:
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl 76(%rsp), %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .queens_24
.queens_15:
	movl $0, %edi
	movl %ebx, %esi
	movl $1, %edx
	movl %r12d, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_18
.queens_16:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_18:
.queens_19:
	movl $0, %r8d
.queens_174:
	movl %r9d, %r15d
	movl %r8d, 76(%rsp)
.queens_20:
	movl $1, %r8d
	movl $8, %r9d
	movl 76(%rsp), %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .queens_22
.queens_21:
	movl %ebx, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %r15d, %r9d
	addl %eax, %r9d
	movl 76(%rsp), %r8d
	addl $1, %r8d
.queens_173:
	movl %r9d, %r15d
	movl %r8d, 76(%rsp)
	jmp .queens_20
.queens_22:
	movl %r15d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_24:
.queens_25:
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl %r13d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .queens_39
.queens_26:
	movl $0, %edi
	movl %ebx, %esi
	movl $2, %edx
	movl 76(%rsp), %ecx
	movq %r9, %r13
	callq _c0_threaten
	movq %r13, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_29
.queens_27:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_29:
.queens_30:
	movl $1, %edi
	movl %r12d, %esi
	movl $2, %edx
	movl 76(%rsp), %ecx
	movq %r9, %r13
	callq _c0_threaten
	movq %r13, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_33
.queens_31:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_33:
.queens_34:
	movl $0, %r8d
.queens_176:
	movl %r9d, %r13d
	movl %r8d, %r15d
.queens_35:
	movl $1, %r9d
	movl $8, %ecx
	movl %r15d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .queens_37
.queens_36:
	movl %ebx, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r15d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %r13d, %r8d
	addl %eax, %r8d
	movl %r15d, %r9d
	addl $1, %r9d
.queens_175:
	movl %r8d, %r13d
	movl %r9d, %r15d
	jmp .queens_35
.queens_37:
	movl %r13d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_39:
.queens_40:
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl %ebp, %edx
	cmpl %r8d, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .queens_58
.queens_41:
	movl $0, %edi
	movl %ebx, %esi
	movl $3, %edx
	movl %r13d, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_44
.queens_42:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_44:
.queens_45:
	movl $1, %edi
	movl %r12d, %esi
	movl $3, %edx
	movl %r13d, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_48
.queens_46:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_48:
.queens_49:
	movl $2, %edi
	movl 76(%rsp), %esi
	movl $3, %edx
	movl %r13d, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_52
.queens_50:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_52:
.queens_53:
	movl $0, %r8d
.queens_178:
	movl %r9d, %r15d
	movl %r8d, %ebp
.queens_54:
	movl $1, %ecx
	movl $8, %r9d
	movl %ebp, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .queens_56
.queens_55:
	movl %ebx, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %r15d, %r8d
	addl %eax, %r8d
	movl %ebp, %r9d
	addl $1, %r9d
.queens_177:
	movl %r8d, %r15d
	movl %r9d, %ebp
	jmp .queens_54
.queens_56:
	movl %r15d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_58:
.queens_59:
	movl $1, %r8d
	movl $0, %edx
	subl $1, %edx
	movl 80(%rsp), %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .queens_81
.queens_60:
	movl $0, %edi
	movl %ebx, %esi
	movl $4, %edx
	movl %ebp, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_63
.queens_61:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_63:
.queens_64:
	movl $1, %edi
	movl %r12d, %esi
	movl $4, %edx
	movl %ebp, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_67
.queens_65:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_67:
.queens_68:
	movl $2, %edi
	movl 76(%rsp), %esi
	movl $4, %edx
	movl %ebp, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_71
.queens_69:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_71:
.queens_72:
	movl $3, %edi
	movl %r13d, %esi
	movl $4, %edx
	movl %ebp, %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_75
.queens_73:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_75:
.queens_76:
	movl $0, %r8d
.queens_180:
	movl %r9d, %r15d
	movl %r8d, 80(%rsp)
.queens_77:
	movl $1, %ecx
	movl $8, %r8d
	movl 80(%rsp), %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .queens_79
.queens_78:
	movl %ebx, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %r15d, %r8d
	addl %eax, %r8d
	movl 80(%rsp), %r9d
	addl $1, %r9d
.queens_179:
	movl %r8d, %r15d
	movl %r9d, 80(%rsp)
	jmp .queens_77
.queens_79:
	movl %r15d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_81:
.queens_82:
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl 84(%rsp), %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .queens_108
.queens_83:
	movl $0, %edi
	movl %ebx, %esi
	movl $5, %edx
	movl 80(%rsp), %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_86
.queens_84:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_86:
.queens_87:
	movl $1, %edi
	movl %r12d, %esi
	movl $5, %edx
	movl 80(%rsp), %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_90
.queens_88:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_90:
.queens_91:
	movl $2, %edi
	movl 76(%rsp), %esi
	movl $5, %edx
	movl 80(%rsp), %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_94
.queens_92:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_94:
.queens_95:
	movl $3, %edi
	movl %r13d, %esi
	movl $5, %edx
	movl 80(%rsp), %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_98
.queens_96:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_98:
.queens_99:
	movl $4, %edi
	movl %ebp, %esi
	movl $5, %edx
	movl 80(%rsp), %ecx
	movq %r9, %r15
	callq _c0_threaten
	movq %r15, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_102
.queens_100:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_102:
.queens_103:
	movl $0, %r8d
.queens_182:
	movl %r9d, %r15d
	movl %r8d, 84(%rsp)
.queens_104:
	movl $1, %ecx
	movl $8, %r8d
	movl 84(%rsp), %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .queens_106
.queens_105:
	movl %ebx, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	callq _c0_queens
	movl %r15d, %r8d
	addl %eax, %r8d
	movl 84(%rsp), %r9d
	addl $1, %r9d
.queens_181:
	movl %r8d, %r15d
	movl %r9d, 84(%rsp)
	jmp .queens_104
.queens_106:
	movl %r15d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_108:
.queens_109:
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl %r14d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .queens_139
.queens_110:
	movl $0, %edi
	movl %ebx, %esi
	movl $6, %edx
	movl 84(%rsp), %ecx
	movq %r9, %r14
	callq _c0_threaten
	movq %r14, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_113
.queens_111:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_113:
.queens_114:
	movl $1, %edi
	movl %r12d, %esi
	movl $6, %edx
	movl 84(%rsp), %ecx
	movq %r9, %r14
	callq _c0_threaten
	movq %r14, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_117
.queens_115:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_117:
.queens_118:
	movl $2, %edi
	movl 76(%rsp), %esi
	movl $6, %edx
	movl 84(%rsp), %ecx
	movq %r9, %r14
	callq _c0_threaten
	movq %r14, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_121
.queens_119:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_121:
.queens_122:
	movl $3, %edi
	movl %r13d, %esi
	movl $6, %edx
	movl 84(%rsp), %ecx
	movq %r9, %r14
	callq _c0_threaten
	movq %r14, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_125
.queens_123:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_125:
.queens_126:
	movl $4, %edi
	movl %ebp, %esi
	movl $6, %edx
	movl 84(%rsp), %ecx
	movq %r9, %r14
	callq _c0_threaten
	movq %r14, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .queens_129
.queens_127:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_129:
.queens_130:
	movl $5, %edi
	movl 80(%rsp), %esi
	movl $6, %edx
	movl 84(%rsp), %ecx
	movq %r9, %r14
	callq _c0_threaten
	movq %r14, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_133
.queens_131:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_133:
.queens_134:
	movl $0, %r8d
.queens_184:
	movl %r9d, %r14d
	movl %r8d, %r15d
.queens_135:
	movl $1, %r8d
	movl $8, %ecx
	movl %r15d, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .queens_137
.queens_136:
	movl %ebx, %edi
	movl %r12d, %esi
	movl 76(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 80(%rsp), %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r15d, 8(%rsp)
	callq _c0_queens
	movl %r14d, %r8d
	addl %eax, %r8d
	movl %r15d, %r9d
	addl $1, %r9d
.queens_183:
	movl %r8d, %r14d
	movl %r9d, %r15d
	jmp .queens_135
.queens_137:
	movl %r14d, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_139:
.queens_140:
	movl $0, %edi
	movl %ebx, %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_143
.queens_141:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_143:
.queens_144:
	movl $1, %edi
	movl %r12d, %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .queens_147
.queens_145:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_147:
.queens_148:
	movl $2, %edi
	movl 76(%rsp), %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .queens_151
.queens_149:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_151:
.queens_152:
	movl $3, %edi
	movl %r13d, %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .queens_155
.queens_153:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_155:
.queens_156:
	movl $4, %edi
	movl %ebp, %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .queens_159
.queens_157:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_159:
.queens_160:
	movl $5, %edi
	movl 80(%rsp), %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .queens_163
.queens_161:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_163:
.queens_164:
	movl $6, %edi
	movl 84(%rsp), %esi
	movl $7, %edx
	movl %r14d, %ecx
	callq _c0_threaten
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .queens_167
.queens_165:
	movl $0, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
.queens_167:
.queens_168:
	movl $1, %eax
	movq 28(%rsp), %rbp
	movq 36(%rsp), %r15
	movq 44(%rsp), %r14
	movq 52(%rsp), %r13
	movq 60(%rsp), %r12
	movq 68(%rsp), %rbx
	addq $88, %rsp
	ret
_c0_main:
	addq $-24, %rsp
.main_0:
	movl $0, %edi
	subl $1, %edi
	movl $0, %esi
	subl $1, %esi
	movl $0, %edx
	subl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl $0, %r9d
	subl $1, %r9d
	movl $0, 0(%rsp)
	subl $1, 0(%rsp)
	movl $0, 8(%rsp)
	subl $1, 8(%rsp)
	callq _c0_queens
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
