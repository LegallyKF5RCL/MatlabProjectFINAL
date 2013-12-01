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
Samples = 80000;
Amp = 1;
Fqs = [697 770 852 941 1209 1336 1477 1633];
Time = .02;
SampTime = Time * Samples;


%make matricies
%Sinusoids = zeros(Wav, SampTime);
Sinusoid1 = zeros(1, SampTime);
Sinusoid2 = zeros(1, SampTime);
%FinalWave = zeros(1, SampTime);
X = linspace(0, Time, SampTime);


for i = 1:SampTime
    Sinusoid1(1,i) = sin(2 * pi * 697 * X(i));
end
for i = 1:SampTime
    Sinusoid2(1,i) = sin(2 * pi * 1209 * X(i));
end

FinalWave = Sinusoid1 + Sinusoid2;


AWGN_FinalWave1 = awgn(FinalWave, 40);
AWGN_FinalWave2 = awgn(FinalWave, -20);

%plot(X, AWGN_FinalWave2);
%figure;

FreqIndecies = round(Fqs / Samples * SampTime + 1);
%FreqIndecies = round(FreqIndecies * Samples / SampTime);

%FrewIndecies = Fqs + 1;

GoGoGoertzel = goertzel(FinalWave, FreqIndecies);
stem(Fqs, abs(GoGoGoertzel));
figure;


GoGoGoertzel = goertzel(AWGN_FinalWave1, FreqIndecies);
stem(Fqs, abs(GoGoGoertzel));
figure;

GoGoGoertzel = goertzel(AWGN_FinalWave2, FreqIndecies);
stem(Fqs, abs(GoGoGoertzel));










