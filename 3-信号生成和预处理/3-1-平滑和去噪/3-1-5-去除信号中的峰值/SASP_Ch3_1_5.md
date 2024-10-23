# 信号处理仿真与应用-MWorks版-案例

# 第3章 信号生成和预处理

## 3.1 平滑和去噪

### 3.1.5 去除信号中的峰值

去除信号中的峰值

有时数据会出现不必要的瞬变（即峰值），中位数滤波是消除它的好方法。

参考下面2段Matlab实现的代码，给出Julia实现代码：

##### MATLAB

在存在 60 Hz 电力线噪声的情况下，研究模拟仪器的输入的开环电压。电压采样频率为 1 kHz。

```
% Matlab代码
load openloop60hertz

fs = 1000;
t = (0:numel(openLoopVoltage) - 1)/fs;
```

通过在随机点添加随机符号以加入瞬变以破坏信号。重置随机数生成器以获得可再现性。

```
% Matlab代码
rng default

spikeSignal = zeros(size(openLoopVoltage));
spks = 10:100:1990;
spikeSignal(spks+round(2*randn(size(spks)))) = sign(randn(size(spks)));

noisyLoopVoltage = openLoopVoltage + spikeSignal;

plot(t,noisyLoopVoltage)

xlabel('Time (s)')
ylabel('Voltage (V)')
title('Open-Loop Voltage with Added Spikes')
yax = ylim;
```

函数 `medfilt1` 将信号的每个点替换为该点和指定数量的邻点的中位数。因此，中位数滤波会丢弃与其周围环境相差很大的点。通过使用三个邻点的集合计算中位数来对信号进行滤波。注意峰值是如何消失的。

```
% Matlab代码
medfiltLoopVoltage = medfilt1(noisyLoopVoltage,3);

plot(t,medfiltLoopVoltage)

xlabel('Time (s)')
ylabel('Voltage (V)')
title('Open-Loop Voltage After Median Filtering')
ylim(yax)
grid
```

