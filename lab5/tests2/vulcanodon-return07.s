.file	"../tests2/vulcanodon-return07.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %ecx
	movl $2, %r8d
.main_23:
	movl %ecx, %esi
.main_1:
	movl $1, %edi
	movl $100, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .main_21
.main_2:
	movl $1, %ecx
	movl $2, %edx
.main_25:
	movl %edx, %edi
.main_3:
	movl $1, %eax
	movl %edi, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_27
.main_4:
	movl %r8d, %eax
	cltd
	idivl %edi
	movl %edx, %r12d
	movl $1, %ebx
	movl $0, %eax
	movl %r12d, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ebx
	jnz .main_7
.main_5:
	movl $0, %edx
	jmp .main_26
.main_7:
.main_8:
	movl %edi, %edx
	addl $1, %edx
.main_24:
	movl %r12d, %r9d
	movl %edx, %edi
	jmp .main_3
.main_27:
	movl %ecx, %eax
.main_9:
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .main_11
.main_10:
	movl %r8d, %ecx
.main_29:
	movl %ecx, %edi
.main_12:
	cmpl $0, %eax
	jnz .ternary_true37
	movl $0, %edx
	jmp .ternary_end38
.ternary_true37:
	movl $2, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end38:
	cmpl $0, %edx
	jnz .ternary_true35
	movl $0, %edx
	jmp .ternary_end36
.ternary_true35:
	movl $3, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end36:
	cmpl $0, %edx
	jnz .ternary_true33
	movl $0, %edx
	jmp .ternary_end34
.ternary_true33:
	movl $5, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end34:
	cmpl $0, %edx
	jnz .ternary_true31
	movl $0, %edx
	jmp .ternary_end32
.ternary_true31:
	movl $7, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end32:
	cmpl $0, %edx
	jnz .ternary_true29
	movl $0, %edx
	jmp .ternary_end30
.ternary_true29:
	movl $11, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end30:
	cmpl $0, %edx
	jnz .ternary_true27
	movl $0, %ecx
	jmp .ternary_end28
.ternary_true27:
	movl $13, %ecx
	cmpl %ecx, %r8d
	jnz .ternary_true41
	movl $0, %edx
	jmp .ternary_end42
.ternary_true41:
	movl $17, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end42:
	cmpl $0, %edx
	jnz .ternary_true39
	movl $0, %edx
	jmp .ternary_end40
.ternary_true39:
	movl $19, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end40:
	movl %edx, %ecx
.ternary_end28:
	cmpl $0, %ecx
	jnz .ternary_true25
	movl $0, %ecx
	jmp .ternary_end26
.ternary_true25:
	movl $23, %ecx
	cmpl %ecx, %r8d
	jnz .ternary_true49
	movl $0, %edx
	jmp .ternary_end50
.ternary_true49:
	movl $29, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end50:
	cmpl $0, %edx
	jnz .ternary_true47
	movl $0, %edx
	jmp .ternary_end48
.ternary_true47:
	movl $31, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end48:
	cmpl $0, %edx
	jnz .ternary_true45
	movl $0, %edx
	jmp .ternary_end46
.ternary_true45:
	movl $37, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end46:
	cmpl $0, %edx
	jnz .ternary_true43
	movl $0, %ecx
	jmp .ternary_end44
.ternary_true43:
	movl $41, %ecx
	cmpl %ecx, %r8d
	jnz .ternary_true51
	movl $0, %edx
	jmp .ternary_end52
.ternary_true51:
	movl $43, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end52:
	movl %edx, %ecx
.ternary_end44:
.ternary_end26:
	cmpl $0, %ecx
	jnz .ternary_true23
	movl $0, %edx
	jmp .ternary_end24
.ternary_true23:
	movl $47, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end24:
	cmpl $0, %edx
	jnz .ternary_true21
	movl $0, %edx
	jmp .ternary_end22
.ternary_true21:
	movl $53, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end22:
	cmpl $0, %edx
	jnz .ternary_true19
	movl $0, %edx
	jmp .ternary_end20
.ternary_true19:
	movl $59, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end20:
	cmpl $0, %edx
	jnz .ternary_true17
	movl $0, %edx
	jmp .ternary_end18
.ternary_true17:
	movl $61, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end18:
	cmpl $0, %edx
	jnz .ternary_true15
	movl $0, %edx
	jmp .ternary_end16
.ternary_true15:
	movl $67, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end16:
	cmpl $0, %edx
	jnz .ternary_true13
	movl $0, %edx
	jmp .ternary_end14
.ternary_true13:
	movl $71, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end14:
	cmpl $0, %edx
	jnz .ternary_true11
	movl $0, %edx
	jmp .ternary_end12
.ternary_true11:
	movl $73, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end12:
	cmpl $0, %edx
	jnz .ternary_true9
	movl $0, %edx
	jmp .ternary_end10
.ternary_true9:
	movl $79, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end10:
	cmpl $0, %edx
	jnz .ternary_true7
	movl $0, %edx
	jmp .ternary_end8
