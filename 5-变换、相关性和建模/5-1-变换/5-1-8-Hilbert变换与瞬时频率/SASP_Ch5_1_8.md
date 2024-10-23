# 信号处理仿真与应用-MWorks版-案例


# 第5章 变换

## 5.1.8 Hilbert 变换与瞬时频率

### 分析信号和 hilbert 变换

hilbert 函数为有限的数据块找到准确的分析信号。可以通过使用有限脉冲响应 (FIR) hilbert 变换滤波器来计算虚部的近似值来生成解析信号。

生成由三个频率为 203、721 和 1001 Hz 的正弦波组成的序列。该序列以 10 kHz 采样约 1 秒。使用希尔伯特函数计算解析信号。
在 0.01 秒和 0.03 秒之间绘制它。
##### MATLAB


```
% Matlab代码
fs = 1e4;
t = (0:1/fs:1);
x = 2.5 + cos(2 * pi * 203 * t) + sin(2 * pi * 721 * t) + cos(2 * pi * 1001 * t);
y = hilbert(x);
plot(t, real(y), t, imag(y));
xlim([0.01 0.03]);
legend("real", "imaginary");
title("hilbert Function");
xlabel("Time (s)");


```
##### Julia

```
% Julia代码
using TySignalProcessing
using TyPlot

fs = 1e4
t = (0:1/fs:1)
x = 2.5 .+ cos.(2 * pi * 203 * t) .+ sin.(2 * pi * 721 * t) .+ cos.(2 * pi * 1001 * t)
y = hilbert(x)
plot(t, real(y), t, imag(y))
xlim([0.01 0.03])
legend(["real", "imaginary"])
title("hilbert Function")
xlabel("Time (s)")


```
