.file	"../tests2/utahraptor-busy.l3"
.globl _c0_main
_c0_castInt:
	addq $-8, %rsp
.castInt_0:
	movl $1, %r8d
	movl %edi, %eax
	cmpl %r8d, %eax
	setne %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_castBool:
	addq $-8, %rsp
.castBool_0:
	movl $1, %r8d
	cmpl %edi, %r8d
	jnz .castBool_3
.castBool_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.castBool_3:
.castBool_4:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_mask:
	addq $-8, %rsp
.mask_0:
	movl $0, %ecx
	movl $0, %r8d
.mask_5:
	movl %ecx, %esi
	movl %r8d, %edx
.mask_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .mask_3
.mask_2:
	movl %esi, %r8d
	sall $1, %r8d
	movl %r8d, %ecx
	orl $1, %ecx
	movl %edx, %r8d
	addl $1, %r8d
.mask_4:
	movl %ecx, %esi
	movl %r8d, %edx
	jmp .mask_1
.mask_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
_c0_getBits:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %ecx
.getBits_0:
	movl %edx, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_mask
	movq %r12, %rcx
	movq %rbx, %r9
	sarl %cl, %r9d
	andl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_setBits:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %esi
	movl %ecx, %edx
.setBits_0:
	movl %esi, %edi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_mask
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movl %r8d, %ecx
	sall %cl, %esi
	movl $-1, %ecx
	xorl %esi, %ecx
	andl %ecx, %r9d
	movl %r8d, %ecx
	sall %cl, %edx
	movl %r9d, %eax
	orl %edx, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_getDex:
	addq $-8, %rsp
.getDex_0:
	movl $18, %esi
	movl $5, %edx
	callq _c0_getBits
	addq $8, %rsp
	ret
_c0_extract:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.extract_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_getDex
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movl $1, %edx
	callq _c0_getBits
	movl %eax, %edi
	callq _c0_castInt
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_writeTape:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.writeTape_0:
	movl %esi, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_getDex
	movq %r12, %rsi
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movq %rsi, %r12
	movq %r8, %rbx
	callq _c0_castBool
	movq %r12, %rsi
	movq %rbx, %r8
	movl %esi, %edi
	movl %r8d, %esi
	movl $1, %edx
	movl %eax, %ecx
	callq _c0_setBits
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_shiftTape:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.shiftTape_0:
	movl %esi, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_getDex
	movq %r12, %rsi
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edx
	cmpl %r9d, %edx
	jnz .shiftTape_2
.shiftTape_1:
	movl %ecx, %r9d
	addl $1, %r9d
.shiftTape_5:
.shiftTape_3:
	movl %esi, %edi
	movl $18, %esi
	movl $5, %edx
	movl %r9d, %ecx
	callq _c0_setBits
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.shiftTape_2:
	movl %ecx, %r9d
	subl $1, %r9d
.shiftTape_4:
	jmp .shiftTape_3
_c0_stateTape:
	addq $-8, %rsp
.stateTape_0:
	movl %esi, %edx
	movl $23, %esi
	movl $2, %r8d
	movl %edi, %ecx
	movl %edx, %edi
	movl %r8d, %edx
	callq _c0_setBits
	addq $8, %rsp
	ret
_c0_step:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.step_0:
	movl %r9d, %edi
	movl $25, %esi
	movl $8, %edx
	movq %r9, %rbx
	callq _c0_getBits
	movq %rbx, %r9
	movl %r9d, %edi
	movl $25, %esi
	movl $8, %edx
	movl %eax, %ecx
	addl $1, %ecx
	callq _c0_setBits
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_stepit:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %esi, %r9d
	movl %edx, %r8d
.stepit_0:
	movl %ecx, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_writeTape
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %r8, %rbx
	callq _c0_shiftTape
	movq %rbx, %r8
	movl %r8d, %edi
	movl %eax, %esi
	callq _c0_stateTape
	movl %eax, %edi
	callq _c0_step
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_busy:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.busy_0:
	movl %r9d, %edi
	movl $23, %esi
	movl $2, %edx
	movq %r9, %rbx
	callq _c0_getBits
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_extract
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .busy_17
.busy_1:
	movl $1, %edx
	movl $0, %esi
	movl %r8d, %ecx
	cmpl %esi, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .busy_4
.busy_2:
	movl $1, %edi
	movl $1, %esi
	movl $1, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_4:
.busy_5:
	movl $1, %ecx
	movl $1, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .busy_8
.busy_6:
	movl $1, %edi
	movl $0, %esi
	movl $0, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_8:
.busy_9:
	movl $1, %ecx
	movl $2, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .busy_12
.busy_10:
	movl $1, %edi
	movl %r9d, %esi
	callq _c0_writeTape
	movl %eax, %r9d
	movl $1, %edi
	movl %r9d, %esi
	callq _c0_shiftTape
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_12:
.busy_13:
	movl $1, %edx
	movl $3, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .busy_16
.busy_14:
	movl $1, %edi
	movl $1, %esi
	movl $3, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_16:
.busy_33:
.busy_35:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_17:
	movl $1, %esi
	movl $0, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .busy_20
.busy_18:
	movl $1, %edi
	movl $0, %esi
	movl $1, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_20:
.busy_21:
	movl $1, %esi
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .busy_24
.busy_22:
	movl $0, %edi
	movl $0, %esi
	movl $2, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_24:
.busy_25:
	movl $1, %ecx
	movl $2, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .busy_28
.busy_26:
	movl $1, %edi
	movl $0, %esi
	movl $3, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_28:
.busy_29:
	movl $1, %edx
	movl $3, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .busy_32
.busy_30:
	movl $0, %edi
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	callq _c0_stepit
	movl %eax, %edi
	callq _c0_busy
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.busy_32:
.busy_34:
	jmp .busy_35
_c0_countOnes:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.countOnes_0:
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .countOnes_3
.countOnes_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.countOnes_3:
.countOnes_4:
	movl %r9d, %edi
	sarl $1, %edi
	movq %r9, %rbx
	callq _c0_countOnes
	movq %rbx, %r9
	andl $1, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %edi
	movl $18, %esi
	movl $5, %edx
	movl $13, %ecx
	callq _c0_setBits
	movl %eax, %edi
	callq _c0_busy
	movl %eax, %r9d
	movl %r9d, %edi
	movl $0, %esi
	movl $18, %edx
	movq %r9, %rbx
	callq _c0_getBits
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_countOnes
	movq %rbx, %r9
	imull %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
