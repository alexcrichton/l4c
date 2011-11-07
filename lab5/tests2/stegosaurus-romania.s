.file	"../tests2/stegosaurus-romania.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
	movl %r9d, %edi
	callq _c0_Arad
	addq $8, %rsp
	ret
_c0_choose:
	addq $-8, %rsp
.choose_0:
	movl $0, %r8d
	subl $1, %r8d
	cmpl %r8d, %edi
	jz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r8d
	subl $1, %r8d
	movl %esi, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .choose_3
.choose_1:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.choose_3:
.choose_4:
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .choose_7
.choose_5:
	movl %esi, %eax
	addq $8, %rsp
	ret
.choose_7:
.choose_8:
	movl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .choose_11
.choose_9:
	movl %edi, %eax
	addq $8, %rsp
	ret
.choose_11:
.choose_12:
	cmpl %esi, %edi
	jl .ternary_true3
	movl %esi, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl %edi, %r8d
.ternary_end4:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_Timisoara:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Timisoara_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Timisoara_3
.Timisoara_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Timisoara_3:
.Timisoara_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Arad
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Timisoara_6
.Timisoara_5:
	movl %ecx, %edx
	addl $118, %edx
.Timisoara_12:
.Timisoara_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Lugoj
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Timisoara_9
.Timisoara_8:
	movl %eax, %r9d
	addl $111, %r9d
.Timisoara_14:
	movl %r9d, %esi
.Timisoara_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Timisoara_9:
.Timisoara_13:
	movl %eax, %esi
	jmp .Timisoara_10
.Timisoara_6:
.Timisoara_11:
	movl %ecx, %edx
	jmp .Timisoara_7
_c0_RimnicuVilcea:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.RimnicuVilcea_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .RimnicuVilcea_3
.RimnicuVilcea_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.RimnicuVilcea_3:
.RimnicuVilcea_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Craiova
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .RimnicuVilcea_6
.RimnicuVilcea_5:
	movl %ecx, %edx
	addl $146, %edx
.RimnicuVilcea_15:
.RimnicuVilcea_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Sibiu
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .RimnicuVilcea_9
.RimnicuVilcea_8:
	movl %ebx, %esi
	addl $80, %esi
.RimnicuVilcea_17:
.RimnicuVilcea_10:
	movl %edx, %edi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_choose
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl %r9d, %edi
	subl $1, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_Pitesti
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $1, %eax
	movl $0, %edi
	subl $1, %edi
	cmpl %r12d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .RimnicuVilcea_12
.RimnicuVilcea_11:
	movl %r12d, %r9d
	addl $97, %r9d
.RimnicuVilcea_19:
	movl %r9d, %edi
.RimnicuVilcea_13:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.RimnicuVilcea_12:
.RimnicuVilcea_18:
	movl %r12d, %edi
	jmp .RimnicuVilcea_13
.RimnicuVilcea_9:
.RimnicuVilcea_16:
	movl %ebx, %esi
	jmp .RimnicuVilcea_10
.RimnicuVilcea_6:
.RimnicuVilcea_14:
	movl %ecx, %edx
	jmp .RimnicuVilcea_7
_c0_Arad:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.Arad_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Arad_3
.Arad_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Arad_3:
.Arad_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Zerind
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Arad_6
.Arad_5:
	movl %ecx, %edx
	addl $75, %edx
.Arad_15:
.Arad_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Timisoara
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Arad_9
.Arad_8:
	movl %ebx, %esi
	addl $118, %esi
.Arad_17:
.Arad_10:
	movl %edx, %edi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_choose
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl %r9d, %edi
	subl $1, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_Sibiu
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $1, %eax
	movl $0, %edi
	subl $1, %edi
	cmpl %r12d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .Arad_12
.Arad_11:
	movl %r12d, %r9d
	addl $140, %r9d
.Arad_19:
	movl %r9d, %edi
.Arad_13:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Arad_12:
.Arad_18:
	movl %r12d, %edi
	jmp .Arad_13
.Arad_9:
.Arad_16:
	movl %ebx, %esi
	jmp .Arad_10
.Arad_6:
.Arad_14:
	movl %ecx, %edx
	jmp .Arad_7
_c0_Dobreta:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Dobreta_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Dobreta_3
.Dobreta_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Dobreta_3:
.Dobreta_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Mehadia
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Dobreta_6
.Dobreta_5:
	movl %ecx, %edx
	addl $75, %edx
.Dobreta_12:
.Dobreta_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Craiova
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Dobreta_9
.Dobreta_8:
	movl %eax, %r9d
	addl $120, %r9d