.ternary_true7:
	movl $79, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end8:
	cmpl $0, %edx
	jnz .ternary_true5
	movl $0, %edx
	jmp .ternary_end6
.ternary_true5:
	movl $83, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end6:
	cmpl $0, %edx
	jnz .ternary_true3
	movl $0, %edx
	jmp .ternary_end4
.ternary_true3:
	movl $89, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end4:
	cmpl $0, %edx
	jnz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $97, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .main_15
.main_13:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_15:
.main_16:
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .ternary_true53
	movl $0, %ecx
	jmp .ternary_end54
.ternary_true53:
	movl $2, %ecx
	cmpl %ecx, %r8d
	jz .ternary_true103
	movl $3, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end104
.ternary_true103:
	movl $1, %ecx
.ternary_end104:
	cmpl $0, %ecx
	jnz .ternary_true101
	movl $5, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end102
.ternary_true101:
	movl $1, %ecx
.ternary_end102:
	cmpl $0, %ecx
	jnz .ternary_true99
	movl $7, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end100
.ternary_true99:
	movl $1, %ecx
.ternary_end100:
	cmpl $0, %ecx
	jnz .ternary_true97
	movl $11, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end98
.ternary_true97:
	movl $1, %ecx
.ternary_end98:
	cmpl $0, %ecx
	jnz .ternary_true95
	movl $13, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end96
.ternary_true95:
	movl $1, %ecx
.ternary_end96:
	cmpl $0, %ecx
	jnz .ternary_true93
	movl $17, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end94
.ternary_true93:
	movl $1, %ecx
.ternary_end94:
	cmpl $0, %ecx
	jnz .ternary_true91
	movl $19, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end92
.ternary_true91:
	movl $1, %ecx
.ternary_end92:
	cmpl $0, %ecx
	jnz .ternary_true89
	movl $23, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end90
.ternary_true89:
	movl $1, %ecx
.ternary_end90:
	cmpl $0, %ecx
	jnz .ternary_true87
	movl $29, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end88
.ternary_true87:
	movl $1, %ecx
.ternary_end88:
	cmpl $0, %ecx
	jnz .ternary_true85
	movl $31, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end86
.ternary_true85:
	movl $1, %ecx
.ternary_end86:
	cmpl $0, %ecx
	jnz .ternary_true83
	movl $37, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end84
.ternary_true83:
	movl $1, %ecx
.ternary_end84:
	cmpl $0, %ecx
	jnz .ternary_true81
	movl $41, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end82
.ternary_true81:
	movl $1, %ecx
.ternary_end82:
	cmpl $0, %ecx
	jnz .ternary_true79
	movl $43, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end80
.ternary_true79:
	movl $1, %ecx
.ternary_end80:
	cmpl $0, %ecx
	jnz .ternary_true77
	movl $47, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end78
.ternary_true77:
	movl $1, %ecx
.ternary_end78:
	cmpl $0, %ecx
	jnz .ternary_true75
	movl $53, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end76
.ternary_true75:
	movl $1, %ecx
.ternary_end76:
	cmpl $0, %ecx
	jnz .ternary_true73
	movl $59, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end74
.ternary_true73:
	movl $1, %ecx
.ternary_end74:
	cmpl $0, %ecx
	jnz .ternary_true71
	movl $61, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end72
.ternary_true71:
	movl $1, %ecx
.ternary_end72:
	cmpl $0, %ecx
	jnz .ternary_true69
	movl $67, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end70
.ternary_true69:
	movl $1, %ecx
.ternary_end70:
	cmpl $0, %ecx
	jnz .ternary_true67
	movl $71, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end68
.ternary_true67:
	movl $1, %ecx
.ternary_end68:
	cmpl $0, %ecx
	jnz .ternary_true65
	movl $73, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end66
.ternary_true65:
	movl $1, %ecx
.ternary_end66:
	cmpl $0, %ecx
	jnz .ternary_true63
	movl $79, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end64
.ternary_true63:
	movl $1, %ecx
.ternary_end64:
	cmpl $0, %ecx
	jnz .ternary_true61
	movl $79, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end62
.ternary_true61:
	movl $1, %ecx
.ternary_end62:
	cmpl $0, %ecx
	jnz .ternary_true59
	movl $83, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end60
.ternary_true59:
	movl $1, %ecx
.ternary_end60:
	cmpl $0, %ecx
	jnz .ternary_true57
	movl $89, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end58
.ternary_true57:
	movl $1, %ecx
.ternary_end58:
	cmpl $0, %ecx
	jnz .ternary_true55
	movl $97, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end56
.ternary_true55:
	movl $1, %ecx
.ternary_end56:
.ternary_end54:
	movl $1, %edx
	cmpl %ecx, %edx
	jnz .main_19
.main_17:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_19:
.main_20:
	addl $1, %r8d
.main_22:
	movl %edi, %esi
	jmp .main_1
.main_11:
.main_28:
	movl %esi, %edi
	jmp .main_12
.main_21:
	movl %esi, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_26:
	movl %edx, %eax
	jmp .main_9
.ident	"15-411 L4 reference compiler"
