# 信号处理仿真与应用-MWorks版-案例

# 第5章 变换、相关性和建模

## 5.2 相关性和卷积

### 5.2.8 多通道输入的互相关

##### MATLAB

生成三个包含 11 个样本的指数序列，这些样本由 0.4<sup>*n*</sup>、0.7<sup>*n*</sup>和 0.999<sup>*n*</sup> (*n*≥0) 给出。使用 `stem3` 并排绘制这些序列。

```
% Matlab代码
N = 11;
n = (0:N-1)';

a = 0.4;
b = 0.7;
c = 0.999;

xabc = [a.^n b.^n c.^n];

stem3(n,1:3,xabc','filled')
ax = gca;
ax.YTick = 1:3;
view(37.5,30)
```

计算这些序列的自相关和互相关。将输出滞后，这样就不必跟踪它们。将结果归一化，使自相关在零滞后处具有单位值。

```
% Matlab代码
[cr,lgs] = xcorr(xabc,'coeff');

for row = 1:3
    for col = 1:3
        nm = 3*(row-1)+col;
        subplot(3,3,nm)
        stem(lgs,cr(:,nm),'.')
        title(sprintf('c_{%d%d}',row,col))
        ylim([0 1])
    end
end
```

仅计算滞后值为 −5 和 5 之间时的相关性。

```
% Matlab代码
[cr,lgs] = xcorr(xabc,5,'coeff');

for row = 1:3
    for col = 1:3
        nm = 3*(row-1)+col;
        subplot(3,3,nm)
        stem(lgs,cr(:,nm),'.')
        title(sprintf('c_{%d%d}',row,col))
        ylim([0 1])
    end
end
```

计算自相关和互相关性无偏估计。默认情况下，滞后介于 −(*N*−1) 和 *N*−1 之间。

```
% Matlab代码
cu = xcorr(xabc,'unbiased');

for row = 1:3
    for col = 1:3
        nm = 3*(row-1)+col;
        subplot(3,3,nm)
        stem(-(N-1):(N-1),cu(:,nm),'.')
        title(sprintf('c_{%d%d}',row,col))
    end
end
```





