.file	"../tests2/saltopus-binsearch.l3"
.globl _c0_main
_c0_print:
	addq $-8, %rsp
.print_0:
	callq printint
	movl $10, %edi
	callq printchar
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_binsearch:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %ecx
.binsearch_0:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .binsearch_3
.binsearch_1:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.binsearch_3:
.binsearch_4:
	movl %r8d, %eax
	addl %ecx, %eax
	movl $2, %esi
	cltd
	idivl %esi
	movl %eax, %edx
	movl %edx, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_index
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl %eax, %esi
	cmpl %r9d, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .binsearch_6
.binsearch_5:
	movl %edx, %edi
	movq %rdx, %rbx
	callq _c0_print
	movq %rbx, %rdx
	movl %edx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.binsearch_6:
	movl $1, %edi
	movl %eax, %esi
	cmpl %r9d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .binsearch_8
.binsearch_7:
	movl %r9d, %edi
	movl %edx, %esi
	addl $1, %esi
	movl %ecx, %edx
	callq _c0_binsearch
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.binsearch_8:
	movl $1, %esi
	movl %r9d, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .binsearch_10
.binsearch_9:
	movl %r9d, %edi
	movl %r8d, %esi
	callq _c0_binsearch
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.binsearch_10:
	movl $33, %edi
	callq printchar
	movl $10, %edi
	callq printchar
	movl $5, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
.main_13:
.main_1:
	movl $1, %edx
	movl $100, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_2:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_index
	movq %rbx, %r9
	movl %eax, %edi
	movl $0, %esi
	movl $100, %edx
	movq %r9, %rbx
	callq _c0_binsearch
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_index
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_index
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_5
.main_3:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_5:
.main_6:
	addl $1, %r9d
.main_12:
	jmp .main_1
.main_7:
	movl $94839487, %edi
	movl $0, %esi
	movl $100, %edx
	callq _c0_binsearch
	movl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_10
.main_8:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
.main_11:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_index:
	addq $-8, %rsp
	movl %edi, %eax
.index_0:
	movl $1, %ecx
	movl $0, %r9d
	movl %eax, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .index_2
.index_1:
	movl $0, %eax
	subl $967032439, %eax
	addq $8, %rsp
	ret
.index_2:
	movl $1, %r9d
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .index_4
.index_3:
	movl $0, %eax
	subl $953930047, %eax
	addq $8, %rsp
	ret
.index_4:
	movl $1, %ecx
	movl $2, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_6
.index_5:
	movl $0, %eax
	subl $921700613, %eax
	addq $8, %rsp
	ret
.index_6:
	movl $1, %ecx
	movl $3, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_8
.index_7:
	movl $0, %eax
	subl $920259173, %eax
	addq $8, %rsp
	ret
.index_8:
	movl $1, %ecx
	movl $4, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_10
.index_9:
	movl $0, %eax
	subl $896867576, %eax
	addq $8, %rsp
	ret
.index_10:
	movl $1, %ecx
	movl $5, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_12
.index_11:
	movl $0, %eax
	subl $869512193, %eax
	addq $8, %rsp
	ret
.index_12:
	movl $1, %ecx
	movl $6, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_14
.index_13:
	movl $0, %eax
	subl $842655412, %eax
	addq $8, %rsp
	ret
.index_14:
	movl $1, %ecx
	movl $7, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_16
.index_15:
	movl $0, %eax
	subl $828158606, %eax
	addq $8, %rsp
	ret
.index_16:
	movl $1, %ecx
	movl $8, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_18
.index_17:
	movl $0, %eax
	subl $802888419, %eax
	addq $8, %rsp
	ret
.index_18:
	movl $1, %ecx
	movl $9, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_20
.index_19:
	movl $0, %eax
	subl $795813315, %eax
	addq $8, %rsp
	ret
.index_20:
	movl $1, %ecx
	movl $10, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_22
.index_21:
	movl $0, %eax
	subl $762345137, %eax
	addq $8, %rsp
	ret
.index_22:
	movl $1, %ecx
	movl $11, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_24
.index_23:
	movl $0, %eax
	subl $750502135, %eax
	addq $8, %rsp
	ret
.index_24:
	movl $1, %r9d
	movl $12, %ecx
	movl %eax, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .index_26
.index_25:
	movl $0, %eax
	subl $724019762, %eax
	addq $8, %rsp
	ret
.index_26:
	movl $1, %ecx
	movl $13, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_28
.index_27:
	movl $0, %eax
	subl $703333351, %eax
	addq $8, %rsp
	ret
.index_28:
	movl $1, %ecx
	movl $14, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_30
