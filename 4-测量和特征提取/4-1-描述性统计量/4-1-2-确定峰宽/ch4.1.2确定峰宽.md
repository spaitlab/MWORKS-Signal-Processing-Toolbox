### **4.1.2确定峰宽**

​        数字信号处理技术中峰值特征的精确分析对于理解和优化信号的质量至关重要。本案例提供了如何在Mworks中通过Julia语言实现确定峰宽findpeaks是MATLAB中一个非常有用的函数，它用于寻找一维数据中的局部最大值（峰值）。这个函数不仅可以找到峰值，还可以返回有关这些峰值的详细信息，例如它们的宽度、高度和相对于其他特征的重要性（如突起度和阈值）。在Syslab函数库函数库TySignalProcessing中也对应提供了函数findpeaks，用于返回包含输入信号向量 data 的局部极大值（峰值）的向量，以下是具体示例：

参考下面2段Matlab实现的代码，给出Julia实现代码：

##### MATLAB

##### 目的

创建一个由几条钟形曲线之和组成的信号。指定每条曲线的位置、高度和宽度。

```
% Matlab代码
x = linspace(0,1,1000);

Pos = [1 2 3 5 7 8]/10;
Hgt = [4 4 2 2 2 3];
Wdt = [3 8 4 3 4 6]/100;

for n = 1:length(Pos)
    Gauss(n,:) =  Hgt(n)*exp(-((x - Pos(n))/Wdt(n)).^2);
end

PeakSig = sum(Gauss);
```

绘制各单条曲线及其总和。

```
% Matlab代码
plot(x,Gauss,'--',x,PeakSig)
grid
```

在相对高差的一半处测量波峰的宽度。

```
% Matlab代码
findpeaks(PeakSig,x,'Annotate','extents')
```

再次测量宽度，这次在半高处测量。

```
% Matlab代码
findpeaks(PeakSig,x,'Annotate','extents','WidthReference','halfheight')
title('Signal Peak Widths')
```

##### Julia

找到向量的峰值:定义一个有三个峰值的向量，并绘制它。

```
# Julia代码
using TyPlot 
using TySignalProcessing

data = [25 8 15 5 6 10 10 3 1 20 7]
plot(data)
```

绘制峰值。

```
 findpeaks(data; plotfig=true)
```

找到信号的峰值并输出其位置

创建一个由钟形曲线之和组成的信号。指定每条曲线的位置、高度和宽度。

```
usingTyPlot 
using TySignalProcessing
using TyMath

x = [range(0, 1, 1000);]'
Pos = [1, 2, 3, 5, 7, 8] / 10
Hgt = [3, 4, 4, 2, 2, 3]
Wdt = [2, 6, 3, 3, 4, 6] / 100
Gauss = zeros(length(Pos), 1000)

for n in 1:length(Pos)
  Gauss[n, :] = Hgt[n] .* exp.(-((x .- Pos[n]) / Wdt[n]) .^ 2)
end

PeakSig = sum(Gauss; dims=1)
```

绘制各个曲线及其总和。

```
plot(x, Gauss', "--", x, PeakSig')
```

使用默认设置的 findpeaks 找到信号峰值及其位置

```
findpeaks(PeakSig, x; plotfig=true)
text(locs .+ 0.02, pks, string.([1:length(pks);]))
grid("on")
```

将峰值从最高到最短进行分类

```
pks, locs = findpeaks(vec(PeakSig), x; SortStr="descend")
findpeaks(PeakSig, x; SortStr="descend", plotfig=true)
text(locs .+ 0.02, pks, string.([1:length(pks);]))
grid("on")
```

