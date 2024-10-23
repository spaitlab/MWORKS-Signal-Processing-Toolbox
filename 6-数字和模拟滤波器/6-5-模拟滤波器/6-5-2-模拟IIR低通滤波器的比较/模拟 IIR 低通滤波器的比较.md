# 信号处理仿真与应用-MWorks版-案例

# 第6章 数字和模拟滤波器

## 6.5 模拟滤波器

### 6.5.2 模拟 IIR 低通滤波器的比较 

##### MATLAB

TySignalProcessing中提供了一系列函数用于 MATLAB 样式的 IIR 滤波器设计。

设计截止频率为 2 GHz 的五阶模拟巴特沃斯低通滤波器。乘以 2π 以将频率转换为弧度/秒。计算滤波器在 4096 个点上的频率响应。

```
%Matlab代码
n = 5;
fc = 2e9;
[zb,pb,kb] = butter(n,2*pi*fc,"s");
[bb,ab] = zp2tf(zb,pb,kb);
[hb,wb] = freqs(bb,ab,4096);
```

设计一个具有相同边缘频率和 3 dB 通带波纹的五阶切比雪夫 I 型滤波器。计算它的频率响应。

```
%Matlab代码
[z1,p1,k1] = cheby1(n,3,2*pi*fc,"s");
[b1,a1] = zp2tf(z1,p1,k1);
[h1,w1] = freqs(b1,a1,4096);
```

设计一个具有相同边缘频率和 30 dB 阻带衰减的 5 阶切比雪夫 II 型滤波器。计算它的频率响应。

```
%Matlab代码
[z2,p2,k2] = cheby2(n,30,2*pi*fc,"s");
[b2,a2] = zp2tf(z2,p2,k2);
[h2,w2] = freqs(b2,a2,4096);
```

设计一个具有相同边缘频率和 3 dB 通带波纹、30 dB 阻带衰减的五阶椭圆滤波器。计算它的频率响应。

```
%Matlab代码
[ze,pe,ke] = ellip(n,3,30,2*pi*fc,"s");
[be,ae] = zp2tf(ze,pe,ke);
[he,we] = freqs(be,ae,4096);
```

设计一个具有相同边缘频率的 5 阶贝塞尔滤波器。计算它的频率响应。

```
%Matlab代码
[zf,pf,kf] = besself(n,2*pi*fc);
[bf,af] = zp2tf(zf,pf,kf);
[hf,wf] = freqs(bf,af,4096);
```

对衰减绘图，以分贝为单位。以千兆赫为单位表示频率。比较滤波器。

```
%Matlab代码
plot([wb w1 w2 we wf]/(2e9*pi), ...
    mag2db(abs([hb h1 h2 he hf])))
axis([0 5 -45 5])
grid
xlabel("Frequency (GHz)")
ylabel("Attenuation (dB)")
legend(["butter" "cheby1" "cheby2" "ellip" "besself"])
```

巴特沃斯和切比雪夫 II 型滤波器具有平坦的通带和宽过渡带。切比雪夫 I 型和椭圆滤波器转降更快，但有通带波纹。切比雪夫 II 型设计函数的频率输入设置阻带的起点，而不是通带的终点。贝塞尔滤波器沿通带具有大致恒定的群延迟。



