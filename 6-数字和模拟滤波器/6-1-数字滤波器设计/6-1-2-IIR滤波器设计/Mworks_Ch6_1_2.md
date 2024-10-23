# 信号处理仿真与应用-MWorks版-案例

# 第6章 数字和模拟滤波器

## 6.1 数字滤波器设计

### 6.1.2 IIR滤波器设计

##### MATLAB

该工具箱提供的主要 IIR 数字滤波器设计方法基于将经典低通模拟滤波器转换为其等效的数字滤波器。以下各节说明如何设计滤波器，并总结了支持的滤波器类型的特征。默认情况下，这些函数都返回低通滤波器；您只需指定所需的截止频率 `Wn`，以归一化单位表示（使奈奎斯特频率为 1 Hz）。要获得高通滤波器，请将 `'high'` 附加到函数的参数列表中。要获得带通或带阻滤波器，请将 `Wn` 指定为包含通带边缘频率的二元素向量。为带阻配置追加 `'stop'`。

TySignalProcessing中提供了一系列函数用于 MATLAB 样式的 IIR 滤波器设计。下面的代码举了几个例子，butter 函数用于巴特沃斯数字滤波器设计。b,a = butter(5,0.4)设计了一个 5 阶巴特沃斯滤波器，截至频率为奈奎斯特频率的 0.4 倍，返回滤波器的分子多项式（b）和分母多项式（a）。由于没有指定滤波器的类型，默认为低通。类似地，cheby1 函数用于 Chebyshev I 型数字滤波器设计，cheby2 函数用于ChebyshevⅡ型数字滤波器设计，ellip函数用于椭圆数字滤波器设计。可以通过参数指定滤波器类型，'bandpass'指定滤波器为带通滤波器。

以下是一些数字滤波器示例：

```
% Matlab代码
[b,a] = butter(5,0.4);                    % Lowpass Butterworth
[b,a] = cheby1(4,1,[0.4 0.7]);            % Bandpass Chebyshev Type I
[b,a] = cheby2(6,60,0.8,'high');          % Highpass Chebyshev Type II
[b,a] = ellip(3,1,60,[0.4 0.7],'stop');   % Bandstop elliptic
```

所有滤波器设计函数都会返回一个以传递函数、零极点增益或状态空间线性系统模型形式表示的滤波器，具体形式取决于存在多少输出参量。

此工具箱还提供阶选择函数，用于计算满足一组给定要求的最小滤波器阶，它们与滤波器设计函数结合使用时非常有用。假设您需要一个具有以下设定的带通滤波器：通带为 1000 至 2000 Hz，阻带从通带两侧外 500 Hz 处开始，采样频率为 10 kHz，通带波纹至多 1 dB，阻带衰减至少 60 dB。可以通过使用以下 `butter` 函数来满足这些设定。

```
% Matlab代码
[n,Wn] = buttord([1000 2000]/5000,[500 2500]/5000,1,60)
[b,a] = butter(n,Wn);
```

满足相同要求的椭圆滤波器由下式给出

```
% Matlab代码
[n,Wn] = ellipord([1000 2000]/5000,[500 2500]/5000,1,60)
[b,a] = ellip(n,1,60,Wn);
```

工具箱提供五种不同类型的经典 IIR 滤波器，它们各有所长。本部分显示每种滤波器的基本模拟原型形式，并总结了主要特征。

Butterworth 滤波器提供理想低通滤波器在模拟频率 Ω= 0和Ω = ∞处的响应的最佳泰勒级数逼近。 实现 Butterworth 滤波器的代码如下：

```
% Matlab代码
[z,p,k] = buttap(5);
w = logspace(-1,1,1000);
h = freqs(k*poly(z),poly(p),w);
semilogx(w,abs(h)), grid
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
```

Chebyshev I 类滤波器从通带到阻带的过渡比 Butterworth 滤波器更快。实现 Chebyshev I 滤波器的代码如下：

```
% Matlab代码
[z,p,k] = cheb1ap(5,0.5);
w = logspace(-1,1,1000);
h = freqs(k*poly(z),poly(p),w);
semilogx(w,abs(h)), grid
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
```

Chebyshev Ⅱ类滤波器阻带不像 I 型滤波器那样快地逼近零（对于偶数滤波器阶 n 则根本不会逼近零）。它的优势在于通带中没有波纹。实现 Chebyshev Ⅱ滤波器的代码如下：

```
% Matlab代码
[z,p,k] = cheb2ap(5,20);
w = logspace(-1,1,1000);
h = freqs(k*poly(z),poly(p),w);
semilogx(w,abs(h)), grid
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
```

椭圆滤波器在通带和阻带中均采用等波纹，与其他所有滤波器相比，它们通常能够以的最低阶满足指标要求。在给定滤波器阶数 n、以分贝为单位的通带波纹 Rp、阻带波纹 RS 的情况下，椭圆滤波器可以使过渡宽度最小。实现椭圆滤波器的程序如下所示：

```
% Matlab代码
[z,p,k] = ellipap(5,0.5,20);
w = logspace(-1,1,1000);
h = freqs(k*poly(z),poly(p),w);
semilogx(w,abs(h)), grid
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
```

模拟 Bessel 低通滤波器在零频率处具有最大平坦度的群延迟，并且在整个通带内保持几乎恒定的群延迟。因此，滤波后的信号在通带频率范围内保持其波形。相比其他滤波器，Bessel 滤波器通常需要更高的阶数才能获得理想的阻带衰减。实现 Bessel 滤波器的程序如下所示：

```
% Matlab代码
[z,p,k] = besselap(5);
w = logspace(-1,1,1000);
h = freqs(k*poly(z),poly(p),w);
semilogx(w,abs(h)), grid
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
```