.index_29:
	movl $0, %eax
	subl $682665393, %eax
	addq $8, %rsp
	ret
.index_30:
	movl $1, %ecx
	movl $15, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_32
.index_31:
	movl $0, %eax
	subl $673581901, %eax
	addq $8, %rsp
	ret
.index_32:
	movl $1, %ecx
	movl $16, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_34
.index_33:
	movl $0, %eax
	subl $655493130, %eax
	addq $8, %rsp
	ret
.index_34:
	movl $1, %ecx
	movl $17, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_36
.index_35:
	movl $0, %eax
	subl $648353348, %eax
	addq $8, %rsp
	ret
.index_36:
	movl $1, %ecx
	movl $18, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_38
.index_37:
	movl $0, %eax
	subl $626976268, %eax
	addq $8, %rsp
	ret
.index_38:
	movl $1, %ecx
	movl $19, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_40
.index_39:
	movl $0, %eax
	subl $624703341, %eax
	addq $8, %rsp
	ret
.index_40:
	movl $1, %ecx
	movl $20, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_42
.index_41:
	movl $0, %eax
	subl $577376035, %eax
	addq $8, %rsp
	ret
.index_42:
	movl $1, %ecx
	movl $21, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_44
.index_43:
	movl $0, %eax
	subl $571993101, %eax
	addq $8, %rsp
	ret
.index_44:
	movl $1, %ecx
	movl $22, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_46
.index_45:
	movl $0, %eax
	subl $562316609, %eax
	addq $8, %rsp
	ret
.index_46:
	movl $1, %ecx
	movl $23, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_48
.index_47:
	movl $0, %eax
	subl $555046942, %eax
	addq $8, %rsp
	ret
.index_48:
	movl $1, %ecx
	movl $24, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_50
.index_49:
	movl $0, %eax
	subl $536427763, %eax
	addq $8, %rsp
	ret
.index_50:
	movl $1, %ecx
	movl $25, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_52
.index_51:
	movl $0, %eax
	subl $512313509, %eax
	addq $8, %rsp
	ret
.index_52:
	movl $1, %ecx
	movl $26, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_54
.index_53:
	movl $0, %eax
	subl $500377534, %eax
	addq $8, %rsp
	ret
.index_54:
	movl $1, %ecx
	movl $27, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_56
.index_55:
	movl $0, %eax
	subl $463480611, %eax
	addq $8, %rsp
	ret
.index_56:
	movl $1, %ecx
	movl $28, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_58
.index_57:
	movl $0, %eax
	subl $461309576, %eax
	addq $8, %rsp
	ret
.index_58:
	movl $1, %ecx
	movl $29, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_60
.index_59:
	movl $0, %eax
	subl $432282274, %eax
	addq $8, %rsp
	ret
.index_60:
	movl $1, %ecx
	movl $30, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_62
.index_61:
	movl $0, %eax
	subl $418690381, %eax
	addq $8, %rsp
	ret
.index_62:
	movl $1, %ecx
	movl $31, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_64
.index_63:
	movl $0, %eax
	subl $398694155, %eax
	addq $8, %rsp
	ret
.index_64:
	movl $1, %ecx
	movl $32, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_66
.index_65:
	movl $0, %eax
	subl $387477548, %eax
	addq $8, %rsp
	ret
.index_66:
	movl $1, %ecx
	movl $33, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_68
.index_67:
	movl $0, %eax
	subl $386331574, %eax
	addq $8, %rsp
	ret
.index_68:
	movl $1, %ecx
	movl $34, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_70
.index_69:
	movl $0, %eax
	subl $367187619, %eax
	addq $8, %rsp
	ret
.index_70:
	movl $1, %ecx
	movl $35, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_72
.index_71:
	movl $0, %eax
	subl $306408313, %eax
	addq $8, %rsp
	ret
.index_72:
	movl $1, %ecx
	movl $36, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_74
.index_73:
	movl $0, %eax
	subl $279578284, %eax
	addq $8, %rsp
	ret
.index_74:
	movl $1, %ecx
	movl $37, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_76
.index_75:
	movl $0, %eax
	subl $239695552, %eax
	addq $8, %rsp
	ret
.index_76:
	movl $1, %ecx
	movl $38, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_78
.index_77:
	movl $0, %eax
	subl $229213980, %eax
	addq $8, %rsp
	ret
.index_78:
	movl $1, %ecx
	movl $39, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_80
.index_79:
	movl $0, %eax
	subl $223865030, %eax
	addq $8, %rsp
	ret
.index_80:
	movl $1, %ecx
	movl $40, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_82
