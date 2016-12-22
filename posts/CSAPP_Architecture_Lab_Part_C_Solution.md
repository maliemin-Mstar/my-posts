首先，在*pipe-full.hcl*里实现*iaddl*指令。然后，ncopy代码如下，解释请看注释：
```
#/* $begin ncopy-ys */
##################################################################
# ncopy.ys - Copy a src block of len ints to dst.
# Return the number of positive ints (>0) contained in src.
#
# Include your name and ID here.
#
# Describe how and why you modified the baseline code.
#
##################################################################
# Do not modify this portion
# Function prologue.
ncopy:	pushl %ebp		# Save old frame pointer
	rrmovl %esp,%ebp	# Set up new frame pointer
	pushl %esi		# Save callee-save regs
	pushl %ebx
	pushl %edi
	mrmovl 8(%ebp),%ebx	# src
	mrmovl 16(%ebp),%edx	# len
	mrmovl 12(%ebp),%ecx	# dst

##################################################################
# You can modify this portion
	# Loop header
	xorl %eax,%eax
	rrmovl %edx, %edi
	iaddl $-9, %edi
	jle A1

#循环展开
Loop:
    mrmovl (%ebx), %esi
	rrmovl %eax, %edi #注意这里有加载／使用冒险，会暂停一周期，所以这里放一条指令可以最大化利用率
	rmmovl %esi, (%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax #改成cmov指令,原因你懂的
	mrmovl 4(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 4(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 8(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 8(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 12(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 12(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 16(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 16(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 20(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 20(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 24(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 24(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 28(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 28(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 32(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 32(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	mrmovl 36(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 36(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	iaddl $40, %ebx
	iaddl $40, %ecx
	iaddl $-10, %edx
  	rrmovl %edx, %edi
	iaddl $-9, %edi
	jg Loop

A1:
	iaddl $8, %edi #注意edi存着len - 9的结果,直接拿来用
	jg B1	#由于psim采取的策略是总是选择分支，而这里len > 1的概率更大，所以这样写以加大分支命中的概率
    jmp A2
B1:	mrmovl (%ebx), %esi	 #剩下的最多9个元素直接顺序执行，不写成循环，节省了iaddl指令,并且两次展开
	rrmovl %eax, %edi
	rmmovl %esi, (%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    mrmovl 4(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 4(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	iaddl $-2, %edx
  	rrmovl %edx, %edi
	iaddl $-1, %edi
	jg B2
	andl %edx, %edx
    jle Done
    mrmovl 8(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 8(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    jmp Done

B2:
    mrmovl 8(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 8(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    mrmovl 12(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 12(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	iaddl $-2, %edx
  	rrmovl %edx, %edi
	iaddl $-1, %edi
	jg B3
	andl %edx, %edx
    jle Done
    mrmovl 16(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 16(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    jmp Done
B3:
    mrmovl 16(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 16(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    mrmovl 20(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 20(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	iaddl $-2, %edx
  	rrmovl %edx, %edi
	iaddl $-1, %edi
	jg B4
	andl %edx, %edx
    jle Done
    mrmovl 24(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 24(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    jmp Done
B4:
    mrmovl 24(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 24(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    mrmovl 28(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 28(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
	iaddl $-3, %edx  #注意是-3, 不需要andl了

    jl Done
    mrmovl 32(%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, 32(%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
    jmp Done

A2:	andl %edx, %edx
    jle Done
    mrmovl (%ebx), %esi
	rrmovl %eax, %edi
	rmmovl %esi, (%ecx)
	iaddl $1, %edi
	andl %esi, %esi
	cmovg %edi, %eax
##################################################################
# Do not modify the following section of code
# Function epilogue.
Done:
	popl %edi               # Restore callee-save registers
	popl %ebx
	popl %esi
	rrmovl %ebp, %esp
	popl %ebp
	ret
##################################################################
# Keep the following label at the end of your function
End:
#/* $end ncopy-ys */

A2:	andl %edx, %edx
        jle Done
LoopA:  mrmovl (%ebx), %esi	# read val from src...
	rrmovl %eax, %edi
	rmmovl %esi, (%ecx)	# ...and store it to dst
	iaddl $1, %edi
	andl %esi, %esi		# val <= 0?
	cmovg %edi, %eax
##################################################################
# Do not modify the following section of code
# Function epilogue.
Done:
	popl %edi               # Restore callee-save registers
	popl %ebx
	popl %esi
	rrmovl %ebp, %esp
	popl %ebp
	ret
##################################################################
# Keep the following label at the end of your function
End:
#/* $end ncopy-ys */
```

以下是对正确性，代码长度，以及CPE的测试结果：

**correctness**
```
Simulating with pipeline simulator psim
	ncopy
0	OK
1	OK
2	OK
3	OK
4	OK
5	OK
...
128	OK
192	OK
256	OK
68/68 pass correctness test
```

**check-len**
```
ncopy length = 811 bytes
```

**benchmark**
```
	ncopy
0	38
1	46	46.00
2	53	26.50
3	62	20.67
4	69	17.25
5	78	15.60
6	85	14.17
7	94	13.43
8	95	11.88
9	104	11.56
10	108	10.80
11	116	10.55
12	123	10.25
13	132	10.15
14	139	9.93
15	148	9.87
16	155	9.69
17	164	9.65
18	165	9.17
19	174	9.16
20	174	8.70
21	182	8.67
22	189	8.59
23	198	8.61
24	205	8.54
25	214	8.56
26	221	8.50
27	230	8.52
28	231	8.25
29	240	8.28
30	240	8.00
31	248	8.00
32	255	7.97
33	264	8.00
34	271	7.97
35	280	8.00
36	287	7.97
37	296	8.00
38	297	7.82
39	306	7.85
40	306	7.65
41	314	7.66
42	321	7.64
43	330	7.67
44	337	7.66
45	346	7.69
46	353	7.67
47	362	7.70
48	363	7.56
49	372	7.59
50	372	7.44
51	380	7.45
52	387	7.44
53	396	7.47
54	403	7.46
55	412	7.49
56	419	7.48
57	428	7.51
58	429	7.40
59	438	7.42
60	438	7.30
61	446	7.31
62	453	7.31
63	462	7.33
64	469	7.33
Average CPE	9.82
Score	60.0/60.0
```
满分哦！！