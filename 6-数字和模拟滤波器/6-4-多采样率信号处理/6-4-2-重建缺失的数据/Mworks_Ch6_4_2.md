# 信号处理仿真与应用-MWorks版-案例

# 第6章 数字和模拟滤波器

## 6.4 多采样率信号处理

### 6.4.2 重建缺失的数据

随着廉价数据采集硬件的出现，我们通常可以访问定期快速采样的信号。这使我们可以获得对基础信号的精细近似值。但是，当我们测量的数据被粗略采样或遗漏重要部分时，会发生什么？如何推断已知样本之间点的信号值？

##### MATLAB

##### 线性插值

线性插值是迄今为止在采样点之间推断值的最常用方法。默认情况下，当您在 MATLAB 中绘制向量时，您会看到由直线连接的点。您需要对信号进行非常精细的采样，以便近似真实信号。

在此示例中，正弦曲线以精细和粗分辨率进行采样。当绘制在图形上时，精细采样的正弦曲线与真正的连续正弦曲线非常相似。因此，您可以将其用作“真实信号”的模型。在下图中，粗采样信号的样本显示为由直线连接的圆圈。

```
% Matlab代码
tTrueSignal = 0:0.01:20;
xTrueSignal = sin(2*pi*2*tTrueSignal/7);

tSampled = 0:20;
xSampled = sin(2*pi*2*tSampled/7);

plot(tTrueSignal,xTrueSignal,'-', ...
    tSampled,xSampled,'o-')
legend('true signal','samples')
```

以与执行插值相同的方式恢复中间样本非常简单。这可以通过函数的线性方法来完成。

```
% Matlab代码
tResampled = 0:0.1:20;
xLinear = interp1(tSampled,xSampled,tResampled,'linear');
plot(tTrueSignal,xTrueSignal,'-', ...
     tSampled, xSampled, 'o-', ...
     tResampled,xLinear,'.-')
legend('true signal','samples','interp1 (linear)')
```

线性插值的问题在于结果不是很平滑。其他插值方法可以产生更平滑的近似值。

##### 样条插值

许多物理信号就像正弦曲线，因为它们是连续的并且具有连续的导数。您可以使用三次样条插值来重建此类信号，这可确保插值信号的一阶导数和二阶导数在每个数据点上都是连续的：

```
% Matlab代码
xSpline = interp1(tSampled,xSampled,tResampled,'spline');
plot(tTrueSignal,xTrueSignal,'-', ...
     tSampled, xSampled,'o', ...
     tResampled,xLinear,'.-', ...
     tResampled,xSpline,'.-')
legend('true signal','samples','interp1 (linear)','interp1 (spline)')
```

三次样条曲线在插值由正弦曲线组成的信号时特别有效。但是，还有其他技术可用于获得对物理信号的更高保真度，这些物理信号具有高达非常高阶的连续导数。

##### 使用抗混叠滤波器进行重采样

Signal Processing Toolbox 中的函数提供了另一种填充缺失数据的技术。 可以重建低频的正弦分量，失真非常低。

```
% Matlab代码
xResample = resample(xSampled, 10, 1);
tResample = 0.1*((1:numel(xResample))-1);

plot(tTrueSignal,xTrueSignal,'-', ...
     tResampled,xSpline,'.', ...
     tResample, xResample,'.')
legend('true signal','interp1 (spline)','resample')
```

与其他方法一样，在重建端点时存在一些困难。另一方面，重建信号的中心部分与真实信号非常吻合。

```
% Matlab代码
xlim([6 10])
```

