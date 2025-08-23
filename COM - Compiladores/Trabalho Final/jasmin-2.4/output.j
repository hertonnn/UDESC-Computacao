.class public Teste
.super java/lang/Object

.method public <init>()V
	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return
.end method

.method public static helloWorld()V
	.limit stack 20
	.limit locals 1

	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "Hello World"
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	return
	return
.end method

.method public static logica(III)I
	.limit stack 20
	.limit locals 4

	iload 0
	iload 1
	if_icmpgt l4
	goto l3
l4:
	iload 1
	iload 2
	if_icmpne l0
	goto l3
l3:
	iload 2
	iload 0
	if_icmple l1
	goto l0
l0:
	iconst_1
	ireturn
	goto l2
l1:
l2:
	iconst_0
	ireturn
.end method

.method public static maior(II)I
	.limit stack 20
	.limit locals 3

	iload 0
	iload 1
	if_icmpgt l5
	goto l6
l5:
	iload 0
	ireturn
	goto l7
l6:
l7:
	iload 1
	ireturn
.end method

.method public static fat(I)I
	.limit stack 20
	.limit locals 2

	iload 0
	iconst_0
	if_icmpeq l8
	goto l9
l8:
	iconst_1
	ireturn
	goto l10
l9:
l10:
	iload 0
	iload 0
	iconst_1
	isub
	invokestatic Teste/fat(I)I
	imul
	ireturn
.end method

.method public static fibonacci(I)I
	.limit stack 20
	.limit locals 2

	iload 0
	iconst_0
	if_icmpeq l11
	goto l12
l11:
	iconst_0
	ireturn
	goto l13
l12:
l13:
	iload 0
	iconst_1
	if_icmpeq l14
	goto l15
l14:
	iconst_1
	ireturn
	goto l16
l15:
l16:
	iload 0
	iconst_1
	isub
	invokestatic Teste/fibonacci(I)I
	iload 0
	iconst_2
	isub
	invokestatic Teste/fibonacci(I)I
	iadd
	ireturn
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 20
	.limit locals 4

	bipush 10
	istore 0
	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "Digite um numero: "
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	new java/util/Scanner
	dup
	getstatic java/lang/System/in Ljava/io/InputStream;
	invokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V
	invokevirtual java/util/Scanner/nextInt()I
	istore 1
l17:
	iload 1
	iconst_0
	if_icmpgt l18
	goto l19
l18:
	getstatic java/lang/System/out Ljava/io/PrintStream;
	iload 1
	invokestatic Teste/fibonacci(I)I
	invokevirtual java/io/PrintStream/println(I)V
	iload 1
	iconst_1
	isub
	istore 1
	goto l17
l19:
	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "Resultado das expressoes logicas"
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	getstatic java/lang/System/out Ljava/io/PrintStream;
	bipush 10
	iconst_5
	bipush 10
	invokestatic Teste/logica(III)I
	invokevirtual java/io/PrintStream/println(I)V
	invokestatic Teste/helloWorld()V
	return
	return
.end method
