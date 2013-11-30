%{
EE-2347 Project 3 ENCODER
Contributers: Brian McRee, Jacob Sanchez
10/13/2013

Published open-source on Git: LegallyKF5RCL/MatlabProject3
%}

clc;
clear all;
close all;

Message = input('Input Message (must not be all numbers): ', 's');    %prompt user for input   

%initialize
BinaryCharacters = dec2hex(Message);    %convert to hex
StringLen = size(BinaryCharacters);   %find how many characters we have
StringLen = StringLen(1,1);
CharLen = 2;                            %length of char will always be 7
TotalLen =StringLen * CharLen;         %total amount of 

%make a cosgle array for the message
BinaryMessage = int8(zeros([StringLen,CharLen]));   
%rearrange things
for i = 1:StringLen
    for j = 1:CharLen
            BinaryMessage(i, j) = int8(BinaryCharacters(i,j));
    end
end

%define variables and constants
Freq = 8000000;              %sampling frequency (2.5x max expected freq)
BitLength = .001;                   %time in seconds alloted for each bit
Fs = BitLength*Freq;        %ratio of samples to 1 second

%make matricies...
AxisX = linspace(-Fs/2, Fs/2, Fs);  %variable for plotting the frequency domain
X = linspace(0,BitLength,Fs);       %create time domain
Y = zeros([TotalLen,Fs]);                           %create a zero matrix for the signals
%DecodedMessage = zeros([TotalLen,Fs]);              %create a zero matrix for decoding the message
%DecodedBinary = int8(zeros([StringLen,CharLen]));   %create a zero matrix for the bits after the message is decoded

WaveSynthTime = tic();              %start encoding clock
%frequencies
f1 = 1209+697; %f for 1
f2 = 1336+697; %f for 2
f3 = 1477+697; %f for 3
f4 = 1633+697; %f for A
f5 = 1209+770; %f for 4
f6 = 1336+770; %f for 5
f7 = 1477+770; %f for 6
f8 = 1633+770; %f for B
f9 = 1209+852; %f for 7
f10= 1336+852; %f for 8
f11= 1477+852; %f for 9
f12= 1633+852; %f for C
f13= 1209+941; %f for *
f14= 1336+941; %f for 0
f16= 1477+941; %f for #
f17= 1633+941; %f for D

for q = 1:StringLen                     %for each row
    for h = 1:CharLen                   %for each value in the row
        if BinaryMessage(q,h) == 48     %if it is equal to 48
           for k = 1:Fs                 
               %write the value as a f1 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f1*2*pi*X(k));
           end
        elseif BinaryMessage(q,h) == 49;
           for k = 1:Fs
               %write the value as a f2 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f2*2*pi*X(k));
           end
        elseif BinaryMessage(q,h) == 50;
           for k = 1:Fs
               %write the value as a f3 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f3*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 51;
           for k = 1:Fs
               %write the value as a f4 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f4*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 52;
           for k = 1:Fs
               %write the value as a f5 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f5*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 53;
           for k = 1:Fs
               %write the value as a f6 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f6*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 54;
           for k = 1:Fs
               %write the value as a f7 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f7*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 55;
           for k = 1:Fs
               %write the value as a f8 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f8*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 56;
           for k = 1:Fs
               %write the value as a f9 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f9*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 57;
           for k = 1:Fs
               %write the value as a f10 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f10*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 65;
           for k = 1:Fs
               %write the value as a f11 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f11*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 66;
           for k = 1:Fs
               %write the value as a f12 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f12*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 67;
           for k = 1:Fs
               %write the value as a f13 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f13*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 68;
           for k = 1:Fs
               %write the value as a f14 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f14*2*pi*X(k));
           end
         elseif BinaryMessage(q,h) == 69;
           for k = 1:Fs
               %write the value as a f15 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f16*2*pi*X(k));
           end
        else
           for k = 1:Fs
               %write the value as a f16 cosine wave
               Y(((q - 1) * CharLen + h),k) = cos(f17*2*pi*X(k));
           end
        end
    end
end

%output time
WaveSynthTimeElapsed = toc(WaveSynthTime);      %stop encoding clock
disp('Time encoding:');                         %print time taken to encode
disp(WaveSynthTimeElapsed); %print time taken to encode

A=reshape(Y',1,Fs*TotalLen);
save('EncodedMessage.txt', 'A', '-ascii');      

disp('Finished...');