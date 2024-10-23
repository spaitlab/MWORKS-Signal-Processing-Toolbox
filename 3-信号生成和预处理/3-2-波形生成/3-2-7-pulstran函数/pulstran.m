T = 0:1/50e3:10e-3;
D = [0:1/1e3:10e-3;0.8.^(0:10)]';

Y = pulstran(T,D,'gauspuls',10e3,0.5);

plot(T,Y)