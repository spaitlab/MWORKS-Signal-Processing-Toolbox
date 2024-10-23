
Fs = 15;
Ts = 1/Fs;
ts = 0:Ts:1;
tl = range(0, stop=1, length=15);
sf = 1/(tl[2] - tl[1]);
TL = (0:length(tl)-1) ./ sf;
ErrorTL = maximum(abs.(tl .- TL))
lts = length(ts);
TS = range(ts[1], stop=ts[lts], length=lts);
ErrorTS = maximum(abs.(ts .- TS))
tcol = tl';
ttrans = ts';