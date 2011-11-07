.file	"../tests1/kite-beerneg.l3"
.globl _c0_main
_c0_bottles:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.bottles_0:
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .bottles_3
.bottles_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.bottles_3:
.bottles_4:
	movl %r9d, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $115, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $102, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $114, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $104, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $119, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $97, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $44, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $115, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $102, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $114, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $33, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $84, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $97, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $107, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $100, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $119, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $44, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $112, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $97, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $115, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $115, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $105, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $97, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $114, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $117, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $100, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $44, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	subl $1, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $115, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $102, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $98, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $114, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $111, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $110, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $116, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $104, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $101, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $119, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $97, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $108, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $46, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	subl $1, %edi
	callq _c0_bottles
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq readint
	movl %eax, %r9d
	movl %r9d, %edi
	callq _c0_bottles
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
