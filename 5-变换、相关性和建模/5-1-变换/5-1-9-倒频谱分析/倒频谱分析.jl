using TyPlot
using TySignalProcessing
using Interpolations
using TyBase
# 生成时间序列
t = collect(0:0.01:1.27)

# 生成信号序列
s1 = sin.(2π*45*t)
s2 = s1 .+ 0.5 .* [zeros(20); s1[1:108]]

# 计算倒谱
c = cceps(s2)

# 将 c[1] 进行线性插值，扩展为长度为 128 的向量
c_resampled = interpolate(c[1], BSpline(Linear()), OnGrid())

# 获取新的时间序列
t_new = range(0, stop=1.27, length=128)

# 绘制频谱图
plot(t_new, c_resampled)

# 使用 rceps 函数
y = [4, 1, 5]
xhat, yhat = rceps(vec(y))  # 将矩阵转换为向量
xhat2 = rceps(vec(yhat))    # 将矩阵转换为向量

x = collect(1:10)
xhat, delay = cceps(x)
icc = icceps(xhat, 2)