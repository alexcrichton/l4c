.file	"../tests2/saltopus-umvm-sandmark.l4"
.globl _c0_main
_c0_cksum_start:
	addq $-8, %rsp
.cksum_start_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	addq $8, %rsp
	ret
_c0_cksum_update:
	addq $-8, %rsp
.cksum_update_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %eax
	addl %esi, %eax
	movl $65521, %r8d
	cltd
	idivl %r8d
	movq $0, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl %edx, (%rcx)
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %edx, %eax
	addl %r8d, %eax
	movl $65521, %r8d
	cltd
	idivl %r8d
	movl %edx, %ecx
	movq $4, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl %ecx, (%rdx)
	movq %rdi, %rax
	addq $8, %rsp
	ret
_c0_cksum_finish:
	addq $-8, %rsp
.cksum_finish_0:
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %ecx, %r9d
	sall $16, %r9d
	movl %r9d, %eax
	orl %r8d, %eax
	addq $8, %rsp
	ret
_c0_geq:
	addq $-8, %rsp
.geq_0:
	movl $0, %r8d
	cmpl %r8d, %esi
	jl .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r8d
	movl %r8d, %ecx
	cmpl %edi, %ecx
	setle %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .geq_3
.geq_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.geq_3:
.geq_4:
	movl $0, %r8d
	cmpl %r8d, %edi
	jl .ternary_true3
	movl $0, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $0, %r8d
	movl %r8d, %ecx
	cmpl %esi, %ecx
	setle %cl
	movzbl %cl, %ecx
.ternary_end4:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .geq_7
.geq_5:
	movl $1, %eax
	addq $8, %rsp
	ret
.geq_7:
.geq_8:
	movl %esi, %eax
	cmpl %edi, %eax
	setle %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_unsigned_div:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r8d
	movl %esi, %r9d
.unsigned_div_0:
	movl %r8d, %edi
	movl $0, %esi
	movl $1, %ecx
	movl $0, %edx
	movl %r9d, %eax
	cmpl %edx, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %ecx
	jnz .unsigned_div_3
.unsigned_div_1:
	movl %r8d, %eax
	cltd
	idivl %r9d
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.unsigned_div_3:
.unsigned_div_4:
	movl $0, %r8d
.unsigned_div_15:
	movl %edi, %r12d
.unsigned_div_5:
	movl $1, %edi
	movl $32, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .unsigned_div_13
.unsigned_div_6:
	movl %esi, %ecx
	sall $1, %ecx
	movl $1, %edi
	movl $0, %esi
	movl %r12d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .unsigned_div_8
.unsigned_div_7:
	movl %ecx, %edx
	addl $1, %edx
.unsigned_div_17:
.unsigned_div_9:
	movl %r12d, %ebx
	sall $1, %ebx
	movl %edx, %edi
	movl %r9d, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_geq
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %edi
	cmpl %eax, %edi
	jnz .unsigned_div_11
.unsigned_div_10:
	movl %ebx, %edi
	addl $1, %edi
	movl %edx, %esi
	subl %r9d, %esi
.unsigned_div_19:
.unsigned_div_12:
	addl $1, %r8d
.unsigned_div_14:
	movl %edi, %r12d
	jmp .unsigned_div_5
.unsigned_div_11:
.unsigned_div_18:
	movl %edx, %esi
	movl %ebx, %edi
	jmp .unsigned_div_12
.unsigned_div_8:
.unsigned_div_16:
	movl %ecx, %edx
	jmp .unsigned_div_9
.unsigned_div_13:
	movl %r12d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_crash:
	addq $-8, %rsp
.crash_0:
	movl $5, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_copy:
	addq $-8, %rsp
	movq %rdi, %r9
	movq %rsi, %r8
	movl %edx, %eax
.copy_0:
	movl $0, %ecx
.copy_5:
	movl %ecx, %edi
.copy_1:
	movl $1, %edx
	movl %edi, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .copy_3
.copy_2:
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.copy_4:
	movl %ecx, %edi
	jmp .copy_1
