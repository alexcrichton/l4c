.file	"../tests2/brachiosaurus-stress-func3.l3"
.globl _c0_main
_c0_f0:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f0_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f1:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f1_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f2:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f2_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f3:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f3_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f4:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f4_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f5:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f5_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f6:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f6_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f7:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f7_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f8:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f8_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f9:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f9_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f10:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f10_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f11:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f11_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f12:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f12_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f13:
	addq $-184, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edx, %ebx
	movl %r9d, 52(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 200(%rsp), %r9d
	movl 208(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 64(%rsp)
.f13_0:
	movl $1, 68(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %edx, 72(%rsp)
	addl $6000, 72(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 76(%rsp)
	addl $6000, 76(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %eax, %r12d
	addl %r12d, %edx
	movl %edx, 80(%rsp)
	addl $6000, 80(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl $2, %r15d
	addl %r12d, %r15d
	movl $2, %edx
	addl %r13d, %edx
	movl %r15d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %r13d
	addl %eax, %r13d
	movl %r12d, %edx
	addl %r13d, %edx
	movl %edx, 84(%rsp)
	addl $6000, 84(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r13d
	addl %r14d, %r13d
	movl %edx, %r12d
	addl %r13d, %r12d
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 88(%rsp)
	addl $6000, 88(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %r12d
	addl %r13d, %r12d
	addl %r12d, %edx
	movl $2, %r12d
	addl %r14d, %r12d
	movl %edx, %r13d
	addl %r12d, %r13d
	movl $2, %edx
	addl %r15d, %edx
	movl %r13d, %r12d
	addl %edx, %r12d
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %r12d
	movl $2, %edx
	addl %eax, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, 96(%rsp)
	addl $6000, 96(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %r12d
	movl $2, %eax
	addl %r15d, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl %edx, 104(%rsp)
	addl $6000, 104(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 100(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 80(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 84(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 88(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 96(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %eax
	addl 100(%rsp), %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r12d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	movl %eax, %r12d
	addl %edx, %r12d
	movl $2, %eax
	addl %ebp, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl %edx, 112(%rsp)
	addl $6000, 112(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, %edx
	movl $2, 116(%rsp)
	addl %r12d, 116(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 116(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl %edx, %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl %edx, 120(%rsp)
	addl $6000, 120(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl %edx, 128(%rsp)
	addl $6000, 128(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 100(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 100(%rsp)
	movl %eax, 100(%rsp)
	movl $1, 108(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $2, %eax
	addl %r12d, %eax
	movl $2, %edx
	addl %r13d, %edx
	addl %edx, %eax
	movl $2, %r12d
	addl %r14d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 100(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl %edx, 100(%rsp)
	addl $6000, 100(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl %edx, 144(%rsp)
	addl $6000, 144(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $2, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %r13d, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl %r14d, %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl $2, %eax
	addl %ebp, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 92(%rsp), %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %r12d
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %r12d, %edx
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl %edx, 152(%rsp)
	addl $6000, 152(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 72(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 76(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 80(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 84(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 140(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 140(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 148(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 148(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 156(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 156(%rsp)
	movl %eax, %edx
	movl $2, 156(%rsp)
	addl %r12d, 156(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl 156(%rsp), %r12d
	addl %eax, %r12d
	movl $2, %r13d
	addl %r14d, %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl %r15d, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %ebp, %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 92(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 108(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r13d
	addl 116(%rsp), %r13d
	movl %eax, %r12d
	addl %r13d, %r12d
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %r12d
	movl $2, %eax
	addl 132(%rsp), %eax
	addl %eax, %r12d
	movl $2, %r13d
	addl 136(%rsp), %r13d
	movl %r12d, %eax
	addl %r13d, %eax
	movl $2, %r12d
	addl 140(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl 148(%rsp), %r12d
	addl %r12d, %eax
	movl $2, %r12d
	addl %edx, %r12d
	movl %eax, %edx
	addl %r12d, %edx
	movl %edx, 160(%rsp)
	addl $6000, 160(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 92(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %ebp
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r15d
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r14d
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 100(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r13d
	movl $1, %r12d
	movl 144(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 152(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, 164(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 164(%rsp)
	movl %eax, 164(%rsp)
	movl $2, %edx
	addl 116(%rsp), %edx
	movl $2, %eax
	addl 108(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %edx, 108(%rsp)
	addl %eax, 108(%rsp)
	movl $2, %edx
	addl 92(%rsp), %edx
	movl 108(%rsp), %eax
	addl %edx, %eax
	movl $2, %edx
	addl 132(%rsp), %edx
	addl %edx, %eax
	movl $2, 92(%rsp)
	addl %ebp, 92(%rsp)
	movl %eax, %edx
	addl 92(%rsp), %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 148(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl 156(%rsp), %eax
	movl %edx, %r13d
	addl %eax, %r13d
	movl $2, %edx
	addl %r12d, %edx
	movl %r13d, %eax
	addl %edx, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl %eax, 168(%rsp)
	addl $6000, 168(%rsp)
	movl $1, %r12d
	movl 68(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 172(%rsp)
	movl $1, %r12d
	movl 72(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 164(%rsp)
	movl $1, %r12d
	movl 76(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 156(%rsp)
	movl $1, %r12d
	movl 80(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 148(%rsp)
	movl $1, %r12d
	movl 84(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl $1, %r12d
	movl 88(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 136(%rsp)
	movl $1, %r12d
	movl 96(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 132(%rsp)
	movl $1, %r12d
	movl 104(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 124(%rsp)
	movl $1, %r12d
	movl 112(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 116(%rsp)
	movl $1, %r12d
	movl 120(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, 108(%rsp)
	movl $1, %r12d
	movl 128(%rsp), %eax
	cltd
	idivl %r12d
	movl %eax, %r12d
	movl $1, %r13d
	movl 100(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 144(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 152(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 160(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $2, %edx
	addl 172(%rsp), %edx
	movl $2, %eax
	addl 164(%rsp), %eax
	movl %edx, 164(%rsp)
	addl %eax, 164(%rsp)
	movl $2, %edx
	addl 156(%rsp), %edx
	movl 164(%rsp), %r10d
	movl %r10d, 156(%rsp)
	addl %edx, 156(%rsp)
	movl $2, %eax
	addl 148(%rsp), %eax
	movl 156(%rsp), %edx
	addl %eax, %edx
	movl $2, %eax
	addl 140(%rsp), %eax
	movl %edx, 140(%rsp)
	addl %eax, 140(%rsp)
	movl $2, %edx
	addl 136(%rsp), %edx
	movl 140(%rsp), %eax
	addl %edx, %eax
	movl $2, 136(%rsp)
	movl 132(%rsp), %r10d
	addl %r10d, 136(%rsp)
	movl %eax, %edx
	addl 136(%rsp), %edx
	movl $2, %eax
	addl 124(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 116(%rsp), %eax
	movl %edx, 116(%rsp)
	addl %eax, 116(%rsp)
	movl $2, %edx
	addl 108(%rsp), %edx
	movl 116(%rsp), %eax
	addl %edx, %eax
	movl $2, 108(%rsp)
	addl %r12d, 108(%rsp)
	movl %eax, %edx
	addl 108(%rsp), %edx
	movl $2, %eax
	addl %r13d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r14d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %r15d, %eax
	addl %eax, %edx
	movl $2, %eax
	addl %ebp, %eax
	movl %edx, %r12d
	addl %eax, %r12d
	movl $2, %edx
	addl 92(%rsp), %edx
	movl %r12d, %eax
	addl %edx, %eax
	movl %eax, %r12d
	addl $6000, %r12d
	movl $1, %r13d
	movl 68(%rsp), %eax
	cltd
	idivl %r13d
	movl %eax, %r13d
	movl $1, %r14d
	movl 72(%rsp), %eax
	cltd
	idivl %r14d
	movl %eax, %r14d
	movl $1, %r15d
	movl 76(%rsp), %eax
	cltd
	idivl %r15d
	movl %eax, %r15d
	movl $1, %ebp
	movl 80(%rsp), %eax
	cltd
	idivl %ebp
	movl %eax, %ebp
	movl $1, 92(%rsp)
	movl 84(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %eax, 92(%rsp)
	movl $1, 108(%rsp)
	movl 88(%rsp), %eax
	cltd
	idivl 108(%rsp)
	movl %eax, 108(%rsp)
	movl $1, 116(%rsp)
	movl 96(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 116(%rsp)
	movl $1, 124(%rsp)
	movl 104(%rsp), %eax
	cltd
	idivl 124(%rsp)
	movl %eax, 124(%rsp)
	movl $1, 132(%rsp)
	movl 112(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %eax, 132(%rsp)
	movl $1, 136(%rsp)
	movl 120(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 148(%rsp)
	movl $1, 136(%rsp)
	movl 128(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 176(%rsp)
	movl $1, 136(%rsp)
	movl 100(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 172(%rsp)
	movl $1, 136(%rsp)
	movl 144(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 164(%rsp)
	movl $1, 136(%rsp)
	movl 152(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 156(%rsp)
	movl $1, 136(%rsp)
	movl 160(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 140(%rsp)
	movl $1, 136(%rsp)
	movl 168(%rsp), %eax
	cltd
	idivl 136(%rsp)
	movl %eax, 136(%rsp)
	movl $1, 180(%rsp)
	movl %r12d, %eax
	cltd
	idivl 180(%rsp)
	movl %eax, 180(%rsp)
	movl $2, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl %r14d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %r15d, %edx
	addl %edx, %eax
	movl $2, %edx
	addl %ebp, %edx
	addl %edx, %eax
	movl $2, %edx
	addl 92(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 108(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 116(%rsp), %edx
	movl %eax, %r13d
	addl %edx, %r13d
	movl $2, %eax
	addl 124(%rsp), %eax
	movl %r13d, %edx
	addl %eax, %edx
	movl $2, %r13d
	addl 132(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 148(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 176(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %r13d
	addl 172(%rsp), %r13d
	movl %edx, %eax
	addl %r13d, %eax
	movl $2, %edx
	addl 164(%rsp), %edx
	addl %edx, %eax
	movl $2, %edx
	addl 156(%rsp), %edx
	addl %edx, %eax
	movl $2, %r13d
	addl 140(%rsp), %r13d
	movl %eax, %edx
	addl %r13d, %edx
	movl $2, %eax
	addl 136(%rsp), %eax
	addl %eax, %edx
	movl $2, %eax
	addl 180(%rsp), %eax
	addl %eax, %edx
	addl $6000, %edx
	movl 68(%rsp), %eax
	addl 72(%rsp), %eax
	addl 76(%rsp), %eax
	addl 80(%rsp), %eax
	addl 84(%rsp), %eax
	addl 88(%rsp), %eax
	addl 96(%rsp), %eax
	addl 104(%rsp), %eax
	addl 112(%rsp), %eax
	addl 120(%rsp), %eax
	addl 128(%rsp), %eax
	addl 100(%rsp), %eax
	addl 144(%rsp), %eax
	addl 152(%rsp), %eax
	addl 160(%rsp), %eax
	addl 168(%rsp), %eax
	addl %r12d, %eax
	addl %edx, %eax
	movl %eax, %edx
	addl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 52(%rsp), %r8d
	addl 56(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_main:
	addq $-120, %rsp
	movq %rbp, 44(%rsp)
	movq %r15, 52(%rsp)
	movq %r14, 60(%rsp)
	movq %r13, 68(%rsp)
	movq %r12, 76(%rsp)
	movq %rbx, 84(%rsp)
.main_0:
	movl $1804289383, %edi
	movl $846930886, %esi
	movl $1681692777, %edx
	movl $1714636915, %ecx
	movl $1957747793, %r8d
	movl $424238335, %r9d
	movl $719885386, 0(%rsp)
	movl $1649760492, 8(%rsp)
	movl $596516649, 16(%rsp)
	movl $1189641421, 24(%rsp)
	callq _c0_f0
	movl %eax, %ebx
	movl $1025202362, %edi
	movl $1350490027, %esi
	movl $783368690, %edx
	movl $1102520059, %ecx
	movl $2044897763, %r8d
	movl $1967513926, %r9d
	movl $1365180540, 0(%rsp)
	movl $1540383426, 8(%rsp)
	movl $304089172, 16(%rsp)
	movl $1303455736, 24(%rsp)
	callq _c0_f1
	movl %eax, 92(%rsp)
	movl $35005211, %edi
	movl $521595368, %esi
	movl $294702567, %edx
	movl $1726956429, %ecx
	movl $336465782, %r8d
	movl $861021530, %r9d
	movl $278722862, 0(%rsp)
	movl $233665123, 8(%rsp)
	movl $2145174067, 16(%rsp)
	movl $468703135, 24(%rsp)
	callq _c0_f2
	movl %eax, %r12d
	movl $1101513929, %edi
	movl $1801979802, %esi
	movl $1315634022, %edx
	movl $635723058, %ecx
	movl $1369133069, %r8d
	movl $1125898167, %r9d
	movl $1059961393, 0(%rsp)
	movl $2089018456, 8(%rsp)
	movl $628175011, 16(%rsp)
	movl $1656478042, 24(%rsp)
	callq _c0_f3
	movl %eax, 96(%rsp)
	movl $1131176229, %edi
	movl $1653377373, %esi
	movl $859484421, %edx
	movl $1914544919, %ecx
	movl $608413784, %r8d
	movl $756898537, %r9d
	movl $1734575198, 0(%rsp)
	movl $1973594324, 8(%rsp)
	movl $149798315, 16(%rsp)
	movl $2038664370, 24(%rsp)
	callq _c0_f4
	movl %eax, %r13d
	movl $1129566413, %edi
	movl $184803526, %esi
	movl $412776091, %edx
	movl $1424268980, %ecx
	movl $1911759956, %r8d
	movl $749241873, %r9d
	movl $137806862, 0(%rsp)
	movl $42999170, 8(%rsp)
	movl $982906996, 16(%rsp)
	movl $135497281, 24(%rsp)
	callq _c0_f5
	movl %eax, %ebp
	movl $511702305, %edi
	movl $2084420925, %esi
	movl $1937477084, %edx
	movl $1827336327, %ecx
	movl $572660336, %r8d
	movl $1159126505, %r9d
	movl $805750846, 0(%rsp)
	movl $1632621729, 8(%rsp)
	movl $1100661313, 16(%rsp)
	movl $1433925857, 24(%rsp)
	callq _c0_f6
	movl %eax, 100(%rsp)
	movl $1141616124, %edi
	movl $84353895, %esi
	movl $939819582, %edx
	movl $2001100545, %ecx
	movl $1998898814, %r8d
	movl $1548233367, %r9d
	movl $610515434, 0(%rsp)
	movl $1585990364, 8(%rsp)
	movl $1374344043, 16(%rsp)
	movl $760313750, 24(%rsp)
	callq _c0_f7
	movl %eax, 104(%rsp)
	movl $1477171087, %edi
	movl $356426808, %esi
	movl $945117276, %edx
	movl $1889947178, %ecx
	movl $1780695788, %r8d
	movl $709393584, %r9d
	movl $491705403, 0(%rsp)
	movl $1918502651, 8(%rsp)
	movl $752392754, 16(%rsp)
	movl $1474612399, 24(%rsp)
	callq _c0_f8
	movl %eax, 108(%rsp)
	movl $2053999932, %edi
	movl $1264095060, %esi
	movl $1411549676, %edx
	movl $1843993368, %ecx
	movl $943947739, %r8d
	movl $1984210012, %r9d
	movl $855636226, 0(%rsp)
	movl $1749698586, 8(%rsp)
	movl $1469348094, 16(%rsp)
	movl $1956297539, 24(%rsp)
	callq _c0_f9
	movl %eax, %r14d
	movl $1036140795, %edi
	movl $463480570, %esi
	movl $2040651434, %edx
	movl $1975960378, %ecx
	movl $317097467, %r8d
	movl $1892066601, %r9d
	movl $1376710097, 0(%rsp)
	movl $927612902, 8(%rsp)
	movl $1330573317, 16(%rsp)
	movl $603570492, 24(%rsp)
	callq _c0_f10
	movl %eax, %r15d
	movl $1687926652, %edi
	movl $660260756, %esi
	movl $959997301, %edx
	movl $485560280, %ecx
	movl $402724286, %r8d
	movl $593209441, %r9d
	movl $1194953865, 0(%rsp)
	movl $894429689, 8(%rsp)
	movl $364228444, 16(%rsp)
	movl $1947346619, 24(%rsp)
	callq _c0_f11
	movl %eax, 112(%rsp)
	movl $221558440, %edi
	movl $270744729, %esi
	movl $1063958031, %edx
	movl $1633108117, %ecx
	movl $2114738097, %r8d
	movl $2007905771, %r9d
	movl $1469834481, 0(%rsp)
	movl $822890675, 8(%rsp)
	movl $1610120709, 16(%rsp)
	movl $791698927, 24(%rsp)
	callq _c0_f12
	movl %eax, 116(%rsp)
	movl $631704567, %edi
	movl $498777856, %esi
	movl $1255179497, %edx
	movl $524872353, %ecx
	movl $327254586, %r8d
	movl $1572276965, %r9d
	movl $269455306, 0(%rsp)
	movl $1703964683, 8(%rsp)
	movl $352406219, 16(%rsp)
	movl $1600028624, 24(%rsp)
	callq _c0_f13
	movl %ebx, %r9d
	addl 92(%rsp), %r9d
	addl %r12d, %r9d
	addl 96(%rsp), %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 100(%rsp), %r9d
	addl 104(%rsp), %r9d
	addl 108(%rsp), %r9d
	addl %r14d, %r9d
	addl %r15d, %r9d
	addl 112(%rsp), %r9d
	addl 116(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addl $439, %eax
	movq 44(%rsp), %rbp
	movq 52(%rsp), %r15
	movq 60(%rsp), %r14
	movq 68(%rsp), %r13
	movq 76(%rsp), %r12
	movq 84(%rsp), %rbx
	addq $120, %rsp
	ret
.ident	"15-411 L4 reference compiler"
