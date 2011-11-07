.file	"../tests1/lammergeier-feraligatr.l3"
.globl _c0_main
_c0_scalex:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.scalex_0:
	movl $7, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %r8d
	movl $2, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fdiv
	movq %rbx, %r9
	movl %eax, %r8d
	movl $5, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $2, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edi
	movl %eax, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $50, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %rcx, %r12
	movq %r8, %rbx
	callq fdiv
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %edi
	movl %r8d, %esi
	movq %rcx, %rbx
	callq fmul
	movq %rbx, %rcx
	movl %eax, %r9d
	movl %r9d, %edi
	movl %ecx, %esi
	callq fsub
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_scaley:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.scaley_0:
	movl $25, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq fdiv
	movl %eax, %r9d
	movl $1, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq fsub
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_mandelbrot:
	addq $-408, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, 240(%rsp)
.mandelbrot_0:
	movl $0, %esi
.mandelbrot_17:
	movl %esi, 244(%rsp)
.mandelbrot_1:
	movl $1, %edi
	movl $50, %esi
	movl 244(%rsp), %eax
	cmpl %esi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %edi
	jnz .mandelbrot_15
.mandelbrot_2:
	movl $0, %esi
.mandelbrot_19:
	movl %esi, 248(%rsp)
.mandelbrot_3:
	movl $1, %eax
	movl $50, %edi
	movl 248(%rsp), %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .mandelbrot_14
