# 信号处理仿真与应用-MWorks版-案例

# 第3章 信号生成和预处理

## 3.2 


### 3.2.8 sinc函数

语法如下：

y = sinc(x)

说明：y = sinc(x) 返回一个数组 y，其元素是输入 x 的元素的 sinc 函数值。 输出 y 的大小与 x 相同。

示例：理想带限插值，对以整数间隔采样的随机信号执行理想的带限插值。假设要插值的信号x在给定时间间隔之外为0，并且已在奈奎斯特频率下采样。重置随机数生成器以提高重现性。

##### MATLAB

##### 目的

显示理想带限插值图。

```matlab
rng default

t = 1:10;
x = randn(size(t))';
ts = linspace(-5,15,600);
[Ts,T] = ndgrid(ts,t);
y = sinc(Ts - T)*x;

plot(t,x,'o',ts,y)
xlabel Time, ylabel Signal
legend('Sampled','Interpolated','Location','SouthWest')
legend boxoff
```