.index_81:
	movl $0, %eax
	subl $130949210, %eax
	addq $8, %rsp
	ret
.index_82:
	movl $1, %ecx
	movl $41, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_84
.index_83:
	movl $0, %eax
	subl $118983235, %eax
	addq $8, %rsp
	ret
.index_84:
	movl $1, %ecx
	movl $42, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_86
.index_85:
	movl $0, %eax
	subl $115358838, %eax
	addq $8, %rsp
	ret
.index_86:
	movl $1, %ecx
	movl $43, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_88
.index_87:
	movl $0, %eax
	subl $77163386, %eax
	addq $8, %rsp
	ret
.index_88:
	movl $1, %ecx
	movl $44, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_90
.index_89:
	movl $0, %eax
	subl $67499140, %eax
	addq $8, %rsp
	ret
.index_90:
	movl $1, %ecx
	movl $45, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_92
.index_91:
	movl $0, %eax
	subl $57664228, %eax
	addq $8, %rsp
	ret
.index_92:
	movl $1, %ecx
	movl $46, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_94
.index_93:
	movl $0, %eax
	subl $56718953, %eax
	addq $8, %rsp
	ret
.index_94:
	movl $1, %ecx
	movl $47, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_96
.index_95:
	movl $0, %eax
	subl $24245174, %eax
	addq $8, %rsp
	ret
.index_96:
	movl $1, %ecx
	movl $48, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_98
.index_97:
	movl $0, %eax
	subl $18898667, %eax
	addq $8, %rsp
	ret
.index_98:
	movl $1, %ecx
	movl $49, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_100
.index_99:
	movl $0, %eax
	subl $18124014, %eax
	addq $8, %rsp
	ret
.index_100:
	movl $1, %ecx
	movl $50, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_102
.index_101:
	movl $0, %eax
	subl $3964890, %eax
	addq $8, %rsp
	ret
.index_102:
	movl $1, %ecx
	movl $51, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_104
.index_103:
	movl $25647500, %eax
	addq $8, %rsp
	ret
.index_104:
	movl $1, %ecx
	movl $52, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_106
.index_105:
	movl $43892620, %eax
	addq $8, %rsp
	ret
.index_106:
	movl $1, %ecx
	movl $53, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_108
.index_107:
	movl $53619708, %eax
	addq $8, %rsp
	ret
.index_108:
	movl $1, %ecx
	movl $54, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_110
.index_109:
	movl $91608201, %eax
	addq $8, %rsp
	ret
.index_110:
	movl $1, %ecx
	movl $55, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_112
.index_111:
	movl $114841762, %eax
	addq $8, %rsp
	ret
.index_112:
	movl $1, %ecx
	movl $56, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_114
.index_113:
	movl $122980207, %eax
	addq $8, %rsp
	ret
.index_114:
	movl $1, %ecx
	movl $57, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_116
.index_115:
	movl $141823367, %eax
	addq $8, %rsp
	ret
.index_116:
	movl $1, %ecx
	movl $58, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_118
.index_117:
	movl $157101635, %eax
	addq $8, %rsp
	ret
.index_118:
	movl $1, %ecx
	movl $59, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_120
.index_119:
	movl $165290048, %eax
	addq $8, %rsp
	ret
.index_120:
	movl $1, %ecx
	movl $60, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_122
.index_121:
	movl $189880665, %eax
	addq $8, %rsp
	ret
.index_122:
	movl $1, %ecx
	movl $61, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_124
.index_123:
	movl $198520449, %eax
	addq $8, %rsp
	ret
.index_124:
	movl $1, %ecx
	movl $62, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_126
.index_125:
	movl $237525967, %eax
	addq $8, %rsp
	ret
.index_126:
	movl $1, %ecx
	movl $63, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_128
.index_127:
	movl $253694948, %eax
	addq $8, %rsp
	ret
.index_128:
	movl $1, %ecx
	movl $64, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_130
.index_129:
	movl $266526889, %eax
	addq $8, %rsp
	ret
.index_130:
	movl $1, %ecx
	movl $65, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_132
.index_131:
	movl $279696398, %eax
	addq $8, %rsp
	ret
.index_132:
	movl $1, %ecx
	movl $66, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_134
.index_133:
	movl $295973117, %eax
	addq $8, %rsp
	ret
.index_134:
	movl $1, %ecx
	movl $67, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_136
.index_135:
	movl $321309079, %eax
	addq $8, %rsp
	ret
.index_136:
	movl $1, %ecx
	movl $68, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_138
.index_137:
	movl $328035856, %eax
	addq $8, %rsp
	ret
.index_138:
	movl $1, %ecx
	movl $69, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_140
