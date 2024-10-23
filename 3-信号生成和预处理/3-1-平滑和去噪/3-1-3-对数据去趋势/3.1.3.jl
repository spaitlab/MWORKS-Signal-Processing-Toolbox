using Statistics
using TyPlot
using TyMath
t = collect(1:length(ecgl))

subplot(2,2,1)
plot(t,ecgl)
title("ECG Signals with Trends");ylabel("Voltage (mV)")
subplot(2,2,3)
plot(t, ecgnl)
xlabel("sample");ylabel("Voltage (mV)")
dt_ecgl = detrend(ecgl)
opol = 6
p,s,mu  = polyfit(t, ecgnl[:, 1], opol;normalize=true)
f_y = polyval(p,t,[],mu);

dt_ecgnl = ecgnl.- f_y

subplot(2,2,2)
plot(t, dt_ecgl)
title("Detrended ECG Signals")
subplot(2,2,4)
plot(t, dt_ecgnl)
xlabel("sample")