.copy_3:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-1672, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq %rdx, 56(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_cksum_start
	movq 56(%rsp), %rdx
	movq 64(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movq %rax, 80(%rsp)
	movl $100000, 816(%rsp)
	movl $1, 820(%rsp)
	movl $0, 824(%rsp)
	subl $1, 824(%rsp)
	movq $8, %rdi
	movq $4, %rsi
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq %rax, 72(%rsp)
	movl $0, 828(%rsp)
	movslq 816(%rsp), %rdi
	movq $8, %rsi
	movq %rdx, 104(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 64(%rsp)
	callq calloc
	movq 104(%rsp), %rdx
	movq 112(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 64(%rsp), %r9
	movq %rax, 64(%rsp)
	movslq 816(%rsp), %rdi
	movq $4, %rsi
	movq %rdx, 104(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 56(%rsp)
	callq calloc
	movq 104(%rsp), %rdx
	movq 112(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 56(%rsp), %r9
	movq %rax, 56(%rsp)
	movl $0, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq 64(%rsp), %rdi
	addq %rsi, %rdi
	movq (%rdi), %rsi
	movq %rsi, 96(%rsp)
	movq %rdx, 120(%rsp)
	movq %rcx, 128(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	callq _c0_read_program
	movq 120(%rsp), %rdx
	movq 128(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq %rax, %rsi
	movl $0, %edi
	imull $8, %edi
	movslq %edi, %rax
	movq 64(%rsp), %rdi
	addq %rax, %rdi
	movq %rsi, (%rdi)
.main_57:
	movl 828(%rsp), %eax
.main_1:
	movl $1, %edi
	movl $1, %esi
	cmpl %esi, %edi
	jnz .main_55
.main_2:
	movl $0, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq 64(%rsp), %rsi
	addq %rdi, %rsi
	movq (%rsi), %rdi
	movl %eax, %esi
	addl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rdi
	movl (%rdi), %esi
	movl %esi, %edi
	movl %edi, %esi
	sarl $6, %esi
	movl %esi, 828(%rsp)
	andl $7, 828(%rsp)
	movl %edi, %esi
	sarl $3, %esi
	movl %esi, 832(%rsp)
	andl $7, 832(%rsp)
	movl %edi, 836(%rsp)
	andl $7, 836(%rsp)
	movl %edi, %esi
	sarl $28, %esi
	movl %esi, 840(%rsp)
	andl $15, 840(%rsp)
	movl %eax, 844(%rsp)
	addl $1, 844(%rsp)
	movl $1, %esi
	movl $13, 848(%rsp)
	movl 840(%rsp), %eax
	cmpl 848(%rsp), %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %esi
	jnz .main_3
.main_52:
	movl %edi, %esi
	sarl $25, %esi
	andl $7, %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rax
	addq %rsi, %rax
	movl %edi, (%rax)
	andl $33554431, (%rax)
.main_89:
	movl 844(%rsp), %eax
	movl 824(%rsp), %edi
	movl 820(%rsp), %esi
.main_54:
.main_56:
	movl %edi, 824(%rsp)
	movl %esi, 820(%rsp)
	jmp .main_1
.main_3:
	movl $1, %eax
	movl $1, %esi
	movl 840(%rsp), %edi
	cmpl %esi, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_4
.main_50:
	movl 832(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 72(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 852(%rsp)
	movl 852(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq 64(%rsp), %rsi
	addq %rdi, %rsi
	movq (%rsi), %rdi
	movl 836(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rax
	addq %rsi, %rax
	movl (%rax), %r10d
	movl %r10d, 856(%rsp)
	movl 856(%rsp), %esi
	addl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq %rdi, %rax
	addq %rsi, %rax
	movl (%rax), %eax
	movl 828(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %r10
	movq %r10, 136(%rsp)
	addq %rsi, 136(%rsp)
	movq 136(%rsp), %r11
	movl %eax, (%r11)
.main_87:
	movl %eax, 860(%rsp)
	movl 856(%rsp), %r10d
	movl %r10d, 864(%rsp)
	movq %rdi, 144(%rsp)
	movl 844(%rsp), %eax
	movl 824(%rsp), %edi
	movl 820(%rsp), %esi
.main_53:
.main_88:
	jmp .main_54
.main_4:
	movl $1, %edx
	movl $2, %edi
	movl 840(%rsp), %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_5
.main_48:
	movl 828(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq 64(%rsp), %rsi
	addq %rdi, %rsi
	movq (%rsi), %rsi
	movl 832(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rax
	movq 72(%rsp), %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	movl 836(%rsp), %eax
	imull $4, %eax
	movslq %eax, %rax
	movq %rax, 152(%rsp)
	movq 72(%rsp), %rax
	addq 152(%rsp), %rax
	movl (%rax), %r10d
	movl %r10d, 868(%rsp)
	movl %edi, %eax
	addl $1, %eax
	imull $4, %eax
	movslq %eax, %rax
	movq %rsi, 160(%rsp)
	addq %rax, 160(%rsp)
	movl 868(%rsp), %r10d
	movq 160(%rsp), %r11
	movl %r10d, (%r11)
.main_85:
	movl 868(%rsp), %r10d
	movl %r10d, 872(%rsp)
	movl %edi, 876(%rsp)
	movq %rsi, 168(%rsp)
	movl %edx, 880(%rsp)
	movl 844(%rsp), %eax
	movl 824(%rsp), %edi
	movl 820(%rsp), %esi
.main_51:
.main_86:
	movl 884(%rsp), %r10d
	movl %r10d, 888(%rsp)
	movq 176(%rsp), %r10
	movq %r10, 184(%rsp)
	movq 192(%rsp), %r10
	movq %r10, 200(%rsp)
	movl 892(%rsp), %r10d
	movl %r10d, 896(%rsp)
	movq 208(%rsp), %r10
	movq %r10, 216(%rsp)
	movl 900(%rsp), %r10d
	movl %r10d, 904(%rsp)
	movl 908(%rsp), %r10d
	movl %r10d, 912(%rsp)
	movq 224(%rsp), %r10
	movq %r10, 232(%rsp)
	movl 916(%rsp), %r10d
	movl %r10d, 920(%rsp)
	movl 924(%rsp), %r10d
	movl %r10d, 928(%rsp)
	movl 932(%rsp), %r10d
	movl %r10d, 936(%rsp)
	movl 940(%rsp), %r10d
	movl %r10d, 944(%rsp)
	movl 948(%rsp), %r10d
	movl %r10d, 952(%rsp)
	movl 956(%rsp), %r10d
	movl %r10d, 960(%rsp)
	movl 964(%rsp), %r10d
	movl %r10d, 968(%rsp)
	movl 972(%rsp), %r10d
	movl %r10d, 976(%rsp)
	movl 980(%rsp), %r10d
	movl %r10d, 984(%rsp)
	movl 988(%rsp), %r10d
	movl %r10d, 992(%rsp)
	movq 240(%rsp), %r10
	movq %r10, 248(%rsp)
	movl 996(%rsp), %r10d
	movl %r10d, 1000(%rsp)
	movl 1004(%rsp), %r10d
	movl %r10d, 1008(%rsp)
	movl 1012(%rsp), %r10d
	movl %r10d, 1016(%rsp)
	movl 1020(%rsp), %r10d
	movl %r10d, 1024(%rsp)
	movl 1028(%rsp), %r10d
	movl %r10d, 1032(%rsp)
	movl 1036(%rsp), %r10d
	movl %r10d, 868(%rsp)
	movl 1040(%rsp), %edx
	movl 1044(%rsp), %r10d
	movl %r10d, 1048(%rsp)
	movl 1052(%rsp), %r10d
	movl %r10d, 1056(%rsp)
	movq 256(%rsp), %r10
	movq %r10, 264(%rsp)
	movl 1060(%rsp), %r10d
	movl %r10d, 1064(%rsp)
	movl 1068(%rsp), %r10d
	movl %r10d, 1072(%rsp)
	movq 272(%rsp), %r10
	movq %r10, 280(%rsp)
	movl 1076(%rsp), %r10d
	movl %r10d, 1080(%rsp)
	movq 288(%rsp), %r10
	movq %r10, 296(%rsp)
	movl 1084(%rsp), %r10d
	movl %r10d, 1088(%rsp)
	movq 304(%rsp), %r10
	movq %r10, 312(%rsp)
	movl 1092(%rsp), %r10d
	movl %r10d, 1096(%rsp)
	movq 320(%rsp), %r10
	movq %r10, 328(%rsp)
	movl 1100(%rsp), %r10d
	movl %r10d, 1104(%rsp)
	movl 872(%rsp), %r10d
	movl %r10d, 1108(%rsp)
	movl 876(%rsp), %r10d
	movl %r10d, 1112(%rsp)
	movq 168(%rsp), %r10
	movq %r10, 336(%rsp)
	movl 880(%rsp), %r10d
	movl %r10d, 1116(%rsp)
	jmp .main_53
.main_5:
	movl $1, %esi
	movl $12, %edx
	movl 840(%rsp), %edi
	cmpl %edx, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .main_9
.main_6:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 1120(%rsp)
	movl $1, %edi
	movl $0, %esi
	movl 1120(%rsp), %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_8
.main_7:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 868(%rsp)
	movl 868(%rsp), %edx
	imull $8, %edx
	movslq %edx, %rdx
	movq 64(%rsp), %rsi
	addq %rdx, %rsi
	movq (%rsi), %r10
	movq %r10, 160(%rsp)
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 160(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 1024(%rsp)
	movslq 1024(%rsp), %rdi
	movq $4, %rsi
	movq %rcx, 344(%rsp)
	movq %r8, 352(%rsp)
	movq %r9, 360(%rsp)
	callq calloc
	movq 344(%rsp), %rcx
	movq 352(%rsp), %r8
	movq 360(%rsp), %r9
	movq %rax, 360(%rsp)
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 1008(%rsp)
	movl 1008(%rsp), %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq 64(%rsp), %rdx
	addq %rsi, %rdx
	movq (%rdx), %r10
	movq %r10, 344(%rsp)
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %r10d
	movl %r10d, 1124(%rsp)
	movl 1124(%rsp), %edx
	imull $8, %edx
	movslq %edx, %rdx
	movq 64(%rsp), %rsi
	addq %rdx, %rsi
	movq (%rsi), %r10
	movq %r10, 368(%rsp)
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 368(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %r10d
	movl %r10d, 984(%rsp)
	movq 360(%rsp), %rdi
	movq 344(%rsp), %rsi
	movl 984(%rsp), %edx
	movq %rcx, 376(%rsp)
	movq %r8, 384(%rsp)
	movq %r9, 392(%rsp)
	callq _c0_copy
	movq 376(%rsp), %rcx
	movq 384(%rsp), %r8
	movq 392(%rsp), %r9
	movl %eax, %edx
	movslq %edx, %rsi
	movl $0, %edi
	imull $8, %edi
	movslq %edi, %rdi
	movq 64(%rsp), %rax
	addq %rdi, %rax
	movq 360(%rsp), %r10
	movq %r10, (%rax)
.main_79:
	movl %edx, 1128(%rsp)
	movq 344(%rsp), %r10
	movq %r10, 400(%rsp)
	movl 1008(%rsp), %r10d
	movl %r10d, 1132(%rsp)
	movl 984(%rsp), %r10d
	movl %r10d, 1136(%rsp)
	movq 368(%rsp), %r10
	movq %r10, 408(%rsp)
	movl 1124(%rsp), %r10d
	movl %r10d, 1140(%rsp)
	movq %rsi, 416(%rsp)
	movl 1024(%rsp), %r10d
	movl %r10d, 1144(%rsp)
	movq 160(%rsp), %r10
	movq %r10, 424(%rsp)
	movl 868(%rsp), %r10d
	movl %r10d, 1148(%rsp)
	movq 360(%rsp), %r10
	movq %r10, 432(%rsp)
.main_46:
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %esi
.main_83:
	movl %edx, 1152(%rsp)
	movl 1128(%rsp), %r10d
	movl %r10d, 1156(%rsp)
	movq 400(%rsp), %r10
	movq %r10, 440(%rsp)
	movl 1132(%rsp), %r10d
	movl %r10d, 1160(%rsp)
	movl 1136(%rsp), %r10d
	movl %r10d, 1164(%rsp)
	movq 408(%rsp), %r10
	movq %r10, 448(%rsp)
	movl 1140(%rsp), %r10d
	movl %r10d, 1168(%rsp)
	movq 416(%rsp), %r10
	movq %r10, 456(%rsp)
	movl 1144(%rsp), %r10d
	movl %r10d, 1172(%rsp)
	movq 424(%rsp), %r10
	movq %r10, 464(%rsp)
	movl 1148(%rsp), %r10d
	movl %r10d, 1176(%rsp)
	movq 432(%rsp), %r10
	movq %r10, 472(%rsp)
	movl 1120(%rsp), %r10d
	movl %r10d, 1180(%rsp)
	movl %esi, %edi
	movl 824(%rsp), %edx
	movl 820(%rsp), %esi
.main_49:
.main_84:
	movl 1184(%rsp), %r10d
	movl %r10d, 884(%rsp)
	movq 480(%rsp), %r10
	movq %r10, 176(%rsp)
	movq 488(%rsp), %r10
	movq %r10, 192(%rsp)
	movl 1188(%rsp), %r10d
	movl %r10d, 892(%rsp)
	movq 496(%rsp), %r10
	movq %r10, 208(%rsp)
	movl 1192(%rsp), %r10d
	movl %r10d, 900(%rsp)
	movl 1196(%rsp), %r10d
	movl %r10d, 908(%rsp)
	movq 504(%rsp), %r10
	movq %r10, 224(%rsp)
	movl 1200(%rsp), %r10d
	movl %r10d, 916(%rsp)
	movl 1204(%rsp), %r10d
	movl %r10d, 924(%rsp)
	movl 1208(%rsp), %r10d
	movl %r10d, 932(%rsp)
	movl 1212(%rsp), %r10d
	movl %r10d, 940(%rsp)
	movl 1216(%rsp), %r10d
	movl %r10d, 948(%rsp)
	movl 1220(%rsp), %r10d
	movl %r10d, 956(%rsp)
	movl 1224(%rsp), %r10d
	movl %r10d, 964(%rsp)
	movl 1228(%rsp), %r10d
	movl %r10d, 972(%rsp)
	movl 1232(%rsp), %r10d
	movl %r10d, 980(%rsp)
	movl 1236(%rsp), %r10d
	movl %r10d, 988(%rsp)
	movq 512(%rsp), %r10
	movq %r10, 240(%rsp)
	movl 1240(%rsp), %r10d
	movl %r10d, 996(%rsp)
	movl 1244(%rsp), %r10d
	movl %r10d, 1004(%rsp)
	movl 1248(%rsp), %r10d
	movl %r10d, 1012(%rsp)
	movl 1252(%rsp), %r10d
	movl %r10d, 1020(%rsp)
	movl 1256(%rsp), %r10d
	movl %r10d, 1028(%rsp)
	movl 1260(%rsp), %r10d
	movl %r10d, 1036(%rsp)
	movl 1264(%rsp), %r10d
	movl %r10d, 1040(%rsp)
	movl 1152(%rsp), %r10d
	movl %r10d, 1044(%rsp)
	movl 1156(%rsp), %r10d
	movl %r10d, 1052(%rsp)
	movq 440(%rsp), %r10
	movq %r10, 256(%rsp)
	movl 1160(%rsp), %r10d
	movl %r10d, 1060(%rsp)
	movl 1164(%rsp), %r10d
	movl %r10d, 1068(%rsp)
	movq 448(%rsp), %r10
	movq %r10, 272(%rsp)
	movl 1168(%rsp), %r10d
	movl %r10d, 1076(%rsp)
	movq 456(%rsp), %r10
	movq %r10, 288(%rsp)
	movl 1172(%rsp), %r10d
	movl %r10d, 1084(%rsp)
	movq 464(%rsp), %r10
	movq %r10, 304(%rsp)
	movl 1176(%rsp), %r10d
	movl %r10d, 1092(%rsp)
	movq 472(%rsp), %r10
	movq %r10, 320(%rsp)
	movl 1180(%rsp), %r10d
	movl %r10d, 1100(%rsp)
	movl %edi, %eax
	movl %edx, %edi
	jmp .main_51
.main_8:
.main_78:
	jmp .main_46
.main_9:
	movl $1, %edi
	movl $6, %esi
	movl 840(%rsp), %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_10
.main_44:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %esi
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq 72(%rsp), %rdx
	addq %rdi, %rdx
	movl (%rdx), %edi
	movl 828(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rax
	addq %rdx, %rax
	movl %esi, %edx
	andl %edi, %edx
	movl $-1, (%rax)
	xorl %edx, (%rax)
.main_81:
	movl %edi, 1268(%rsp)
	movl %esi, 1272(%rsp)
	movl 824(%rsp), %edx
	movl 820(%rsp), %esi
.main_47:
.main_82:
	movl 1276(%rsp), %r10d
	movl %r10d, 1184(%rsp)
	movq 520(%rsp), %r10
	movq %r10, 480(%rsp)
	movq 528(%rsp), %r10
	movq %r10, 488(%rsp)
	movl 1280(%rsp), %r10d
	movl %r10d, 1188(%rsp)
	movq 536(%rsp), %r10
	movq %r10, 496(%rsp)
	movl 1284(%rsp), %r10d
	movl %r10d, 1192(%rsp)
	movl 1288(%rsp), %r10d
	movl %r10d, 1196(%rsp)
	movq 544(%rsp), %r10
	movq %r10, 504(%rsp)
	movl 1292(%rsp), %r10d
	movl %r10d, 1200(%rsp)
	movl 1296(%rsp), %r10d
	movl %r10d, 1204(%rsp)
	movl 1300(%rsp), %r10d
	movl %r10d, 1208(%rsp)
	movl 1304(%rsp), %r10d
	movl %r10d, 1212(%rsp)
	movl 1308(%rsp), %r10d
	movl %r10d, 1216(%rsp)
	movl %ebp, 1220(%rsp)
	movl %r15d, 1224(%rsp)
	movl 1312(%rsp), %r10d
	movl %r10d, 1228(%rsp)
	movl 1316(%rsp), %r10d
	movl %r10d, 1232(%rsp)
	movl 1320(%rsp), %r10d
	movl %r10d, 1236(%rsp)
	movq 552(%rsp), %r10
	movq %r10, 512(%rsp)
	movl 1324(%rsp), %r10d
	movl %r10d, 1240(%rsp)
	movl 1328(%rsp), %r10d
	movl %r10d, 1244(%rsp)
	movl 1332(%rsp), %r10d
	movl %r10d, 1248(%rsp)
	movl 1336(%rsp), %r10d
	movl %r10d, 1252(%rsp)
	movl 1340(%rsp), %r10d
	movl %r10d, 1256(%rsp)
	movl 1268(%rsp), %r10d
	movl %r10d, 1260(%rsp)
	movl 1272(%rsp), %r10d
	movl %r10d, 1264(%rsp)
	movl 844(%rsp), %edi
	jmp .main_49
.main_10:
	movl $1, %edi
	movl $0, %esi
	movl 840(%rsp), %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_14
.main_11:
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %r10d
	movl %r10d, 1344(%rsp)
	movl $1, %esi
	movl $0, %edx
	movl 1344(%rsp), %edi
	cmpl %edx, %edi
	setne %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .main_13
.main_12:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl 828(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rdi
	addq %rsi, %rdi
	movl %edx, (%rdi)
.main_73:
	movl %edx, 1348(%rsp)
.main_42:
.main_77:
	movl 1348(%rsp), %r10d
	movl %r10d, 1352(%rsp)
	movl 1344(%rsp), %r10d
	movl %r10d, 1356(%rsp)
	movl 824(%rsp), %edi
	movl 820(%rsp), %esi
.main_45:
.main_80:
	movl 1360(%rsp), %r10d
	movl %r10d, 1276(%rsp)
	movq 560(%rsp), %r10
	movq %r10, 520(%rsp)
	movq 568(%rsp), %r10
	movq %r10, 528(%rsp)
	movl 1364(%rsp), %r10d
	movl %r10d, 1280(%rsp)
	movq 576(%rsp), %r10
	movq %r10, 536(%rsp)
	movl 1368(%rsp), %r10d
	movl %r10d, 1284(%rsp)
	movl 1372(%rsp), %r10d
	movl %r10d, 1288(%rsp)
	movq 584(%rsp), %r10
	movq %r10, 544(%rsp)
	movl 1376(%rsp), %r10d
	movl %r10d, 1292(%rsp)
	movl 1380(%rsp), %r10d
	movl %r10d, 1296(%rsp)
	movl 1384(%rsp), %r10d
	movl %r10d, 1300(%rsp)
	movl 1388(%rsp), %r10d
	movl %r10d, 1304(%rsp)
	movl 1392(%rsp), %r10d
	movl %r10d, 1308(%rsp)
	movl 1396(%rsp), %ebp
	movl 1400(%rsp), %r15d
	movl 1404(%rsp), %r10d
	movl %r10d, 1312(%rsp)
	movl 1408(%rsp), %r10d
	movl %r10d, 1316(%rsp)
	movl 1412(%rsp), %r10d
	movl %r10d, 1320(%rsp)
	movq 592(%rsp), %r10
	movq %r10, 552(%rsp)
	movl 1416(%rsp), %r10d
	movl %r10d, 1324(%rsp)
	movl 1420(%rsp), %r10d
	movl %r10d, 1328(%rsp)
	movl 1424(%rsp), %r10d
	movl %r10d, 1332(%rsp)
	movl 1352(%rsp), %r10d
	movl %r10d, 1336(%rsp)
	movl 1356(%rsp), %r10d
	movl %r10d, 1340(%rsp)
	movl %edi, %edx
	jmp .main_47
.main_13:
.main_72:
	jmp .main_42
.main_14:
	movl $1, %edi
	movl $3, %esi
	movl 840(%rsp), %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_15
.main_40:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %esi
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rdi
	addq %rdx, %rdi
	movl (%rdi), %edi
	movl 828(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rax
	addq %rdx, %rax
	movl %esi, (%rax)
	addl %edi, (%rax)
.main_75:
	movl %edi, 1428(%rsp)
	movl %esi, 1432(%rsp)
	movl 824(%rsp), %esi
	movl 820(%rsp), %edx
.main_43:
.main_76:
	movl 1436(%rsp), %r10d
	movl %r10d, 1360(%rsp)
	movq 600(%rsp), %r10
	movq %r10, 560(%rsp)
	movq 608(%rsp), %r10
	movq %r10, 568(%rsp)
	movl 1440(%rsp), %r10d
	movl %r10d, 1364(%rsp)
	movq 616(%rsp), %r10
	movq %r10, 576(%rsp)
	movl 1444(%rsp), %r10d
	movl %r10d, 1368(%rsp)
	movl 1448(%rsp), %r10d
	movl %r10d, 1372(%rsp)
	movq 624(%rsp), %r10
	movq %r10, 584(%rsp)
	movl 1452(%rsp), %r10d
	movl %r10d, 1376(%rsp)
	movl 1456(%rsp), %r10d
	movl %r10d, 1380(%rsp)
	movl 1460(%rsp), %r10d
	movl %r10d, 1384(%rsp)
	movl 1464(%rsp), %r10d
	movl %r10d, 1388(%rsp)
	movl 1468(%rsp), %r10d
	movl %r10d, 1392(%rsp)
	movl 1472(%rsp), %r10d
	movl %r10d, 1396(%rsp)
	movl 1476(%rsp), %r10d
	movl %r10d, 1400(%rsp)
	movl 1480(%rsp), %r10d
	movl %r10d, 1404(%rsp)
	movl 1484(%rsp), %r10d
	movl %r10d, 1408(%rsp)
	movl 1488(%rsp), %r10d
	movl %r10d, 1412(%rsp)
	movq 632(%rsp), %r10
	movq %r10, 592(%rsp)
	movl 1492(%rsp), %r10d
	movl %r10d, 1416(%rsp)
	movl 1428(%rsp), %r10d
	movl %r10d, 1420(%rsp)
	movl 1432(%rsp), %r10d
	movl %r10d, 1424(%rsp)
	movl %esi, %edi
	movl %edx, %esi
	jmp .main_45
.main_15:
	movl $1, %edx
	movl $8, %edi
	movl 840(%rsp), %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_19
.main_16:
	movl $1, %esi
	movl $0, %edx
	cmpl 824(%rsp), %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_18
.main_17:
	movl 824(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 56(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %edx
	movl %edx, %esi
	movl 824(%rsp), %edi
	subl $1, %edi
.main_67:
	movl %edx, 1496(%rsp)
	movl %esi, %edx
	movl %edi, %r15d
	movl 820(%rsp), %ebp
.main_38:
	movl 836(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rdi
	addq %rsi, %rdi
	movl (%rdi), %r10d
	movl %r10d, 1500(%rsp)
	movl 1500(%rsp), %esi
	addl $1, %esi
	movslq %esi, %rdi
	movq $4, %rsi
	movq %rdx, 640(%rsp)
	movq %rcx, 648(%rsp)
	movq %r8, 656(%rsp)
	movq %r9, 664(%rsp)
	callq calloc
	movq 640(%rsp), %rdx
	movq 648(%rsp), %rcx
	movq 656(%rsp), %r8
	movq 664(%rsp), %r9
	movq %rax, %rsi
	movl 836(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq 72(%rsp), %rax
	addq %rdi, %rax
	movl (%rax), %eax
	movl $0, %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq %rsi, 664(%rsp)
	addq %rdi, 664(%rsp)
	movq 664(%rsp), %r11
	movl %eax, (%r11)
	movq 664(%rsp), %r11
	addl $1, (%r11)
	movl %edx, %edi
	imull $8, %edi
	movslq %edi, %rdi
	movq %rdi, 664(%rsp)
	movq 64(%rsp), %rdi
	addq 664(%rsp), %rdi
	movq %rsi, (%rdi)
	movl 832(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq %rdi, 664(%rsp)
	movq 72(%rsp), %rdi
	addq 664(%rsp), %rdi
	movl %edx, (%rdi)
.main_71:
	movl %eax, 1504(%rsp)
	movl 1500(%rsp), %r10d
	movl %r10d, 1508(%rsp)
	movl 1496(%rsp), %r10d
	movl %r10d, 1512(%rsp)
	movq %rsi, 648(%rsp)
	movl %edx, 1500(%rsp)
	movl %r15d, %edx
	movl %ebp, %edi
.main_41:
.main_74:
	movl %r14d, 1436(%rsp)
	movq 672(%rsp), %r10
	movq %r10, 600(%rsp)
	movq 680(%rsp), %r10
	movq %r10, 608(%rsp)
	movl 1516(%rsp), %r10d
	movl %r10d, 1440(%rsp)
	movq 688(%rsp), %r10
	movq %r10, 616(%rsp)
	movl 1520(%rsp), %r10d
	movl %r10d, 1444(%rsp)
	movl 1524(%rsp), %r10d
	movl %r10d, 1448(%rsp)
	movq 696(%rsp), %r10
	movq %r10, 624(%rsp)
	movl 1528(%rsp), %r10d
	movl %r10d, 1452(%rsp)
	movl 1532(%rsp), %r10d
	movl %r10d, 1456(%rsp)
	movl 1536(%rsp), %r10d
	movl %r10d, 1460(%rsp)
	movl 1540(%rsp), %r10d
	movl %r10d, 1464(%rsp)
	movl 1544(%rsp), %r10d
	movl %r10d, 1468(%rsp)
	movl 1548(%rsp), %r10d
	movl %r10d, 1472(%rsp)
	movl 1552(%rsp), %r10d
	movl %r10d, 1476(%rsp)
	movl 1504(%rsp), %r10d
	movl %r10d, 1480(%rsp)
	movl 1508(%rsp), %r10d
	movl %r10d, 1484(%rsp)
	movl 1512(%rsp), %r10d
	movl %r10d, 1488(%rsp)
	movq 648(%rsp), %r10
	movq %r10, 632(%rsp)
	movl 1500(%rsp), %r10d
	movl %r10d, 1492(%rsp)
	movl %edx, %esi
	movl %edi, %edx
	jmp .main_43
.main_18:
	movl 820(%rsp), %edx
	movl 820(%rsp), %esi
	addl $1, %esi
.main_66:
	movl 824(%rsp), %r15d
	movl %esi, %ebp
	jmp .main_38
.main_19:
	movl $1, %edx
	movl $9, %edi
	movl 840(%rsp), %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_20
.main_36:
	movl 824(%rsp), %edx
	addl $1, %edx
	movl 836(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rdi
	addq %rsi, %rdi
	movl (%rdi), %esi
	movl %edx, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq 56(%rsp), %rdi
	addq %rax, %rdi
	movl %esi, (%rdi)
	movl 836(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rax
	movq 72(%rsp), %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	movl %edi, %eax
	imull $8, %eax
	movslq %eax, %r14
	movq 64(%rsp), %rax
	addq %r14, %rax
	movq 96(%rsp), %r10
	movq %r10, (%rax)
.main_69:
	movl %edi, 1556(%rsp)
	movl %esi, 1560(%rsp)
.main_39:
.main_70:
	movl 1564(%rsp), %r14d
	movq 704(%rsp), %r10
	movq %r10, 672(%rsp)
	movq 712(%rsp), %r10
	movq %r10, 680(%rsp)
	movl 1568(%rsp), %r10d
	movl %r10d, 1516(%rsp)
	movq 720(%rsp), %r10
	movq %r10, 688(%rsp)
	movl 1572(%rsp), %r10d
	movl %r10d, 1520(%rsp)
	movl 1576(%rsp), %r10d
	movl %r10d, 1524(%rsp)
	movq 728(%rsp), %r10
	movq %r10, 696(%rsp)
	movl 1580(%rsp), %r10d
	movl %r10d, 1528(%rsp)
	movl 1584(%rsp), %r10d
	movl %r10d, 1532(%rsp)
	movl 1588(%rsp), %r10d
	movl %r10d, 1536(%rsp)
	movl 1592(%rsp), %r10d
	movl %r10d, 1540(%rsp)
	movl 1596(%rsp), %r10d
	movl %r10d, 1544(%rsp)
	movl 1556(%rsp), %r10d
	movl %r10d, 1548(%rsp)
	movl 1560(%rsp), %r10d
	movl %r10d, 1552(%rsp)
	movl 820(%rsp), %edi
	jmp .main_41
.main_20:
	movl $1, %edi
	movl $4, %esi
	movl 840(%rsp), %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_21
.main_34:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %esi
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rdi
	addq %rdx, %rdi
	movl (%rdi), %edx
	movl 828(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq 72(%rsp), %rax
	addq %rdi, %rax
	movl %esi, (%rax)
	movl (%rax), %r11d
	imull %edx, %r11d
	movl %r11d, (%rax)
.main_65:
	movl %edx, 1600(%rsp)
	movl %esi, 1604(%rsp)
.main_37:
.main_68:
	movl %r13d, 1564(%rsp)
	movq 736(%rsp), %r10
	movq %r10, 704(%rsp)
	movq 744(%rsp), %r10
	movq %r10, 712(%rsp)
	movl 1608(%rsp), %r10d
	movl %r10d, 1568(%rsp)
	movq 752(%rsp), %r10
	movq %r10, 720(%rsp)
	movl 1612(%rsp), %r10d
	movl %r10d, 1572(%rsp)
	movl 1616(%rsp), %r10d
	movl %r10d, 1576(%rsp)
	movq 760(%rsp), %r10
	movq %r10, 728(%rsp)
	movl 1620(%rsp), %r10d
	movl %r10d, 1580(%rsp)
	movl 1624(%rsp), %r10d
	movl %r10d, 1584(%rsp)
	movl 1628(%rsp), %r10d
	movl %r10d, 1588(%rsp)
	movl 1600(%rsp), %r10d
	movl %r10d, 1592(%rsp)
	movl 1604(%rsp), %r10d
	movl %r10d, 1596(%rsp)
	movl 824(%rsp), %edx
	jmp .main_39
.main_21:
	movl $1, %edx
	movl $5, %esi
	movl 840(%rsp), %edi
	cmpl %esi, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %edx
	jnz .main_22
.main_32:
	movl 832(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl 836(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rdi
	addq %rsi, %rdi
	movl (%rdi), %r13d
	movl %edx, %edi
	movl %r13d, %esi
	movq %rdx, 664(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_unsigned_div
	movq 664(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %esi
	movl 828(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq 72(%rsp), %rax
	addq %rdi, %rax
	movl %esi, (%rax)
.main_63:
	movl %esi, 1632(%rsp)
	movl %edx, 1636(%rsp)
	movl %r13d, 1640(%rsp)
.main_35:
.main_64:
	movl 1644(%rsp), %r13d
	movq 768(%rsp), %r10
	movq %r10, 736(%rsp)
	movq %r12, 744(%rsp)
	movl 1648(%rsp), %r10d
	movl %r10d, 1608(%rsp)
	movq 776(%rsp), %r10
	movq %r10, 752(%rsp)
	movl 1652(%rsp), %r10d
	movl %r10d, 1612(%rsp)
	movl 1656(%rsp), %r10d
	movl %r10d, 1616(%rsp)
	movq 784(%rsp), %r10
	movq %r10, 760(%rsp)
	movl 1632(%rsp), %r10d
	movl %r10d, 1620(%rsp)
	movl 1636(%rsp), %r10d
	movl %r10d, 1624(%rsp)
	movl 1640(%rsp), %r10d
	movl %r10d, 1628(%rsp)
	jmp .main_37
.main_22:
	movl $1, %edi
	movl $10, %esi
	movl 840(%rsp), %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_23
.main_30:
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq 72(%rsp), %rsi
	addq %rdx, %rsi
	movl (%rsi), %r12d
	movl %r12d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq printchar
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl %eax, %r13d
	movslq %r13d, %r14
	movl 836(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq 72(%rsp), %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movq 80(%rsp), %rdi
	movl %edx, %esi
	movq %rdx, 664(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %rbx
	callq _c0_cksum_update
	movq 664(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %rbx, %r9
	movq %rax, %rdi
.main_61:
	movq %rax, 792(%rsp)
	movl %edx, 1660(%rsp)
	movq %rdi, %rbx
	movl %r13d, 1664(%rsp)
	movl %r12d, 1668(%rsp)
	movq %r14, 800(%rsp)
.main_33:
.main_62:
	movl %ecx, 1644(%rsp)
	movq 808(%rsp), %r10
	movq %r10, 768(%rsp)
	movq 792(%rsp), %r12
	movl 1660(%rsp), %r10d
	movl %r10d, 1648(%rsp)
	movq %rbx, 776(%rsp)
	movl 1664(%rsp), %r10d
	movl %r10d, 1652(%rsp)
	movl 1668(%rsp), %r10d
	movl %r10d, 1656(%rsp)
	movq 800(%rsp), %r10
	movq %r10, 784(%rsp)
	jmp .main_35
.main_23:
	movl $1, %esi
	movl $7, %edx
	movl 840(%rsp), %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_25
.main_24:
	movq 80(%rsp), %rdi
	callq _c0_cksum_finish
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $1672, %rsp
	ret
.main_25:
	movl $1, %ecx
	movl $11, %edx
	movl 840(%rsp), %esi
	cmpl %edx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .main_27
.main_26:
	movl 836(%rsp), %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq 72(%rsp), %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	subl $1, (%rcx)
.main_59:
.main_29:
.main_31:
.main_60:
	movl %r8d, %ecx
	movq %r9, 808(%rsp)
	jmp .main_33
.main_27:
	callq _c0_crash
	movslq %eax, %r9
.main_58:
	movl %eax, %r8d
	jmp .main_29
.main_55:
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $1672, %rsp
	ret
_c0_read_program:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.read_program_0:
	movl $16, %r9d
	imull $1024, %r9d
	imull $1024, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
.read_program_5:
	movl %r8d, %ecx
.read_program_1:
	movq %rcx, %r12
	movq %r9, %rbx
	callq eof
	movq %r12, %rcx
	movq %rbx, %r9
	movl $1, %edx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %edx
	jnz .read_program_3
.read_program_2:
	movq %rcx, %r12
	movq %r9, %rbx
	callq readchar
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl %ecx, %edi
	addl $1, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %r9, %rdi
	addq %rax, %rdi
	sall $24, %r8d
	sall $16, %edx
	orl %edx, %r8d
	movl %esi, %edx
	sall $8, %edx
	orl %edx, %r8d
	movl %r8d, (%rdi)
	orl %ebx, (%rdi)
	movl %ecx, %r8d
	addl $1, %r8d
.read_program_4:
	movl %r8d, %ecx
	jmp .read_program_1
.read_program_3:
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl %ecx, (%rdx)
	movq %r9, %rax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