.Dobreta_14:
	movl %r9d, %esi
.Dobreta_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Dobreta_9:
.Dobreta_13:
	movl %eax, %esi
	jmp .Dobreta_10
.Dobreta_6:
.Dobreta_11:
	movl %ecx, %edx
	jmp .Dobreta_7
_c0_Pitesti:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.Pitesti_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Pitesti_3
.Pitesti_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Pitesti_3:
.Pitesti_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_RimnicuVilcea
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Pitesti_6
.Pitesti_5:
	movl %ecx, %edx
	addl $97, %edx
.Pitesti_15:
.Pitesti_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Craiova
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Pitesti_9
.Pitesti_8:
	movl %ebx, %esi
	addl $138, %esi
.Pitesti_17:
.Pitesti_10:
	movl %edx, %edi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_choose
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl %r9d, %edi
	subl $1, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_Bucharest
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $1, %eax
	movl $0, %edi
	subl $1, %edi
	cmpl %r12d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .Pitesti_12
.Pitesti_11:
	movl %r12d, %r9d
	addl $101, %r9d
.Pitesti_19:
	movl %r9d, %edi
.Pitesti_13:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Pitesti_12:
.Pitesti_18:
	movl %r12d, %edi
	jmp .Pitesti_13
.Pitesti_9:
.Pitesti_16:
	movl %ebx, %esi
	jmp .Pitesti_10
.Pitesti_6:
.Pitesti_14:
	movl %ecx, %edx
	jmp .Pitesti_7
_c0_Craiova:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.Craiova_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Craiova_3
.Craiova_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Craiova_3:
.Craiova_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Dobreta
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Craiova_6
.Craiova_5:
	movl %ecx, %edx
	addl $120, %edx
.Craiova_15:
.Craiova_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_RimnicuVilcea
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Craiova_9
.Craiova_8:
	movl %ebx, %esi
	addl $146, %esi
.Craiova_17:
.Craiova_10:
	movl %edx, %edi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_choose
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl %r9d, %edi
	subl $1, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_Pitesti
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $1, %eax
	movl $0, %edi
	subl $1, %edi
	cmpl %r12d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .Craiova_12
.Craiova_11:
	movl %r12d, %r9d
	addl $138, %r9d
.Craiova_19:
	movl %r9d, %edi
.Craiova_13:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Craiova_12:
.Craiova_18:
	movl %r12d, %edi
	jmp .Craiova_13
.Craiova_9:
.Craiova_16:
	movl %ebx, %esi
	jmp .Craiova_10
.Craiova_6:
.Craiova_14:
	movl %ecx, %edx
	jmp .Craiova_7
_c0_Eforie:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.Eforie_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $1, %esi
	movl $0, %r8d
	movl %edi, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Eforie_3
.Eforie_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.Eforie_3:
.Eforie_4:
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_Hirsova
	movq %rbx, %r9
	movl %eax, %edx
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .Eforie_6
.Eforie_5:
	movl %edx, %r8d
	addl $86, %r8d
.Eforie_9:
	movl %r8d, %ecx
.Eforie_7:
	movl %r9d, %edi
	movl %ecx, %esi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.Eforie_6:
.Eforie_8:
	movl %edx, %ecx
	jmp .Eforie_7
_c0_Hirsova:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Hirsova_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Hirsova_3
.Hirsova_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Hirsova_3:
.Hirsova_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Urziceni
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Hirsova_6
.Hirsova_5:
	movl %ecx, %edx
	addl $98, %edx
.Hirsova_12:
.Hirsova_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Eforie
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Hirsova_9
.Hirsova_8:
	movl %eax, %r9d
	addl $86, %r9d
.Hirsova_14:
	movl %r9d, %esi
.Hirsova_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Hirsova_9:
.Hirsova_13:
	movl %eax, %esi
	jmp .Hirsova_10
.Hirsova_6:
.Hirsova_11:
	movl %ecx, %edx
	jmp .Hirsova_7
_c0_Fagaras:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Fagaras_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Fagaras_3
.Fagaras_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Fagaras_3:
.Fagaras_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Sibiu
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Fagaras_6
.Fagaras_5:
	movl %ecx, %edx
	addl $99, %edx
.Fagaras_12:
.Fagaras_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Bucharest
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Fagaras_9
.Fagaras_8:
	movl %eax, %r9d
	addl $211, %r9d
.Fagaras_14:
	movl %r9d, %esi
.Fagaras_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Fagaras_9:
.Fagaras_13:
	movl %eax, %esi
	jmp .Fagaras_10
