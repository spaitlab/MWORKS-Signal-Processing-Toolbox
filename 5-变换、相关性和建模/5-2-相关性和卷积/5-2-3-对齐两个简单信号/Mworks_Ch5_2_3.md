# 信号处理仿真与应用-MWorks版-案例

# 第5章 变换、相关性和建模

## 5.2 相关性和卷积

### 5.2.3 对齐两个简单信号

##### MATLAB

此示例说明如何使用互相关来对齐信号。在最一般的情况下，信号具有不同的长度，要正确同步它们，在将参数输入到.`xcorr`函数之前，必须考虑长度和输入参数的顺序。

考虑两个信号，除了周围的零点数量以及其中一个滞后于另一个信号之外，它们完全相同。

```
% Matlab代码
sz = 30;
sg = randn(1,randi(8)+3);
s1 = [zeros(1,randi(sz)-1) sg zeros(1,randi(sz)-1)];
s2 = [zeros(1,randi(sz)-1) sg zeros(1,randi(sz)-1)];

mx = max(numel(s1),numel(s2));

subplot(2,1,1)
stem(s1)
xlim([0 mx+1])

subplot(2,1,2)
stem(s2,'*')
xlim([0 mx+1])
```

确定两个信号中的哪一个比另一个信号长，因为元素更多，无论它们是否为零。

```
% Matlab代码
if numel(s1) > numel(s2)
    slong = s1;
    sshort = s2;
else
    slong = s2;
    sshort = s1;
end
```

计算两个信号的互相关。使用较长的信号作为第一个参数，将较短的信号作为第二个参数运行。绘制.`xcorr`函数的结果图。

```
% Matlab代码
[acor,lag] = xcorr(slong,sshort);

[acormax,I] = max(abs(acor));
lagDiff = lag(I)
```

lagDiff = 15

```
% Matlab代码
figure
stem(lag,acor)
hold on
plot(lagDiff,acormax,'*')
hold off
```

对齐信号。将滞后信号视为比另一个信号“更长”，从某种意义上说，您必须“等待更长的时间”才能检测到它。

- 如果为正数，则通过考虑删除其从lagDiff +1 到结束的元素来“缩短”长信号。
- 如果为负数，则通过考虑补齐其从 -lagDiff+1 到结束的元素来“延长”短信号。

您必须在滞后差值上加 1，因为 MATLAB® 使用基于 1 的索引。

```
% Matlab代码
if lagDiff > 0
    sorig = sshort;
    salign = slong(lagDiff+1:end);
else
    sorig = slong;
    salign = sshort(-lagDiff+1:end);
end
```

绘制对齐的信号。

```
% Matlab代码
subplot(2,1,1)
stem(sorig)
xlim([0 mx+1])

subplot(2,1,2)
stem(salign,'*')
xlim([0 mx+1])
```

该方法之所以有效，是因为互相关运算是反对称的，并且通过在较短信号*的末尾*添加零可以处理不同长度的信号。这种解释允许您使用 MATLAB® 运算符轻松对齐信号，而无需手动填充信号。

您还可以通过调用.`alignsignals`函数来一次对齐信号。

```
% Matlab代码
[x1,x2] = alignsignals(s1,s2);

subplot(2,1,1)
stem(x1)
xlim([0 mx+1])

subplot(2,1,2)
stem(x2,'*')
xlim([0 mx+1])
```

