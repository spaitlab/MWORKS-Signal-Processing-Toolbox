# 信号处理仿真与应用-MWorks版-案例


# 第5章 

## 5.2.6使用自相关求周期性

### 脉冲函数

此示例说明如何使用自相关求周期性。

##### MATLAB


```
% Matlab代码

% 定义自相关函数
function autocorr = autocorrelation(data, lag)
    n = length(data);
    mean_data = mean(data);
    autocorr = 0.0;
    
    for i = 1:(n - lag)
        autocorr = autocorr + (data(i) - mean_data) * (data(i + lag) - mean_data);
    end
    
    autocorr = autocorr / n;
end

% 生成示例时间序列数据
data = zeros(1, 100);
for t = 1:100
    data(t) = sin(2 * pi * t / 10) + 0.5 * randn();
end

% 计算自相关函数
lags = 1:20;  % 滞后值范围
autocorr_values = zeros(1, length(lags));
for i = 1:length(lags)
    autocorr_values(i) = autocorrelation(data, lags(i));
end

% 绘制自相关函数图形
plot(lags, autocorr_values);
xlabel('Lag');
ylabel('Autocorrelation');
title('Autocorrelation Function Plot');

```
##### Julia

```
% Julia代码
using Statistics
using Plots

# 定义自相关函数
function autocorrelation(data, lag)
    n = length(data)
    mean_data = mean(data)
    autocorr = 0.0
    
    for i in 1:(n - lag)
        autocorr += (data[i] - mean_data) * (data[i + lag] - mean_data)
    end
    
    autocorr /= n
    
    return autocorr
end

# 生成示例时间序列数据
data = [sin(2 * pi * t / 10) + 0.5 * randn() for t in 1:100]

# 计算自相关函数
lags = 1:20  # 滞后值范围
autocorr_values = [autocorrelation(data, lag) for lag in lags]

# 绘制自相关函数图形
plt = plot(lags, autocorr_values, xlabel="Lag", ylabel="Autocorrelation", label="Autocorrelation Function", 
     title="Autocorrelation Function Plot")

# 显示图形
display(plt)

```

