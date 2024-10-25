# 信号处理仿真与应用-MWorks版-案例

# 第3章 信号生成和预处理

## 3.2 

### 3.2.6 常见的非周期波形

常见的非周期波形

gauspuls：使用指定时间、中心频率和小数带宽生成高斯调制正弦脉冲。可选参数返回同相脉冲和正交脉冲、RF 信号包络，以及尾部脉冲包络的截止时间。

chirp：生成线性、对数或二次扫频正弦信号。可选参数指定替代扫描方法。可选参数允许以度数指定初始相位。

示例生成具有线性瞬时频率偏差的噪音,计算并绘制 chirp 的时域图。噪音以 1 kHz的采样频率采样 2 秒。瞬时频率在 t = 0 时为 0，在 t = 1 秒时跨越 250 Hz。

参考下面2段Matlab实现的代码，给出Julia实现代码：

##### MATLAB

##### 目的

显示chirp时域图

```matlab
% Matlab代码
% 参数定义
Fs = 1000; % 采样频率 1 kHz
t = 0:1/Fs:2; % 生成时间向量，从0到2秒
f0 = 0; % 初始频率
f1 = 250; % 1秒时的频率
T = 1; % 目标时间为1秒

% 生成chirp信号
y = chirp(t, f0, T, f1);

% 绘图
figure; % 创建新图形窗口
plot(t, y); % 绘制时域图
xlabel('Time (s)'); % x轴标签
ylabel('Amplitude'); % y轴标签
title('Chirp'); % 图标题
grid on; % 显示网格
```



##### 一种移动平均滤波器

##### 目的

显示高斯射频脉冲图。

示例使用 gauspuls 绘制带宽为 60% 的 50 kHz 高斯射频脉冲,以 10 MHz 的速率采样。截断包络低于峰值 40 dB的脉冲。并绘制正交脉冲和RF 信号包络。

```matlab
% Matlab代码
tc = gauspuls('cutoff',50e3,0.6,[],-40); 
t = -tc : 1e-7 : tc; 
[yi,yq,ye] = gauspuls(t,50e3,0.6); 

plot(t,yi,t,yq,t,ye)
legend('Inphase','Quadrature','Envelope')
```

