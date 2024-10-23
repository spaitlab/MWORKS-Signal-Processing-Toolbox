using TySignalProcessing
using TyPlot
using TyMath
fs = 1e9
t = 0:1/1e9:4e-5
d = 0:4e-6:4e-5
x = rectpuls(t, 2e-6)
y = pulstran(t, d, x, fs)
figure(1)
plot(t, y)
axis([0 4e-5 -0.5 1.5])


nwid = 3;

for nn = 1:nwid
    local x = rectpuls(t, nn * 2e-6)
    local y = pulstran(t, d, x, fs)

    figure(2)
    subplot(nwid, 1, nn)
    plot(t, y)
    axis([0 4e-5 -0.5 1.5])

    D, = dutycycle(y, fs)
    duty_cycle = mean(D)
    title("Duty cycle is $(round(mean(D),digits=2))")
end


