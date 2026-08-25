.class public Teste
.super java/lang/Object

.method public <init>()V
	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return
.end method

.method public static fatorial(I)I
	.limit stack 20
	.limit locals 1

	iload 0
	iconst_1
	if_icmple l0
	goto l1
l0:
	iconst_1
	ireturn
	goto l2
l1:
l2:
	iload 0
	iload 0
	iconst_1
	isub
	invokestatic Teste/fatorial(I)I
	imul
	ireturn
.end method

.method public static testeIfElse(I)V
	.limit stack 20
	.limit locals 1

	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "Teste If-Else"
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 0
	bipush 18
	if_icmpge l3
	goto l4
l3:
	getstatic java/lang/System/out Ljava/io/PrintStream;
	iconst_1
	invokevirtual java/io/PrintStream/println(I)V
	goto l5
l4:
	getstatic java/lang/System/out Ljava/io/PrintStream;
	iconst_0
	invokevirtual java/io/PrintStream/println(I)V
l5:
	return
.end method

.method public static testeMatriz(I)V
	.limit stack 20
	.limit locals 3

	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "Teste Nested Loop"
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 1
l6:
	iload 1
	iload 0
	if_icmple l7
	goto l8
l7:
	iconst_1
	istore 2
l9:
	iload 2
	iload 0
	if_icmple l10
	goto l11
l10:
	getstatic java/lang/System/out Ljava/io/PrintStream;
	iload 1
	iload 2
	imul
	invokevirtual java/io/PrintStream/println(I)V
	iinc 2 1
	goto l9
l11:
	iinc 1 1
	goto l6
l8:
	return
.end method

.method public static testePrecedencia(DDD)V
	.limit stack 20
	.limit locals 10

	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "Teste Precedencia"
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	dload 0
	dload 2
	dload 4
	dmul
	dadd
	dstore 6
	getstatic java/lang/System/out Ljava/io/PrintStream;
	dload 6
	invokevirtual java/io/PrintStream/println(D)V
	dload 0
	dload 2
	dadd
	dload 4
	dmul
	dstore 8
	getstatic java/lang/System/out Ljava/io/PrintStream;
	dload 8
	invokevirtual java/io/PrintStream/println(D)V
	return
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 20
	.limit locals 5

	iconst_5
	istore 0
	ldc2_w 2.5
	dstore 2
	iload 0
	i2f
	fstore 1
	getstatic java/lang/System/out Ljava/io/PrintStream;
	fload 1
	invokevirtual java/io/PrintStream/println(F)V
	getstatic java/lang/System/out Ljava/io/PrintStream;
	fload 1
	f2d
	dload 2
	dadd
	invokevirtual java/io/PrintStream/println(D)V
	ldc2_w 10.9
	d2f
	fstore 1
	getstatic java/lang/System/out Ljava/io/PrintStream;
	fload 1
	invokevirtual java/io/PrintStream/println(F)V
	fload 1
	f2i
	istore 4
	getstatic java/lang/System/out Ljava/io/PrintStream;
	iload 4
	invokevirtual java/io/PrintStream/println(I)V
	return
.end method
