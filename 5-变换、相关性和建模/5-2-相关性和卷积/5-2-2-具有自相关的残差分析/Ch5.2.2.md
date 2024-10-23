# 信号处理仿真与应用-MWorks版-案例


# 第5章 

## 5.2.2具有自相关的残差分析

### 残差分析

此示例演示如何使用具有置信区间的自相关来分析噪声数据的最小二乘拟合的残差。

##### MATLAB


```
% Matlab代码

% 创建噪声数据集
x = -3:0.01:3;
rng default
y = 2*x+randn(size(x));
plot(x,y)

%绘制原始数据以及最小二乘拟合
coeffs = polyfit(x,y,1);
yfit = coeffs(2)+coeffs(1)*x;

plot(x,y)
hold on
plot(x,yfit,'linewidth',2)

%求残差。获得滞后 50 的残差自相关序列。
residuals = y - yfit;
[xc,lags] = xcorr(residuals,50,'coeff');

%使用临界值构建置信下限和上限
conf99 = sqrt(2)*erfcinv(2*.01/2);
lconf = -conf99/sqrt(length(x));
upconf = conf99/sqrt(length(x));

%绘制自相关序列以及 99% 置信区间。
figure

stem(lags,xc,'filled')
ylim([lconf-0.03 1.05])
hold on
plot(lags,lconf*ones(size(lags)),'r','linewidth',2)
plot(lags,upconf*ones(size(lags)),'r','linewidth',2)
title('Sample Autocorrelation with 99% Confidence Intervals')

%创建一个由正弦波加噪声组成的信号。数据以 1 kHz 采样。正弦波的频率为 100 Hz。将随机数生成器设置为默认设置以获得可重现的结果。
Fs = 1000;
t = 0:1/Fs:1-1/Fs;
rng default
x = cos(2*pi*100*t)+randn(size(t));

%使用离散傅立叶变换 (DFT) 获得 100 Hz 正弦波的最小二乘拟合
xdft = fft(x);
ampest = 2/length(x)*xdft(101);
xfit = real(ampest)*cos(2*pi*100*t)+imag(ampest)*sin(2*pi*100*t);

figure

plot(t,x)
hold on
plot(t,xfit,'linewidth',2)
axis([0 0.30 -4 4])
xlabel('Seconds')
ylabel('Amplitude')

%求残差并确定样本自相关序列滞后 50。
residuals = x-xfit;
[xc,lags] = xcorr(residuals,50,'coeff');

%绘制具有 99% 置信区间的自相关序列。
figure

stem(lags,xc,'filled')
ylim([lconf-0.03 1.05])
hold on
plot(lags,lconf*ones(size(lags)),'r','linewidth',2)
plot(lags,upconf*ones(size(lags)),'r','linewidth',2)
title('Sample Autocorrelation with 99% Confidence Intervals')

%添加另一个频率为 200 Hz、幅度为 3/4 的正弦波。仅拟合 100 Hz 的正弦波并找出残差的样本自相关。

x = x+3/4*sin(2*pi*200*t);
xdft = fft(x);
ampest = 2/length(x)*xdft(101);
xfit = real(ampest)*cos(2*pi*100*t)+imag(ampest)*sin(2*pi*100*t);
residuals = x-xfit;
[xc,lags] = xcorr(residuals,50,'coeff');

%绘制样本自相关以及 99% 置信区间。
figure

stem(lags,xc,'filled')
ylim([lconf-0.12 1.05])
hold on
plot(lags,lconf*ones(size(lags)),'r','linewidth',2)
plot(lags,upconf*ones(size(lags)),'r','linewidth',2)
title('Sample Autocorrelation with 99% Confidence Intervals')

```
##### Julia

```
% Julia代码

using CSV
using TyMachineLearning
using DataFrames
using TyPlot
file2 = joinpath(pkgdir(TyMachineLearning), "data/Regression/residuals.csv")
lasdata_x2 = CSV.read(file2, DataFrame; header=1)

#打印lasdata_x的前5行进行观测。
lasdata_x2[1:5,:]

 
formula2 = "y ~ InitialWeight + Program + Week + Program:Week"
group2 = "Subject"
random_formula = "Week"

#拟合线性混合效应模型，其中初始权重、节目类型、周以及周与节目类型之间的相互作用为固定效应。截留时间和时间因科目而异。
lme = fitlme(lasdata_x2, formula2, group2; random_formula=random_formula)
#计算拟合值和原始残差。
F = fitted(lme)
R = residuals(lme)
#绘制残差与拟合值的关系。
plot(F, R, "bx")
xlabel("Fitted Values")
ylabel("Residuals")
 
#将残差与拟合值按程序分组绘制出来。
lax, Program, convs = convent_columns(lasdata_x2, "Program")
X = Matrix(lax.values)
group = X[:, 3]
figure()
scatter(F, R; c=group, filled="true")
 
#拟合线性模型2：
lme2 = fitlme(lasdata_x2, formula2, group2; random_formula="Week")
#绘制主效应图
 
#绘制残差与拟合值的关系。
plotResiduals(lme2,"fitted")
 
#没有明显的模式，因此没有异方差的直接迹象。创建残差的中位数对称图。
plotResiduals(lme2,"symmetry")
 
#残差数据看起来很正常。 找出图右边看起来是离群值的数据的观测值。
using TyBaseCore
find(residuals(lme2).>0.25) 

# 绘制原始残差与滞后残差的图。
plotResiduals(lme2,"lagged")

```

