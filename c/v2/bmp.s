	.file	"bmp.c"
	.section .rdata,"dr"
LC0:
	.ascii "rb\0"
LC1:
	.ascii "fopen\0"
LC2:
	.ascii "Failed to read BMP headers\12\0"
	.align 4
LC3:
	.ascii "Unsupported BMP format (only uncompressed 24bpp)\12\0"
LC4:
	.ascii "malloc\0"
LC5:
	.ascii "Failed to read BMP scanline\12\0"
	.text
	.globl	_load_bmp
	.def	_load_bmp;	.scl	2;	.type	32;	.endef
_load_bmp:
LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$120, %esp
	movl	$LC0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	L2
	movl	$LC1, (%esp)
	call	_perror
	movl	$0, %eax
	jmp	L17
L2:
	movl	-20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$14, 4(%esp)
	leal	-62(%ebp), %eax
	movl	%eax, (%esp)
	call	_fread
	cmpl	$1, %eax
	jne	L4
	movl	-20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$40, 4(%esp)
	leal	-102(%ebp), %eax
	movl	%eax, (%esp)
	call	_fread
	cmpl	$1, %eax
	je	L5
L4:
	movl	__imp___iob, %eax
	addl	$64, %eax
	movl	%eax, 12(%esp)
	movl	$27, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC2, (%esp)
	call	_fwrite
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
	jmp	L17
L5:
	movzwl	-62(%ebp), %eax
	cmpw	$19778, %ax
	jne	L6
	movzwl	-88(%ebp), %eax
	cmpw	$24, %ax
	jne	L6
	movl	-86(%ebp), %eax
	testl	%eax, %eax
	je	L7
L6:
	movl	__imp___iob, %eax
	addl	$64, %eax
	movl	%eax, 12(%esp)
	movl	$49, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC3, (%esp)
	call	_fwrite
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
	jmp	L17