.index_139:
	movl $328802770, %eax
	addq $8, %rsp
	ret
.index_140:
	movl $1, %ecx
	movl $70, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_142
.index_141:
	movl $336258247, %eax
	addq $8, %rsp
	ret
.index_142:
	movl $1, %ecx
	movl $71, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_144
.index_143:
	movl $367288075, %eax
	addq $8, %rsp
	ret
.index_144:
	movl $1, %ecx
	movl $72, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_146
.index_145:
	movl $423529406, %eax
	addq $8, %rsp
	ret
.index_146:
	movl $1, %ecx
	movl $73, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_148
.index_147:
	movl $423772741, %eax
	addq $8, %rsp
	ret
.index_148:
	movl $1, %ecx
	movl $74, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_150
.index_149:
	movl $480481598, %eax
	addq $8, %rsp
	ret
.index_150:
	movl $1, %ecx
	movl $75, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_152
.index_151:
	movl $500550491, %eax
	addq $8, %rsp
	ret
.index_152:
	movl $1, %ecx
	movl $76, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_154
.index_153:
	movl $505901620, %eax
	addq $8, %rsp
	ret
.index_154:
	movl $1, %ecx
	movl $77, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_156
.index_155:
	movl $507642370, %eax
	addq $8, %rsp
	ret
.index_156:
	movl $1, %ecx
	movl $78, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_158
.index_157:
	movl $514129779, %eax
	addq $8, %rsp
	ret
.index_158:
	movl $1, %ecx
	movl $79, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_160
.index_159:
	movl $517235446, %eax
	addq $8, %rsp
	ret
.index_160:
	movl $1, %ecx
	movl $80, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_162
.index_161:
	movl $521228843, %eax
	addq $8, %rsp
	ret
.index_162:
	movl $1, %ecx
	movl $81, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_164
.index_163:
	movl $546729540, %eax
	addq $8, %rsp
	ret
.index_164:
	movl $1, %ecx
	movl $82, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_166
.index_165:
	movl $561722476, %eax
	addq $8, %rsp
	ret
.index_166:
	movl $1, %ecx
	movl $83, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_168
.index_167:
	movl $563391042, %eax
	addq $8, %rsp
	ret
.index_168:
	movl $1, %ecx
	movl $84, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_170
.index_169:
	movl $567074828, %eax
	addq $8, %rsp
	ret
.index_170:
	movl $1, %ecx
	movl $85, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_172
.index_171:
	movl $588841045, %eax
	addq $8, %rsp
	ret
.index_172:
	movl $1, %ecx
	movl $86, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_174
.index_173:
	movl $613759501, %eax
	addq $8, %rsp
	ret
.index_174:
	movl $1, %ecx
	movl $87, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_176
.index_175:
	movl $635950129, %eax
	addq $8, %rsp
	ret
.index_176:
	movl $1, %ecx
	movl $88, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_178
.index_177:
	movl $639849800, %eax
	addq $8, %rsp
	ret
.index_178:
	movl $1, %ecx
	movl $89, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_180
.index_179:
	movl $672940379, %eax
	addq $8, %rsp
	ret
.index_180:
	movl $1, %ecx
	movl $90, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_182
.index_181:
	movl $713557614, %eax
	addq $8, %rsp
	ret
.index_182:
	movl $1, %ecx
	movl $91, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_184
.index_183:
	movl $728663744, %eax
	addq $8, %rsp
	ret
.index_184:
	movl $1, %ecx
	movl $92, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_186
.index_185:
	movl $739528895, %eax
	addq $8, %rsp
	ret
.index_186:
	movl $1, %ecx
	movl $93, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_188
.index_187:
	movl $791912760, %eax
	addq $8, %rsp
	ret
.index_188:
	movl $1, %ecx
	movl $94, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_190
.index_189:
	movl $835282825, %eax
	addq $8, %rsp
	ret
.index_190:
	movl $1, %ecx
	movl $95, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_192
.index_191:
	movl $907846724, %eax
	addq $8, %rsp
	ret
.index_192:
	movl $1, %ecx
	movl $96, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_194
.index_193:
	movl $933091123, %eax
	addq $8, %rsp
	ret
.index_194:
	movl $1, %ecx
	movl $97, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_196
.index_195:
	movl $941618978, %eax
	addq $8, %rsp
	ret
.index_196:
	movl $1, %ecx
	movl $98, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_198
.index_197:
	movl $989536002, %eax
	addq $8, %rsp
	ret
.index_198:
	movl $1, %ecx
	movl $99, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .index_200
.index_199:
	movl $998693052, %eax
	addq $8, %rsp
	ret
.index_200:
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
