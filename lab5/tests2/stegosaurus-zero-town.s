.file	"../tests2/stegosaurus-zero-town.l4"
.globl _c0_main
_c0_schedule:
	addq $-8, %rsp
.schedule_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_schedule_thread:
	addq $-8, %rsp
.schedule_thread_0:
	movq $0, %r8
	movq $0, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %edx
	movq $0, %rsi
	cmpq %rsi, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .schedule_thread_2
.schedule_thread_1:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_3:
	movq $8, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl $1, %ecx
	movq $0, %rsi
	cmpq %rsi, %rdx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .schedule_thread_5
.schedule_thread_4:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_6:
	movq $16, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl $1, %esi
	movq $0, %rcx
	cmpq %rcx, %rdx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_8
.schedule_thread_7:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_9:
	movq $24, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %edx
	movq $0, %rsi
	cmpq %rsi, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .schedule_thread_11
.schedule_thread_10:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_12:
	movq $32, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_14
.schedule_thread_13:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_15:
	movq $40, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl $1, %esi
	movq $0, %rcx
	cmpq %rcx, %rdx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_17
.schedule_thread_16:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_18:
	movq $48, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_20
.schedule_thread_19:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_21:
	movq $56, %rcx
	movq %rdi, %rdx
	addq %rcx, %rdx
	movl (%rdx), %edx
	movl $1, %esi
	movl $0, %ecx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .schedule_thread_23
.schedule_thread_22:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_24:
	movq $60, %rcx
	movq %rdi, %rdx
	addq %rcx, %rdx
	movl (%rdx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_26
.schedule_thread_25:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_27:
	movq $64, %rcx
	movq %rdi, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_29
.schedule_thread_28:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_30:
	movq $72, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl $1, %esi
	movq $0, %rcx
	cmpq %rcx, %rdx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_32
.schedule_thread_31:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_33:
	movq $80, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl $1, %ecx
	movq $0, %rsi
	cmpq %rsi, %rdx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .schedule_thread_35
.schedule_thread_34:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_36:
	movq $88, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edx
	movl $1, %ecx
	movl $0, %esi
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .schedule_thread_38
.schedule_thread_37:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_39:
	movq $92, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %edx
	movl $0, %esi
	cmpl %esi, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .schedule_thread_41
.schedule_thread_40:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_42:
	movq $96, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_44
.schedule_thread_43:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_45:
	movq $100, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_47
.schedule_thread_46:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_48:
	movq $104, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_50
.schedule_thread_49:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_51:
	movq $112, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_53
.schedule_thread_52:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_54:
	movq $116, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_56
.schedule_thread_55:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_57:
	movq $120, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_59
.schedule_thread_58:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_60:
	movq $124, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_62
.schedule_thread_61:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_63:
	movq $128, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_65
.schedule_thread_64:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_66:
	movq $132, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_68
.schedule_thread_67:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_69:
	movq $136, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_71
.schedule_thread_70:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_72:
	movq $144, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_74
.schedule_thread_73:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_75:
	movq $152, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_77
.schedule_thread_76:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_78:
	movq $160, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movl $1, %esi
	movq $0, %rcx
	cmpq %rcx, %rdx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .schedule_thread_80
.schedule_thread_79:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_81:
	movq $168, %rcx
	movq %rdi, %rdx
	addq %rcx, %rdx
	movl (%rdx), %esi
	movl $1, %ecx
	movl $0, %edx
	cmpl %edx, %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .schedule_thread_83
.schedule_thread_82:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.schedule_thread_84:
	movq $176, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl $1, %ecx
	movq $0, %rdx
	cmpq %rdx, %rsi
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .schedule_thread_86
.schedule_thread_85:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
.schedule_thread_87:
	movq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rax
	addq $8, %rsp
	ret
.schedule_thread_86:
	jmp .schedule_thread_87
.schedule_thread_83:
	jmp .schedule_thread_84
.schedule_thread_80:
	jmp .schedule_thread_81
.schedule_thread_77:
	jmp .schedule_thread_78
.schedule_thread_74:
	jmp .schedule_thread_75
.schedule_thread_71:
	jmp .schedule_thread_72
.schedule_thread_68:
	jmp .schedule_thread_69
.schedule_thread_65:
	jmp .schedule_thread_66
.schedule_thread_62:
	jmp .schedule_thread_63
.schedule_thread_59:
	jmp .schedule_thread_60
.schedule_thread_56:
	jmp .schedule_thread_57
.schedule_thread_53:
	jmp .schedule_thread_54
.schedule_thread_50:
	jmp .schedule_thread_51
.schedule_thread_47:
	jmp .schedule_thread_48
.schedule_thread_44:
	jmp .schedule_thread_45
.schedule_thread_41:
	jmp .schedule_thread_42
.schedule_thread_38:
	jmp .schedule_thread_39
.schedule_thread_35:
	jmp .schedule_thread_36
.schedule_thread_32:
	jmp .schedule_thread_33
.schedule_thread_29:
	jmp .schedule_thread_30
.schedule_thread_26:
	jmp .schedule_thread_27
.schedule_thread_23:
	jmp .schedule_thread_24
.schedule_thread_20:
	jmp .schedule_thread_21
.schedule_thread_17:
	jmp .schedule_thread_18
.schedule_thread_14:
	jmp .schedule_thread_15
.schedule_thread_11:
	jmp .schedule_thread_12
.schedule_thread_8:
	jmp .schedule_thread_9
.schedule_thread_5:
	jmp .schedule_thread_6
.schedule_thread_2:
	jmp .schedule_thread_3
_c0_thread_fork:
	addq $-8, %rsp
.thread_fork_0:
	movq $1, %rdi
	movq $184, %rsi
	callq calloc
	movq %rax, %rdi
	callq _c0_schedule_thread
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_thread_fork
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