L7:
	movl	-98(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-94(%ebp), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	xorl	%eax, %edx
	movl	%edx, -28(%ebp)
	subl	%eax, -28(%ebp)
	movl	-24(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	cltd
	andl	$3, %edx
	addl	%edx, %eax
	sarl	$2, %eax
	sall	$2, %eax
	movl	%eax, -32(%ebp)
	movl	-24(%ebp), %eax
	imull	-28(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -36(%ebp)
	cmpl	$0, -36(%ebp)
	jne	L8
	movl	$LC4, (%esp)
	call	_perror
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
	jmp	L17
L8:
	movl	-52(%ebp), %eax
	movl	$0, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	$0, -12(%ebp)
	jmp	L9
L16:
	movl	-94(%ebp), %eax
	testl	%eax, %eax
	jle	L10
	movl	-28(%ebp), %eax
	subl	$1, %eax
	subl	-12(%ebp), %eax
	jmp	L11
L10:
	movl	-12(%ebp), %eax
L11:
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	imull	-24(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-36(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -44(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -48(%ebp)
	cmpl	$0, -48(%ebp)
	jne	L12
	movl	$LC4, (%esp)
	call	_perror
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
	jmp	L17
L12:
	movl	-32(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	$1, 4(%esp)
	movl	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, %edx
	movl	-32(%ebp), %eax
	cmpl	%eax, %edx
	je	L13
	movl	__imp___iob, %eax
	addl	$64, %eax
	movl	%eax, 12(%esp)
	movl	$28, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC5, (%esp)
	call	_fwrite
	movl	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
	jmp	L17
L13:
	movl	$0, -16(%ebp)
	jmp	L14
L15:
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-44(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	2(%eax), %edx
	movl	-48(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%ecx)
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	1(%eax), %edx
	movl	-44(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	1(%eax), %edx
	movl	-48(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%ecx)
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	2(%eax), %edx
	movl	-44(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-48(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%ecx)
	addl	$1, -16(%ebp)
L14:
	movl	-16(%ebp), %eax
	cmpl	-24(%ebp), %eax
	jl	L15
	movl	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	addl	$1, -12(%ebp)
L9:
	movl	-12(%ebp), %eax
	cmpl	-28(%ebp), %eax
	jl	L16
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	12(%ebp), %eax
	movl	-24(%ebp), %edx
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, (%eax)
	movl	-36(%ebp), %eax
L17:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE14:
	.section .rdata,"dr"
LC6:
	.ascii "wb\0"
LC7:
	.ascii "Failed to write BMP headers\12\0"
	.text
	.globl	_write_bmp
	.def	_write_bmp;	.scl	2;	.type	32;	.endef
_write_bmp:
LFB15:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$120, %esp
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	cltd
	andl	$3, %edx
	addl	%edx, %eax
	sarl	$2, %eax
	sall	$2, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	imull	20(%ebp), %eax
	movl	%eax, -28(%ebp)
	movw	$19778, -58(%ebp)
	movl	-28(%ebp), %eax
	addl	$54, %eax
	movl	%eax, -56(%ebp)
	movw	$0, -52(%ebp)
	movw	$0, -50(%ebp)
	movl	$54, -48(%ebp)
	movl	$40, -98(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -94(%ebp)
	movl	20(%ebp), %eax
	movl	%eax, -90(%ebp)
	movw	$1, -86(%ebp)
	movw	$24, -84(%ebp)
	movl	$0, -82(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -78(%ebp)
	movl	$2835, -74(%ebp)
	movl	$2835, -70(%ebp)
	movl	$0, -66(%ebp)
	movl	$0, -62(%ebp)
	movl	$LC6, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	jne	L19
	movl	$LC1, (%esp)
	call	_perror
	movl	$-1, %eax
	jmp	L30
L19:
	movl	-32(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$14, 4(%esp)
	leal	-58(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	cmpl	$1, %eax
	jne	L21
	movl	-32(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	$40, 4(%esp)
	leal	-98(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	cmpl	$1, %eax
	je	L22
L21:
	movl	__imp___iob, %eax
	addl	$64, %eax
	movl	%eax, 12(%esp)
	movl	$28, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC7, (%esp)
	call	_fwrite
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$-1, %eax
	jmp	L30
L22:
	movl	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -36(%ebp)
	cmpl	$0, -36(%ebp)
	jne	L23
	movl	$LC4, (%esp)
	call	_perror
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$-1, %eax
	jmp	L30
L23:
	movl	$0, -12(%ebp)
	jmp	L24
L29:
	movl	20(%ebp), %eax
	subl	$1, %eax
	subl	-12(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	imull	16(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -44(%ebp)
	movl	$0, -16(%ebp)
	jmp	L25
L26:
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-36(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	2(%eax), %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%ecx)
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	1(%eax), %edx
	movl	-36(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	1(%eax), %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%ecx)
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	2(%eax), %edx
	movl	-36(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, (%ecx)
	addl	$1, -16(%ebp)
L25:
	movl	-16(%ebp), %eax
	cmpl	16(%ebp), %eax
	jl	L26
	movl	16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, -20(%ebp)
	jmp	L27
L28:
	movl	-20(%ebp), %edx
	movl	-36(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	addl	$1, -20(%ebp)
L27:
	movl	-20(%ebp), %eax
	cmpl	-24(%ebp), %eax
	jl	L28
	movl	-24(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	$1, 4(%esp)
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	_fwrite
	addl	$1, -12(%ebp)
L24:
	movl	-12(%ebp), %eax
	cmpl	20(%ebp), %eax
	jl	L29
	movl	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
L30:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE15:
	.section .rdata,"dr"
LC8:
	.ascii "malloc za output sliku\0"
	.text
	.globl	_mean_filter
	.def	_mean_filter;	.scl	2;	.type	32;	.endef
_mean_filter:
LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$84, %esp
	.cfi_offset 3, -12
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_load_bmp
	movl	%eax, -40(%ebp)
	cmpl	$0, -40(%ebp)
	jne	L32
	movl	$0, %eax
	jmp	L33
L32:
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	-44(%ebp), %eax
	imull	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -52(%ebp)
	cmpl	$0, -52(%ebp)
	jne	L34
	movl	$LC8, (%esp)
	call	_perror
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, %eax
	jmp	L33
L34:
	movl	-44(%ebp), %eax
	imull	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, 8(%esp)
	movl	-40(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_memcpy
	movl	$1, -12(%ebp)
	jmp	L35
L42:
	movl	$1, -16(%ebp)
	jmp	L36
L41:
	movl	$0, -20(%ebp)
	movl	$0, -24(%ebp)
	movl	$0, -28(%ebp)
	movl	$-1, -32(%ebp)
	jmp	L37
L40:
	movl	$-1, -36(%ebp)
	jmp	L38
L39:
	movl	-12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	imull	-44(%ebp), %eax
	movl	-16(%ebp), %ecx
	movl	-36(%ebp), %edx
	addl	%ecx, %edx
	addl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %edx
	movl	-40(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	addl	%eax, -20(%ebp)
	movl	-56(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	addl	%eax, -24(%ebp)
	movl	-56(%ebp), %eax
	leal	2(%eax), %edx
	movl	-40(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movzbl	%al, %eax
	addl	%eax, -28(%ebp)
	addl	$1, -36(%ebp)
L38:
	cmpl	$1, -36(%ebp)
	jle	L39
	addl	$1, -32(%ebp)
L37:
	cmpl	$1, -32(%ebp)
	jle	L40
	movl	-12(%ebp), %eax
	imull	-44(%ebp), %eax
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	addl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %edx
	movl	-52(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-20(%ebp), %ecx
	movl	$954437177, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, (%ebx)
	movl	-60(%ebp), %eax
	leal	1(%eax), %edx
	movl	-52(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-24(%ebp), %ecx
	movl	$954437177, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, (%ebx)
	movl	-60(%ebp), %eax
	leal	2(%eax), %edx
	movl	-52(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-28(%ebp), %ecx
	movl	$954437177, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, (%ebx)
	addl	$1, -16(%ebp)
L36:
	movl	-44(%ebp), %eax
	subl	$1, %eax
	cmpl	-16(%ebp), %eax
	jg	L41
	addl	$1, -12(%ebp)
L35:
	movl	-48(%ebp), %eax
	subl	$1, %eax
	cmpl	-12(%ebp), %eax
	jg	L42
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-52(%ebp), %eax
L33:
	addl	$84, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE16:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 4
LC9:
	.ascii "C:/Users/Student/Desktop/skola/c/v2/Image.bmp\0"
	.align 4
LC10:
	.ascii "Pokusavam ucitati sliku sa putanje: %s...\12\0"
	.align 4
LC11:
	.ascii "[MOD: Mean Filter] Obrada u toku...\0"
	.align 4
LC12:
	.ascii "C:/Users/Student/Desktop/skola/c/v2/Image_filtrirana.bmp\0"
	.align 4
LC13:
	.ascii "\12Greska: Program ne moze otvoriti ili obraditi sliku!\0"
	.align 4
LC14:
	.ascii "Slika uspjesno ucitana i obradjena! Dimenzije: %d x %d px.\12\0"
	.align 4
LC15:
	.ascii "Greska pri upisivanju izlazne slike!\12\0"
	.align 4
LC16:
	.ascii "Uspjeh! Nova slika sacuvana na: %s\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$48, %esp
	call	___main
	movl	$LC9, 44(%esp)
	movl	$0, 40(%esp)
	movl	$0, 36(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC10, (%esp)
	call	_printf
	movl	$LC11, (%esp)
	call	_puts
	leal	28(%esp), %eax
	movl	%eax, 8(%esp)
	leal	32(%esp), %eax
	movl	%eax, 4(%esp)
	movl	44(%esp), %eax
	movl	%eax, (%esp)
	call	_mean_filter
	movl	%eax, 40(%esp)
	movl	$LC12, 36(%esp)
	cmpl	$0, 40(%esp)
	jne	L44
	movl	$LC13, (%esp)
	call	_puts
	movl	$1, %eax
	jmp	L47
L44:
	movl	28(%esp), %edx
	movl	32(%esp), %eax
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$LC14, (%esp)
	call	_printf
	movl	28(%esp), %edx
	movl	32(%esp), %eax
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, 4(%esp)
	movl	36(%esp), %eax
	movl	%eax, (%esp)
	call	_write_bmp
	testl	%eax, %eax
	je	L46
	movl	__imp___iob, %eax
	addl	$64, %eax
	movl	%eax, 12(%esp)
	movl	$37, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC15, (%esp)
	call	_fwrite
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$1, %eax
	jmp	L47
L46:
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	36(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC16, (%esp)
	call	_printf
	movl	$0, %eax
L47:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE17:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_perror;	.scl	2;	.type	32;	.endef
	.def	_fread;	.scl	2;	.type	32;	.endef
	.def	_fwrite;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_fseek;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
	.def	_fwrite;	.scl	2;	.type	32;	.endef
	.def	_memcpy;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
