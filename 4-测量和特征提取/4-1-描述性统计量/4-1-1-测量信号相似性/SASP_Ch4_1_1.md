# 信号处理仿真与应用-MWorks版-案例

# 第4章 测量和特征提取

## 4.1 描述性统计量

### 4.1.1 测量信号相似性

测量信号相似性

此示例说明如何测量信号的相似性。它将帮助您回答诸如以下的问题：如何比较具有不同长度或不同采样率的信号？如何在测量中发现存在信号还是只存在噪声？两个信号是否相关？如何测量两个信号之间的延迟（以及如何将它们对齐）？如何比较两个信号的频率成分？也可以在信号的不同段中寻找相似性以确定信号是否为周期性信号。


参考下面Matlab实现的代码，给出Julia实现代码：

##### MATLAB


##### 比较具有不同采样率的信号

假设有一个音频信号数据库和一个模式匹配应用程序，您需要在歌曲播放时识别该歌曲。数据通常以低采样率存储，以占用较少的内存。

```
% Matlab代码
load relatedsig

figure
ax(1) = subplot(3,1,1);
plot((0:numel(T1)-1)/Fs1,T1,"k")
ylabel("Template 1")
grid on
ax(2) = subplot(3,1,2); 
plot((0:numel(T2)-1)/Fs2,T2,"r")
ylabel("Template 2")
grid on
ax(3) = subplot(3,1,3); 
plot((0:numel(S)-1)/Fs,S)
ylabel("Signal")
grid on
xlabel("Time (s)")
linkaxes(ax(1:3),"x")
axis([0 1.61 -4 4])
```

第一个和第二个子图显示来自数据库的模板信号。第三个子图显示我们要在数据库中搜索的信号。仅仅通过观察时间序列，该信号似乎与两个模板信号都不匹配。经仔细检查发现，这些信号实际上具有不同的长度和采样率。

```
% Matlab代码
[Fs1 Fs2 Fs]
```

长度不同使您无法计算两个信号之间的差，但这可以通过提取信号的共同部分来轻松解决。此外，并不始终需要对长度进行均衡化处理。不同长度的信号之间可以执行互相关，但必须确保它们具有相同的采样率。最安全的做法是以较低的采样率对信号进行重采样。resample 函数在重采样过程中对信号应用一个抗混叠（低通）FIR 滤波器。


```
% Matlab代码
[P1,Q1] = rat(Fs/Fs1);          % Rational fraction approximation
[P2,Q2] = rat(Fs/Fs2);          % Rational fraction approximation
T1 = resample(T1,P1,Q1);        % Change sample rate by rational factor
T2 = resample(T2,P2,Q2);        % Change sample rate by rational factor
```

##### 测量信号之间的延迟并将它们对齐


假设您要从不同的传感器采集数据，这些传感器在桥的两边记录汽车引起的振动。当您分析信号时，您可能需要对齐它们。假设有 3 个传感器以相同的采样率工作并测量由同一事件引起的信号。

```
% Matlab代码
figure
ax(1) = subplot(3,1,1);
plot(s1)
ylabel("s1")
grid on
ax(2) = subplot(3,1,2); 
plot(s2,"k")
ylabel("s2")
grid on
ax(3) = subplot(3,1,3); 
plot(s3,"r")
ylabel("s3")
grid on
xlabel("Samples")
linkaxes(ax,"xy")
```

我们还可以使用 finddelay 函数来找到两个信号之间的延迟。

```
% Matlab代码
t21 = finddelay(s1,s2)
t31 = finddelay(s1,s3)
```

t21 表示 s2 比 s1 滞后 350 个采样，而 t31 表示 s3 比 s1 超前 150 个采样。现在可使用此信息通过时移信号来对齐这 3 个信号。我们还可以使用 alignsignals 函数，通过延迟最早的信号来对齐这些信号。

```
% Matlab代码
s1 = alignsignals(s1,s3);
s2 = alignsignals(s2,s3);

figure
ax(1) = subplot(3,1,1);
plot(s1)
grid on 
title("s1")
axis tight
ax(2) = subplot(3,1,2);
plot(s2)
grid on 
title("s2")
axis tight
ax(3) = subplot(3,1,3); 
plot(s3)
grid on 
title("s3")
axis tight
linkaxes(ax,"xy")
```

##### 比较信号的频率成分

功率谱显示每个频率中存在的功率。频谱相干性确定信号之间的频域相关性。趋向于 0 的相干性值表示对应的频率分量不相关，而趋向于 1 的值表示对应的频率分量相关。假设有两个信号，它们各自的功率谱如下。

```
% Matlab代码
Fs = FsSig;         % Sample Rate

[P1,f1] = periodogram(sig1,[],[],Fs,"power");
[P2,f2] = periodogram(sig2,[],[],Fs,"power");

figure
t = (0:numel(sig1)-1)/Fs;
subplot(2,2,1)
plot(t,sig1,"k")
ylabel("s1")
grid on
title("Time Series")
subplot(2,2,3)
plot(t,sig2)
ylabel("s2")
grid on
xlabel("Time (s)")
subplot(2,2,2)
plot(f1,P1,"k")
ylabel("P1")
grid on
axis tight
title("Power Spectrum")
subplot(2,2,4)
plot(f2,P2)
ylabel("P2")
grid on
axis tight
xlabel("Frequency (Hz)")
```

