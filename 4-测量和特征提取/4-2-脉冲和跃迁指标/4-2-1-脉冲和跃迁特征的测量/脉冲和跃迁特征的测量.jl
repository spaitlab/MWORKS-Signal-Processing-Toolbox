using TySignalProcessing
using TyPlot
using TyBase
using TyStatistics
# 绘制时钟信号
plot(time1, clock1)
xlabel("Time (seconds)")
ylabel("Voltage")
figure()
levelsdata, =statelevels(clock1;plotfig=true)
tightlayout()

figure()
# 绘制另一个时钟信号
plot(time2, clock2)
xlabel("Time (seconds)")
ylabel("Voltage")
figure()
overshoot(clock2[95:270], Fs; plotfig=true)
legend("Location", "NorthEast")
figure()
undershoot(clock2[95:270], Fs; plotfig=true )
legend("Location", "NorthEast")
figure()
pulsewidth(clock2, time2; plotfig=true)