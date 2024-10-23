using DelimitedFiles
using Statistics
using MAT 
using Random
using TyPlot

# Load openloop60hertz data
mat_contents = matread("openloop60hertz.mat") 
openLoopVoltage = mat_contents["openLoopVoltage"] 

fs = 1000
t = (0:size(openLoopVoltage, 1) - 1) / fs

Random.seed!(123) # Set random seed for reproducibility

spikeSignal = zeros(size(openLoopVoltage))
spks = 10:100:1990
spikeSignal[spks .+ round.(Int, 2 .* randn(length(spks)))] .= sign.(randn(length(spks)))

noisyLoopVoltage = openLoopVoltage .+ spikeSignal

figure()
plot(t, noisyLoopVoltage)
xlabel("Time (s)")
ylabel("Voltage (V)")
title("Open-Loop Voltage with Added Spikes")
yax = ylim()

medfiltLoopVoltage = medfilt1(noisyLoopVoltage, 3)
figure()
plot(t, medfiltLoopVoltage)
xlabel("Time (s)")
ylabel("Voltage (V)")
title("Open-Loop Voltage After Median Filtering")
ylim(yax)
grid(true)
