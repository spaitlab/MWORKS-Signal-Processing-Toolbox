# 信号处理仿真与应用-MWorks版-案例


# 第6章 

## 6.1.3 FIR滤波器设计 

### FIR带通滤波器

此示例演示如何设计、分析和实现FIR滤波器。

##### MATLAB


```
% Matlab代码

% 设计一个通带范围为 0.35π≤ω≤0.65π 弧度/采样点的 48 阶 FIR 带通滤波器。可视化其幅值和相位响应。
b = fir1(48,[0.35 0.65]);
freqz(b,1,512)

% 加载 chirp.mat。该文件包含信号 y，其大部分功率高于 Fs/4（即奈奎斯特频率的一半）。采样率为 8192 Hz。
% 设计一个 34 阶 FIR 高通滤波器，以衰减低于 Fs/4 的信号的分量。使用截止频率 0.48 和波纹为 30 dB 的切比雪夫窗。
load chirp
t = (0:length(y)-1)/Fs;

bhi = fir1(34,0.48,'high',chebwin(35,30));
freqz(bhi,1)

%对信号进行滤波。显示原始信号和高通滤波后的信号。两个图使用相同的 y 轴刻度。
outhi = filter(bhi,1,y);

subplot(2,1,1)
plot(t,y)
title('Original Signal')
ys = ylim;

subplot(2,1,2)
plot(t,outhi)
title('Highpass Filtered Signal')
xlabel('Time (s)')
ylim(ys)

% 设计一个具有相同设定的低通滤波器。对信号进行滤波，并将结果与原始结果进行比较。两个图使用相同的 y 轴刻度。
blo = fir1(34,0.48,chebwin(35,30));

outlo = filter(blo,1,y);

subplot(2,1,1)
plot(t,y)
title('Original Signal')
ys = ylim;

subplot(2,1,2)
plot(t,outlo)
title('Lowpass Filtered Signal')
xlabel('Time (s)')
ylim(ys)

% 多频带 FIR 滤波器
% 设计一个 46 阶 FIR 滤波器，用它衰减低于 0.4π 弧度/采样点以及介于 0.6π 和 0.9π 弧度/采样点之间的归一化频率。将此滤波器命名为 bM。计算它的频率响应。
ord = 46;

low = 0.4;
bnd = [0.6 0.9];

bM = fir1(ord,[low bnd]);
[hbM,f] = freqz(bM,1);

% 重新设计 bM，使其通过它在上例中衰减的频带并阻止其他频率。将新滤波器命名为 bW。显示滤波器的频率响应。
bW = fir1(ord,[low bnd],"DC-1");

[hbW,~] = freqz(bW,1);
plot(f/pi,mag2db(abs(hbM)),f/pi,mag2db(abs(hbW)))
legend("bM","bW",Location="best")
ylim([-75 5])
grid

%使用汉宁窗重新设计 bM。（"DC-0" 是可选的。）比较汉明设计和汉宁设计的幅值响应。
hM = fir1(ord,[low bnd],'DC-0',hann(ord+1));

hhM = freqz(hM,1);
plot(f/pi,mag2db(abs(hbM)),f/pi,mag2db(abs(hhM)))
legend("Hamming","Hann",Location="northwest")
ylim([-75 5])
grid

% 使用图基窗重新设计 bW。比较汉明设计和图基设计的幅值响应。tW = fir1(ord,[low bnd],'DC-1',tukeywin(ord+1));

htW = freqz(tW,1);
plot(f/pi,mag2db(abs(hbW)),f/pi,mag2db(abs(htW)))
legend("Hamming","Tukey",Location="best")
ylim([-75 5])
grid
```
##### Julia

```
# 设计一个通带为 0.35π≤ω≤0.65π rad/sample 的 48 阶 FIR 带通滤波器。可视化其幅度和相位响应。

using TySignalProcessing

b = fir1(48, [0.35 0.65])
freqz(b, [1],512,plotfig = true)

# 加载 chirp.mat。该文件包含一个信号 y，其大部分功率高于 Fs/4，或奈奎斯特频率的一半。采样率为 8192 Hz。 
# 设计一个 34 阶 FIR 高通滤波器以衰减低于 Fs/4 的信号分量。使用 0.48 的截止频率和具有 30 dB 纹波的切比雪夫窗口。

using TyPlot 
using TyMath
using TySignalProcessing
using TyDSPSystem
pkg_dir = pkgdir(TySignalProcessing)
source_path = pkg_dir * "/examples/Resource/chirp.mat"
mfr = dsp_MatFileReader(Filename = source_path, VariableName = "y", SamplesPerFrame = 13129)
y = step(mfr)
mtlb = vec(y)
Fs = 8192
t = [(0:length(y)-1) / Fs...]
bhi = fir1(34, 0.48, "highpass", chebwin(35, 30))
freqz(bhi, [1], plotfig = true)

 

# 过滤信号。显示原始信号和高通滤波信号。对两个图使用相同的 y 轴比例。
outhi, = filter1(bhi, [1], y)
figure()
subplot(2, 1, 1)
plot(t, y)
title("Original Signal")
ys = ylim()
subplot(2, 1, 2)
plot(t, outhi)
title("Highpass Filtered Signal")
xlabel("Time (s)")
ylim(ys)
 
# 设计一个具有相同规格的低通滤波器。过滤信号并将结果与​​原始结果进行比较。对两个图使用相同的 y 轴比例。
blo = fir1(34, 0.48, chebwin(35, 30))
outlo, = filter1(blo, [1], y)
figure()
subplot(2, 1, 1)
plot(t, y)
title("Original Signal")
ys = ylim()
subplot(2, 1, 2)
plot(t, outlo)
title("Highpass Filtered Signal")
xlabel("Time (s)")
ylim(ys)


# 多频带 FIR 滤波器
# 设计一个 46 阶 FIR 滤波器，衰减低于 0.4π rad/sample和介于 0.6π 和 0.9π rad/sample之间的归一化频率。称之为 bM。

using TyPlot 
using TySignalProcessing

ord = 46
low = 0.4
bnd = [0.6 0.9]
bM = fir1(ord,[low bnd])

# 重新设计 bM 使其通过它正在衰减的频段并停止其他频率。调用新滤波器 bW。显示滤波器的频率响应。

bW = fir1(ord,[low bnd],"DC-1")
fvtool(bM, 1, bW, 1, Analysis = "magnitude")
legend(["bM","bW"])

# 使用 Hann 窗重新设计 bM。 （“DC-0”是可选的。）比较 Hamming 和 Hann 设计的幅度响应。

hM = fir1(ord,[low bnd],"DC-0",hann(ord+1))
figure()
fvtool(bM, 1, hM, 1, Analysis = "magnitude")
legend(["Hamming", "Hann"])

# 使用 Tukey 窗口重新设计 bW。比较 Hamming 和 Tukey 设计的幅度响应。

tW = fir1(ord,[low bnd],"DC-1",tukeywin(ord+1))
figure()
fvtool(bW, 1, tW, 1, Analysis = "magnitude")
legend(["Hamming", "Tukey"])
```

