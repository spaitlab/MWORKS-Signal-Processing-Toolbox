using MAT
# using Plots
using TyPlot
using TySignalProcessing
using TyMath

# Load data from the bostemp.mat file
matfile = matread("bostemp.mat")
tempC = matfile["tempC"]

# 数据读取
days = collect(1:31*24) ./ 24

# Plot the original temperature data
figure(1)
TyPlot.plot(days, tempC)
xlabel("Time elapsed from Jan 1, 2011 (days)")
ylabel("Temp (°C)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

# 一种移动平均滤波器
hoursPerDay = 24;
b = (1 / hoursPerDay) * ones(1, hoursPerDay);
a = 1;
# y1, y2 = filter1(b', a, tempC)
y1, y2 = filter1(b', a, tempC)

figure(2)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days, y1)
legend(["Hourly Temp", "24 Hour Average (delayed)"])
ylabel("Temp(°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

# 滤波器延迟
avg24hTempC = smooth(tempC, hoursPerDay);
fDelay = (hoursPerDay - 1) ./ 2;
figure(3)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days .- (fDelay / 24), avg24hTempC)
ylabel("Temp (°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")
legend(["Hourly Temp", "24 Hour Average"])

# 提取平均差异
hours = collect(1:24)
deltaTempC = tempC - avg24hTempC
deltaTempC = reshape(deltaTempC, 24, 31)'

meanDeltaTempC = mean(deltaTempC, dims=1)'
figure(4)
TyPlot.plot(hours, meanDeltaTempC)
ylabel("Temperature difference (°C)")
xlabel("Hour of day (since midnight)")
title("Mean temperature differential from 24 hour average")

# 提取峰值包络
envHigh, envLow = envelope(tempC, 20, "peak")
envMean = (envHigh + envLow) / 2
figure(5)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days, envHigh)
hold("on")
TyPlot.plot(days, envMean)
hold("on")
TyPlot.plot(days, envLow)
legend("Hourly Temp", "High", "Mean", "Low")
ylabel("Temp(°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

# 加权移动平均滤波器
h = [1 / 2, 1 / 2];
binomialCoeff = TyMath.conv(h, h);
for n = 1:4
    global binomialCoeff = TyMath.conv(binomialCoeff, h)
end
fDelay = (length(binomialCoeff) - 1) / 2;
y3, y4 = filter1(binomialCoeff, a, tempC)
figure(6)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days .- fDelay / 24, y3)
legend("Hourly Temp", "Binomial Weighted Average")
ylabel("Temp(°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

alpha = 0.45;
y5, y6 = filter1(alpha, [1 alpha - 1], tempC);
figure(7)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days .- fDelay / 24, y3)
hold("on")
TyPlot.plot(days .- 1 / 24, y5)
legend("Hourly Temp", "Binomial Weighted Average", "Exponential Weighted Average")
ylabel("Temp(°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

alpha = 0.45;
y5, y6 = filter1(alpha, [1 alpha - 1], tempC);
figure(8)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days .- fDelay / 24, y3)
hold("on")
TyPlot.plot(days .- 1 / 24, y5)
axis([3 4 -5 2])
legend("Hourly Temp", "Binomial Weighted Average", "Exponential Weighted Average")
ylabel("Temp(°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

# 萨维茨基-戈雷滤波器
cubicMA = sgolayfilt(tempC, 3, 7);
quarticMA = sgolayfilt(tempC, 4, 7);
quinticMA = sgolayfilt(tempC, 5, 9);

figure(9)
TyPlot.plot(days, tempC)
hold("on")
TyPlot.plot(days, cubicMA)
hold("on")
TyPlot.plot(days, quarticMA)
hold("on")
TyPlot.plot(days, quinticMA)
axis([3 5 -5 2])
legend("Hourly Temp", "Cubic-Weighted MA", "Quartic-Weighted MA", "Quintic-Weighted MA")
ylabel("Temp(°C)")
xlabel("Time elapsed from Jan 1, 2011 (days)")
title("Logan Airport Dry Bulb Temperature (source: NOAA)")

# 重采样
matfile1 = matread("openloop60hertz.mat")
openLoopVoltage = matfile1["openLoopVoltage"]

fs = 1000;
t = (0:length(openLoopVoltage)-1) / fs;
figure(10)
TyPlot.plot(t, openLoopVoltage)
ylabel("Voltage (V)")
xlabel("Time (s)")
title("Open-loop Voltage Measurement")

figure(11)
TyPlot.plot(t, sgolayfilt(openLoopVoltage, 1, 17))
ylabel("Voltage (V)")
xlabel("Time (s)")
title("Open-loop Voltage Measurement")
legend("Moving average filter operating at 58.82 Hz")

fsResamp = 1020;
vResamp, = resample(openLoopVoltage, fsResamp, fs)
tResamp = (0:length(vResamp)-1) / fsResamp;
vAvgResamp = sgolayfilt(vResamp, 1, 17);
figure(12)
plot(tResamp, vAvgResamp)
ylabel("Voltage (V)")
xlabel("Time (s)")
title("Open-loop Voltage Measurement")
legend("Moving average filter operating at 60 Hz")

# 中位数滤波器
matfile = matread("x.mat")
x = matfile["x"]
matfile = matread("t1.mat")
t = matfile["t"]
yMovingAverage = TyMath.conv(vec(x), ones(5) ./ 5, "same")
ySavitzkyGolay = sgolayfilt(x, 3, 5)
figure(13)
TyPlot.plot(t, x)
hold("on")
TyPlot.plot(t, yMovingAverage)
hold("on")
TyPlot.plot(t, ySavitzkyGolay)
legend(["original signal", "moving average", "Savitzky-Golay"])

yMedFilt = medfilt1(x, 5)
figure(14)
TyPlot.plot(t, x)
hold("on")
TyPlot.plot(t, yMedFilt)
legend(["original signal", "Median filter"])

# 通过汉佩尔滤波器去除离群值
matfile2 = matread("y.mat")
y = matfile2["y"]
y[1:400:end] .= 2.1;
figure(15)
plot(y)

figure(16)
plot(y)
hold("on")
plot(medfilt1(y, 3))
legend("original signal", "filtered signal")


Hampely, = hampel(y, 13)
figure(17)
plot(y, "*-")
hold("on")
plot(Hampely)
legend("original signal", "filtered signal")


