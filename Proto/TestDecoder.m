%{
EE-2347 Project 4 TestDecoder
Contributers: Brian McRee
11/30/2013

Published open-source on Git: LegallyKF5RCL/MatlabProjectFINAL
%}

clc;
clear all;
close all;

%initialize
Wav = 2;
Samples = 8000;
Amp = 1;
Fqs = [697, 1209];
Time = .020;
SampTime = Time * Samples;


%make matricies
Sinusoids = zeros(Wav, SampTime);
FinalWave = zeros(1, SampTime);
X = linspace(0, Time, SampTime);

for n = 1:Wav
    for i = 1:SampTime
        Sinusoids(n,i) = sin(2 * pi * Fqs(n) * X(i));
    end
end

for j = 1:Wav
    FinalWave = FinalWave + Sinusoids(j, 1:SampTime);
end

plot(X, FinalWave);
