.class public GCD
.super java/lang/Object

.method public <init>()V
    aload_0                     
    invokespecial java/lang/Object/<init>()V 
    return                      
.end method

.method public static gcd(II)I
    .limit stack 3 ; 3 Espaços para pilha int a int b e int resultado
    .limit locals 2 ; Variaveis locais a e b

loop_start:
    iload_1         
    ifeq end_loop   ; Se b for igual a zero pula o loop

    iload_1         
    iload_0         
    iload_1         
    irem            
    istore_1        
    istore_0        

    goto loop_start 

end_loop:
    iload_0         
    ireturn         

.end method

.method public static main([Ljava/lang/String;)V
    .limit stack 3
    .limit locals 5

    new java/util/Scanner       
    dup                         
    getstatic java/lang/System/in Ljava/io/InputStream; ; 
   
    invokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V
    astore_1                    

    getstatic java/lang/System/out Ljava/io/PrintStream; ; 
    ldc "Digite o primeiro inteiro: " 
    invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V 

    aload_1                     
    invokevirtual java/util/Scanner/nextInt()I ; Chama o metodo nextInt()
    istore_2                    ; 

    getstatic java/lang/System/out Ljava/io/PrintStream;
    ldc "Digite o segundo inteiro: "
    invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V

    aload_1                     ; 
    invokevirtual java/util/Scanner/nextInt()I ; Chama nextInt()
    istore_3                    ; 

    iload_2                     
    iload_3                     
    invokestatic GCD/gcd(II)I   
    istore 4                    ; 

    getstatic java/lang/System/out Ljava/io/PrintStream;
    ldc "O Maximo Divisor Comum (MDC) eh: "
    invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V

    getstatic java/lang/System/out Ljava/io/PrintStream;
    iload 4                     
    invokevirtual java/io/PrintStream/println(I)V 

    return              

.end method