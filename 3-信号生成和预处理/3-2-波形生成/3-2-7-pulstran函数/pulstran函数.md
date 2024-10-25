# 信号处理仿真与应用-MWorks版-案例


# 第3章 信号生成和预处理

## 3.2.7pulstran 函数

### 脉冲函数

pulstran 函数基于连续的或采样的原型脉冲生成脉冲序列。此示例生成由高斯脉冲的多次延迟插值之和组成的脉冲序列。

该脉冲序列定义为具有 50 kHz 的采样率、10 ms 的脉冲序列长度和 1 kHz 的脉冲重复率。T 指定脉冲序列的采样时刻。D 在第一列中指定每个脉冲重复的延迟，在第二列中指定每个重复的可选衰减。要构造该脉冲序列，请将 gauspuls 函数的名称以及附加参数（用于指定带宽为 50% 的 10 kHz 高斯脉冲）传递给 pulstran。
##### MATLAB


```
% Matlab代码
T = 0:1/50e3:10e-3;
D = [0:1/1e3:10e-3;0.8.^(0:10)]';
Y = pulstran(T,D,'gauspuls',10e3,0.5);
plot(T,Y)

```
##### Julia

```
% Julia代码
using DSP
T = 0:1/50e3:10e-3
D = hcat(0:1/1e3:10e-3, 0.8 .^(0:10))
Y = pulstran(T, D, gauspuls, 10e3, 0.5)
using Plots
plot(T, Y)

```