.mandelbrot_4:
	movl $0, %esi
	movl 248(%rsp), %edi
	movq %rsi, 64(%rsp)
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq tofloat
	movq 64(%rsp), %rsi
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl %eax, %r14d
	movl %r14d, %edi
	movq %rsi, 72(%rsp)
	movq %rdx, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq _c0_scalex
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, 252(%rsp)
	movl 252(%rsp), %r10d
	movl %r10d, 256(%rsp)
	movl 244(%rsp), %edi
	movq %rsi, 80(%rsp)
	movq %rdx, 72(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq tofloat
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, 260(%rsp)
	movl 260(%rsp), %edi
	movq %rsi, 80(%rsp)
	movq %rdx, 72(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq _c0_scaley
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, 264(%rsp)
	movl 264(%rsp), %r10d
	movl %r10d, 268(%rsp)
	movl $0, %edi
	movq %rsi, 80(%rsp)
	movq %rdx, 72(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq tofloat
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, 272(%rsp)
	movl 272(%rsp), %r12d
	movl $0, %edi
	movq %rsi, 88(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq tofloat
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, 276(%rsp)
	movl 276(%rsp), %edi
.mandelbrot_21:
	movl 280(%rsp), %r10d
	movl %r10d, 284(%rsp)
	movl 288(%rsp), %r10d
	movl %r10d, 292(%rsp)
	movl 296(%rsp), %r10d
	movl %r10d, 300(%rsp)
	movl %r13d, 304(%rsp)
	movl %ebx, 308(%rsp)
	movl 312(%rsp), %r10d
	movl %r10d, 316(%rsp)
	movl 320(%rsp), %r10d
	movl %r10d, 324(%rsp)
	movl 328(%rsp), %r10d
	movl %r10d, 332(%rsp)
	movl 336(%rsp), %r10d
	movl %r10d, 340(%rsp)
	movl %edi, 344(%rsp)
	movl %r12d, 348(%rsp)
	movl %esi, 352(%rsp)
.mandelbrot_5:
	movl 348(%rsp), %edi
	movl 348(%rsp), %esi
	movq %rdx, 72(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq fmul
	movq 72(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, 356(%rsp)
	movl 344(%rsp), %edi
	movl 344(%rsp), %esi
	movq %rdx, 72(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq fmul
	movq 72(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl 356(%rsp), %edi
	movl %r12d, %esi
	movq %rdx, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq fadd
	movq 80(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %r15d
	movl %r15d, %edi
	movq %rdx, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, %rbp
	callq fromfloat
	movq 88(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movl $4, %esi
	cmpl %esi, %ebp
	jl .ternary_true1
	movl $0, 360(%rsp)
	jmp .ternary_end2
.ternary_true1:
	movl 352(%rsp), %r10d
	movl %r10d, 360(%rsp)
	movl 240(%rsp), %r10d
	cmpl %r10d, 360(%rsp)
	setl %r11b
	movzbl %r11b, %r11d
	movl %r11d, 360(%rsp)
.ternary_end2:
	movl $1, %esi
	cmpl 360(%rsp), %esi
	jnz .mandelbrot_7
.mandelbrot_6:
	movl 348(%rsp), %edi
	movl 348(%rsp), %esi
	movq %rdx, 96(%rsp)
	movq %rcx, 104(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq fmul
	movq 96(%rsp), %rdx
	movq 104(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 364(%rsp)
	movl 344(%rsp), %edi
	movl 344(%rsp), %esi
	movq %rdx, 112(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 88(%rsp)
	callq fmul
	movq 112(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 88(%rsp), %r9
	movl %eax, 368(%rsp)
	movl 364(%rsp), %edi
	movl 368(%rsp), %esi
	movq %rdx, 120(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	callq fsub
	movq 120(%rsp), %rdx
	movq 112(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movl %eax, 316(%rsp)
	movl 316(%rsp), %edi
	movl 256(%rsp), %esi
	movq %rdx, 128(%rsp)
	movq %rcx, 120(%rsp)
	movq %r8, 112(%rsp)
	movq %r9, 96(%rsp)
	callq fadd
	movq 128(%rsp), %rdx
	movq 120(%rsp), %rcx
	movq 112(%rsp), %r8
	movq 96(%rsp), %r9
	movl %eax, 308(%rsp)
	movl 308(%rsp), %r10d
	movl %r10d, 340(%rsp)
	movl $2, %edi
	movq %rdx, 136(%rsp)
	movq %rcx, 144(%rsp)
	movq %r8, 128(%rsp)
	movq %r9, 120(%rsp)
	callq tofloat
	movq 136(%rsp), %rdx
	movq 144(%rsp), %rcx
	movq 128(%rsp), %r8
	movq 120(%rsp), %r9
	movl %eax, 300(%rsp)
	movl 348(%rsp), %edi
	movl 344(%rsp), %esi
	movq %rdx, 152(%rsp)
	movq %rcx, 136(%rsp)
	movq %r8, 144(%rsp)
	movq %r9, 128(%rsp)
	callq fmul
	movq 152(%rsp), %rdx
	movq 136(%rsp), %rcx
	movq 144(%rsp), %r8
	movq 128(%rsp), %r9
	movl %eax, 304(%rsp)
	movl 300(%rsp), %edi
	movl 304(%rsp), %esi
	movq %rdx, 160(%rsp)
	movq %rcx, 152(%rsp)
	movq %r8, 136(%rsp)
	movq %r9, 144(%rsp)
	callq fmul
	movq 160(%rsp), %rdx
	movq 152(%rsp), %rcx
	movq 136(%rsp), %r8
	movq 144(%rsp), %r9
	movl %eax, 292(%rsp)
	movl 292(%rsp), %edi
	movl 268(%rsp), %esi
	movq %rdx, 168(%rsp)
	movq %rcx, 160(%rsp)
	movq %r8, 152(%rsp)
	movq %r9, 136(%rsp)
	callq fadd
	movq 168(%rsp), %rdx
	movq 160(%rsp), %rcx
	movq 152(%rsp), %r8
	movq 136(%rsp), %r9
	movl %eax, %edi
	movl 340(%rsp), %esi
	addl $1, 352(%rsp)
.mandelbrot_20:
	movl %eax, 284(%rsp)
	movl 364(%rsp), %r10d
	movl %r10d, 324(%rsp)
	movl 368(%rsp), %r10d
	movl %r10d, 332(%rsp)
	movl %edi, 344(%rsp)
	movl %esi, 348(%rsp)
	jmp .mandelbrot_5
.mandelbrot_7:
	movl 348(%rsp), %edi
	movl 348(%rsp), %esi
	movq %rdx, 176(%rsp)
	movq %rcx, 184(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq fmul
	movq 176(%rsp), %rdx
	movq 184(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 368(%rsp)
	movl 344(%rsp), %edi
	movl 344(%rsp), %esi
	movq %rdx, 192(%rsp)
	movq %rcx, 176(%rsp)
	movq %r8, 184(%rsp)
	movq %r9, 80(%rsp)
	callq fmul
	movq 192(%rsp), %rdx
	movq 176(%rsp), %rcx
	movq 184(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 364(%rsp)
	movl 368(%rsp), %edi
	movl 364(%rsp), %esi
	movq %rdx, 200(%rsp)
	movq %rcx, 192(%rsp)
	movq %r8, 176(%rsp)
	movq %r9, 184(%rsp)
	callq fadd
	movq 200(%rsp), %rdx
	movq 192(%rsp), %rcx
	movq 176(%rsp), %r8
	movq 184(%rsp), %r9
	movl %eax, %esi
	movl %esi, %edi
	movq %rsi, 208(%rsp)
	movq %rdx, 200(%rsp)
	movq %rcx, 192(%rsp)
	movq %r8, 176(%rsp)
	movq %r9, 184(%rsp)
	callq fromfloat
	movq 208(%rsp), %rsi
	movq 200(%rsp), %rdx
	movq 192(%rsp), %rcx
	movq 176(%rsp), %r8
	movq 184(%rsp), %r9
	movl %eax, 372(%rsp)
	movl $1, 376(%rsp)
	movl $4, %edi
	movl 372(%rsp), %eax
	cmpl %edi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, 376(%rsp)
	jnz .mandelbrot_8
.mandelbrot_11:
	movl $46, %edi
	movq %rsi, %r13
	movq %rcx, %rbx
	callq printchar
	movq %r13, %rsi
	movq %rbx, %rcx
	movl %eax, %r9d
	movslq %r9d, %r8
.mandelbrot_25:
	movl 380(%rsp), %r10d
	movl %r10d, 376(%rsp)
	movq 216(%rsp), %rax
	movl %ecx, 384(%rsp)
	movq 224(%rsp), %rdi
	movl %r9d, 388(%rsp)
	movq %r8, 208(%rsp)
.mandelbrot_13:
	addl $1, 248(%rsp)
.mandelbrot_18:
	movl 376(%rsp), %r10d
	movl %r10d, 380(%rsp)
	movq %rax, 216(%rsp)
	movl 384(%rsp), %ecx
	movq %rdi, 224(%rsp)
	movl 388(%rsp), %r8d
	movq 208(%rsp), %r9
	movl 284(%rsp), %r10d
	movl %r10d, 280(%rsp)
	movl 292(%rsp), %r10d
	movl %r10d, 288(%rsp)
	movl 300(%rsp), %r10d
	movl %r10d, 296(%rsp)
	movl 304(%rsp), %r13d
	movl 308(%rsp), %ebx
	movl 316(%rsp), %r10d
	movl %r10d, 312(%rsp)
	movl 324(%rsp), %r10d
	movl %r10d, 320(%rsp)
	movl 332(%rsp), %r10d
	movl %r10d, 328(%rsp)
	movl 340(%rsp), %r10d
	movl %r10d, 336(%rsp)
	movl %ebp, 392(%rsp)
	movl %r15d, 396(%rsp)
	movl 356(%rsp), %r10d
	movl %r10d, 400(%rsp)
	movl %r12d, %edx
	movl 360(%rsp), %r10d
	movl %r10d, 404(%rsp)
	jmp .mandelbrot_3
.mandelbrot_8:
	movl $1, %edi
	movl $9, %eax
	cmpl 352(%rsp), %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %edi
	jnz .mandelbrot_10
.mandelbrot_9:
	movl $9, %edi
	movq %rsi, 232(%rsp)
	movq %rdx, 208(%rsp)
	movq %rcx, 200(%rsp)
	movq %r8, 192(%rsp)
	movq %r9, 176(%rsp)
	callq printint
	movq 232(%rsp), %rsi
	movq 208(%rsp), %rdx
	movq 200(%rsp), %rcx
	movq 192(%rsp), %r8
	movq 176(%rsp), %r9
	movl %eax, 388(%rsp)
	movslq 388(%rsp), %rax
.mandelbrot_23:
	movl 380(%rsp), %r10d
	movl %r10d, 376(%rsp)
	movq 216(%rsp), %rdi
	movq %rax, 208(%rsp)
.mandelbrot_12:
.mandelbrot_24:
	movq %rdi, %rax
	movl 388(%rsp), %r10d
	movl %r10d, 384(%rsp)
	movq 208(%rsp), %rdi
	movl %r8d, 388(%rsp)
	movq %r9, 208(%rsp)
	jmp .mandelbrot_13
.mandelbrot_10:
	movl 352(%rsp), %edi
	movq %rsi, 232(%rsp)
	movq %rdx, 208(%rsp)
	movq %rcx, 200(%rsp)
	movq %r8, 192(%rsp)
	movq %r9, 176(%rsp)
	callq printint
	movq 232(%rsp), %rsi
	movq 208(%rsp), %rdx
	movq 200(%rsp), %rcx
	movq 192(%rsp), %r8
	movq 176(%rsp), %r9
	movslq %eax, %rdi
.mandelbrot_22:
	movl %eax, 376(%rsp)
	movl %ecx, 388(%rsp)
	movq 224(%rsp), %r10
	movq %r10, 208(%rsp)
	jmp .mandelbrot_12
.mandelbrot_14:
	movl $10, %edi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq printchar
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl 244(%rsp), %esi
	addl $1, %esi
.mandelbrot_16:
	movl %esi, 244(%rsp)
	jmp .mandelbrot_1
.mandelbrot_15:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $408, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1000, %edi
	callq _c0_mandelbrot
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