.Fagaras_6:
.Fagaras_11:
	movl %ecx, %edx
	jmp .Fagaras_7
_c0_Sibiu:
	addq $-72, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.Sibiu_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Sibiu_3
.Sibiu_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
.Sibiu_3:
.Sibiu_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_RimnicuVilcea
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Sibiu_6
.Sibiu_5:
	movl %ecx, %edx
	addl $80, %edx
.Sibiu_18:
.Sibiu_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl %r9d, %edi
	subl $1, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_Arad
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %r12d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Sibiu_9
.Sibiu_8:
	movl %r12d, %edx
	addl $140, %edx
.Sibiu_20:
.Sibiu_10:
	movl %ebx, %edi
	movl %edx, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_choose
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %r13d
	movl %r9d, %edi
	subl $1, %edi
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_Oradea
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %edx
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %edx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Sibiu_12
.Sibiu_11:
	movl %edx, %esi
	addl $151, %esi
.Sibiu_22:
.Sibiu_13:
	movl %r13d, %edi
	movq %rdx, 56(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_choose
	movq 56(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %esi
	movl %r9d, %edi
	subl $1, %edi
	movq %rsi, 64(%rsp)
	movq %rdx, 56(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_Fagaras
	movq 64(%rsp), %rsi
	movq 56(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %r14d
	movl $1, %edi
	movl $0, %eax
	subl $1, %eax
	cmpl %r14d, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %edi
	jnz .Sibiu_15
.Sibiu_14:
	movl %r14d, %r9d
	addl $99, %r9d
.Sibiu_24:
	movl %r9d, %edi
.Sibiu_16:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
.Sibiu_15:
.Sibiu_23:
	movl %r14d, %edi
	jmp .Sibiu_16
.Sibiu_12:
.Sibiu_21:
	movl %edx, %esi
	jmp .Sibiu_13
.Sibiu_9:
.Sibiu_19:
	movl %r12d, %edx
	jmp .Sibiu_10
.Sibiu_6:
.Sibiu_17:
	movl %ecx, %edx
	jmp .Sibiu_7
_c0_Vaslui:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Vaslui_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Vaslui_3
.Vaslui_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Vaslui_3:
.Vaslui_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Urziceni
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Vaslui_6
.Vaslui_5:
	movl %ecx, %edx
	addl $142, %edx
.Vaslui_12:
.Vaslui_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Iasi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Vaslui_9
.Vaslui_8:
	movl %eax, %r9d
	addl $92, %r9d
.Vaslui_14:
	movl %r9d, %esi
.Vaslui_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Vaslui_9:
.Vaslui_13:
	movl %eax, %esi
	jmp .Vaslui_10
.Vaslui_6:
.Vaslui_11:
	movl %ecx, %edx
	jmp .Vaslui_7
_c0_Giurgiu:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.Giurgiu_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $1, %esi
	movl $0, %r8d
	movl %edi, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Giurgiu_3
.Giurgiu_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.Giurgiu_3:
.Giurgiu_4:
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_Bucharest
	movq %rbx, %r9
	movl %eax, %edx
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .Giurgiu_6
.Giurgiu_5:
	movl %edx, %r8d
	addl $90, %r8d
.Giurgiu_9:
	movl %r8d, %ecx
.Giurgiu_7:
	movl %r9d, %edi
	movl %ecx, %esi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.Giurgiu_6:
.Giurgiu_8:
	movl %edx, %ecx
	jmp .Giurgiu_7
_c0_Zerind:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Zerind_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Zerind_3
.Zerind_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Zerind_3:
.Zerind_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Oradea
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Zerind_6
.Zerind_5:
	movl %ecx, %edx
	addl $71, %edx
.Zerind_12:
.Zerind_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Arad
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Zerind_9
.Zerind_8:
	movl %eax, %r9d
	addl $75, %r9d
.Zerind_14:
	movl %r9d, %esi
.Zerind_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Zerind_9:
.Zerind_13:
	movl %eax, %esi
	jmp .Zerind_10
.Zerind_6:
.Zerind_11:
	movl %ecx, %edx
	jmp .Zerind_7
_c0_Iasi:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Iasi_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Iasi_3
.Iasi_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Iasi_3:
.Iasi_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Vaslui
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Iasi_6
.Iasi_5:
	movl %ecx, %edx
	addl $92, %edx
.Iasi_12:
.Iasi_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Neamt
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Iasi_9
.Iasi_8:
	movl %eax, %r9d
	addl $87, %r9d
.Iasi_14:
	movl %r9d, %esi
.Iasi_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Iasi_9:
.Iasi_13:
	movl %eax, %esi
	jmp .Iasi_10
.Iasi_6:
.Iasi_11:
	movl %ecx, %edx
	jmp .Iasi_7
_c0_Mehadia:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Mehadia_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Mehadia_3
.Mehadia_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Mehadia_3:
.Mehadia_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Lugoj
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Mehadia_6
.Mehadia_5:
	movl %ecx, %edx
	addl $70, %edx
.Mehadia_12:
.Mehadia_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Dobreta
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Mehadia_9
.Mehadia_8:
	movl %eax, %r9d
	addl $75, %r9d
.Mehadia_14:
	movl %r9d, %esi
.Mehadia_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Mehadia_9:
.Mehadia_13:
	movl %eax, %esi
	jmp .Mehadia_10
.Mehadia_6:
.Mehadia_11:
	movl %ecx, %edx
	jmp .Mehadia_7
_c0_Lugoj:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Lugoj_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Lugoj_3
.Lugoj_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Lugoj_3:
.Lugoj_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Timisoara
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Lugoj_6
.Lugoj_5:
	movl %ecx, %edx
	addl $111, %edx
.Lugoj_12:
.Lugoj_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Mehadia
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Lugoj_9
.Lugoj_8:
	movl %eax, %r9d
	addl $70, %r9d
.Lugoj_14:
	movl %r9d, %esi
.Lugoj_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Lugoj_9:
.Lugoj_13:
	movl %eax, %esi
	jmp .Lugoj_10
.Lugoj_6:
.Lugoj_11:
	movl %ecx, %edx
	jmp .Lugoj_7
_c0_Oradea:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.Oradea_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Oradea_3
.Oradea_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Oradea_3:
.Oradea_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Zerind
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $0, %edx
	subl $1, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .Oradea_6
.Oradea_5:
	movl %ecx, %edx
	addl $71, %edx
.Oradea_12:
.Oradea_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Sibiu
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Oradea_9
.Oradea_8:
	movl %eax, %r9d
	addl $151, %r9d
.Oradea_14:
	movl %r9d, %esi
.Oradea_10:
	movl %edx, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.Oradea_9:
.Oradea_13:
	movl %eax, %esi
	jmp .Oradea_10
.Oradea_6:
.Oradea_11:
	movl %ecx, %edx
	jmp .Oradea_7
_c0_Neamt:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.Neamt_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $1, %esi
	movl $0, %r8d
	movl %edi, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Neamt_3
.Neamt_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.Neamt_3:
.Neamt_4:
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_Iasi
	movq %rbx, %r9
	movl %eax, %edx
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .Neamt_6
.Neamt_5:
	movl %edx, %r8d
	addl $87, %r8d
.Neamt_9:
	movl %r8d, %ecx
.Neamt_7:
	movl %r9d, %edi
	movl %ecx, %esi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.Neamt_6:
.Neamt_8:
	movl %edx, %ecx
	jmp .Neamt_7
_c0_Urziceni:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.Urziceni_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .Urziceni_3
.Urziceni_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Urziceni_3:
.Urziceni_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Bucharest
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .Urziceni_6
.Urziceni_5:
	movl %ecx, %edx
	addl $85, %edx
.Urziceni_15:
.Urziceni_7:
	movl %r8d, %edi
	movl %edx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_Hirsova
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $1, %edi
	movl $0, %esi
	subl $1, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .Urziceni_9
.Urziceni_8:
	movl %ebx, %esi
	addl $98, %esi
.Urziceni_17:
.Urziceni_10:
	movl %edx, %edi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_choose
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl %r9d, %edi
	subl $1, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_Vaslui
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $1, %eax
	movl $0, %edi
	subl $1, %edi
	cmpl %r12d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .Urziceni_12
.Urziceni_11:
	movl %r12d, %r9d
	addl $142, %r9d
.Urziceni_19:
	movl %r9d, %edi
.Urziceni_13:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_choose
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.Urziceni_12:
.Urziceni_18:
	movl %r12d, %edi
	jmp .Urziceni_13
.Urziceni_9:
.Urziceni_16:
	movl %ebx, %esi
	jmp .Urziceni_10
.Urziceni_6:
.Urziceni_14:
	movl %ecx, %edx
	jmp .Urziceni_7
_c0_Bucharest:
	addq $-8, %rsp
.Bucharest_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %ecx
	movl $0, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .Bucharest_3
.Bucharest_1:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.Bucharest_3:
.Bucharest_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
