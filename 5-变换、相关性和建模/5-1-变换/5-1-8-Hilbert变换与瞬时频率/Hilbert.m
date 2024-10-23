fs = 1e4;
t = (0:1/fs:1);
x = 2.5 + cos(2 * pi * 203 * t) + sin(2 * pi * 721 * t) + cos(2 * pi * 1001 * t);
y = hilbert(x);
plot(t, real(y), t, imag(y));
xlim([0.01 0.03]);
legend("real", "imaginary");
title("hilbert Function");
xlabel("Time (s)");
