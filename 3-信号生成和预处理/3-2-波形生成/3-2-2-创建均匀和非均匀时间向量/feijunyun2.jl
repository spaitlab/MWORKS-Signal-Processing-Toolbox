# 设置快速采样频率
Ffast = 100
# 计算快速采样的时间间隔
Tf = 1 / Ffast
# 设置慢速采样的点数
Nslow = 5
tdisc = [range(0, 1, length=Nslow); range(1, stop=2 - Tf, step=Tf); range(2, 3, length=Nslow)]'
res, = gauspuls(tdisc .- 1.5, 5, 0.4)
Tcont = range(0, 3, 20001)'
re, = gauspuls(Tcont .- 1.5, 5, 0.4)
plot(Tcont, re, "#00FF00", tdisc, res, "c*")