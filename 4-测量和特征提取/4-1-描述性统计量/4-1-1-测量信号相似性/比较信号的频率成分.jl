# 比较信号的频率成分
using Pkg;
using TyMath
using MAT
using TyPlot
using TySignalProcessing
using TyStatistics

Fs = 1000
FsSig = Fs
matfile1 = matread("sig1.mat")
sig1 = matfile1["sig1"]
matfile2 = matread("sig2.mat")
sig2 = matfile2["sig2"]

# 计算周期图
P1, f1 = periodogram(sig1, fs=FsSig, window=nothing, nfft=length(sig1))
P2, f2 = periodogram(sig2, fs=FsSig, window=nothing, nfft=length(sig2))
t = collect(0:length(sig1)-1) ./ FsSig;
figure(1)
subplot(2, 2, 1)
plot(t, sig1, color=:k)
ylabel("s1")
title("Time Series")
subplot(2, 2, 3)
plot(t, sig2)
ylabel("s2")
xlabel("Time (s)")
subplot(2, 2, 2)
plot(f1, P1, color=:k)
ylabel("P1")
title("Power Spectrum")
subplot(2, 2, 4)
plot(f2, P2)
ylabel("P2")
xlabel("Frequency (Hz)")

# Cxy, f = mscohere(sig1, sig2, [], [], [], Fs);
# # 计算互相关序列
# N = length(sig1) + length(sig2) - 1
# Rxy = TyStatistics.xcorr(sig1, sig2)

# # 计算互谱密度（CSD）
# Sxy = fft(Rxy, N)
# f = fftfreq(N, 1 / Fs)
# Cxy = abs.(Sxy) .^ 2 / (sum(abs.(sig1) .^ 2) * sum(abs.(sig2) .^ 2)) * (1 / (abs.(f) .* (2π)))

# # 计算相位
# Pxy = Sxy
# phase = -angle.(Pxy) ./ π * 180

# # 找到峰值
# function findpeaks(x, MinPeakHeight=0.75)
#     peaks = Int[]
#     locs = Float64[]
#     for i in 2:length(x)-1
#         if x[i] > MinPeakHeight && x[i] > x[i-1] && x[i] > x[i+1]
#             push!(peaks, x[i])
#             push!(locs, i)
#         end
#     end
#     return peaks, locs
# end
# pks, locs = findpeaks(Cxy, 0.75)


