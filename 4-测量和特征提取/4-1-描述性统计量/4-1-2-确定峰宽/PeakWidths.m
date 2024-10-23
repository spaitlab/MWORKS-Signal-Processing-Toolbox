%Determine Peak Widths
%Create a signal that consists of a sum of bell curves. Specify the location, height, and width of each curve.
x = linspace(0,1,1000);

Pos = [1 2 3 5 7 8]/10;
Hgt = [4 4 2 2 2 3];
Wdt = [3 8 4 3 4 6]/100;

for n = 1:length(Pos)
    Gauss(n,:) =  Hgt(n)*exp(-((x - Pos(n))/Wdt(n)).^2);
end

PeakSig = sum(Gauss);

%Plot the individual curves and their sum.
plot(x,Gauss,'--',x,PeakSig)
grid

%Measure the widths of the peaks using the half prominence as reference.
findpeaks(PeakSig,x,'Annotate','extents')

%Measure the widths again, this time using the half height as reference.
findpeaks(PeakSig,x,'Annotate','extents','WidthReference','halfheight')
title('Signal Peak Widths')
