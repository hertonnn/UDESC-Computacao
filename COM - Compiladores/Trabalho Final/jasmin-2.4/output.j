.class public Teste
.super java/lang/Object

.method public <init>()V
	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 20
	.limit locals 5

	iload 0
	iload 1
	if_icmpeq l0
	goto l1
l0:
	iload 2
	iconst_1
	isub
	istore 1
	goto l2
l1:
l2:
l3:
	iload 0
	iconst_1
	if_icmpeq l4
	goto l5
l4:
	iload 0
	iconst_1
	iadd
	istore 0
	iload 1
	i2d
	ldc2_w 2.0
	dadd
	d2i
	istore 1
	goto l3
l5:
	new java/util/Scanner
	dup
	getstatic java/lang/System/in Ljava/io/InputStream;
	invokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V
	invokevirtual java/util/Scanner/nextInt()I
	istore 2
	new java/util/Scanner
	dup
	getstatic java/lang/System/in Ljava/io/InputStream;
	invokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V
	invokevirtual java/util/Scanner/nextDouble()D
	dstore 3
	getstatic java/lang/System/out Ljava/io/PrintStream;
	dload 3
	iload 2
	i2d
	dadd
	invokevirtual java/io/PrintStream/println(D)V
	return
	return
.end method
