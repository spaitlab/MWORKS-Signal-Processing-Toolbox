# 信号处理仿真与应用-MWorks版-案例

# 第3章 信号生成和预处理

## 3.1 平滑和去噪

### 3.1.3 对数据去趋势

测量的信号可能显示数据中非固有的整体模式。这些趋势有时会妨碍数据分析，因此必须进行去趋势。

参考下面2段Matlab实现的代码，给出Julia实现代码：

##### MATLAB

以具有不同趋势的两种心电图 (ECG) 信号为例。ECG 信号对电源干扰等扰动很敏感。加载信号并绘制它们。

```
% Matlab代码
load('ecgSignals.mat') 

t = (1:length(ecgl))';

subplot(2,1,1)
plot(t,ecgl), grid
title 'ECG Signals with Trends', ylabel 'Voltage (mV)'

subplot(2,1,2)
plot(t,ecgnl), grid
xlabel Sample, ylabel 'Voltage (mV)'
```
第一个绘图上的信号显示线性趋势。第二个信号的趋势是非线性的。要去线性趋势，请使用 MATLAB® 函数 detrend。

```
% Matlab代码
dt_ecgl = detrend(ecgl);
```

要去非线性趋势，请对信号进行低阶多项式拟合并减去它。在本例中，多项式为 6 阶。绘制两个新信号。

```
% Matlab代码
opol = 6;
[p,s,mu] = polyfit(t,ecgnl,opol);
f_y = polyval(p,t,[],mu);

dt_ecgnl = ecgnl - f_y;

subplot(2,1,1)
plot(t,dt_ecgl), grid
title 'Detrended ECG Signals', ylabel 'Voltage (mV)'

subplot(2,1,2)
plot(t,dt_ecgnl), grid
xlabel Sample, ylabel 'Voltage (mV)'
```

