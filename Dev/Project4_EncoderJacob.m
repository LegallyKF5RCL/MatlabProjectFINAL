clc;
clear all;
close all;


%$%$% asking for the input 
Message = input('Input Message here: ', 's');
NoiseLevel = input('Input signal to noise ratio in dB: ');
UserDelay = input('Input delay time: ');

%%$%$% defining frequency sample and time
Freq = 8000;
BitTime = .02;
Fs= Freq*BitTime;
%t = (0:Fs-1)/Fs;
t = linspace(0,BitTime, Fs);

%%%% changing from decimal to hex
%%%% and finding the deminsions 
HexCharacters = dec2hex(Message);
StringLen = size(HexCharacters);
StringLen = StringLen(1,1);
CharLen = 2;
TotalLen = StringLen * CharLen;


%%%% variables for delay and noise introduced into the signal%%%$$$%
x=NoiseLevel;
delayTime= 8 * UserDelay;
delay = zeros(1,delayTime);
NoiseV = 1/(10^(x/20));
noise = NoiseV*rand(1,Fs*TotalLen+delayTime);


%%% assigning the values for the duel tone 
Frow = [697,770,852,941];
Fcol = [1209,1336,1477,1633];
f = [];
%%%% making a matrix with the frequencies so each colum has 
%%%% two frequencies.
for i = 1:4;
    for w = 1:4;
        f = [ f [Frow(i);Fcol(w)] ];
        
    end
end



%%%% making a matrix of each duel tone freqency in their own row

for iii = 1:16
    for jjj = 1:Fs
        TONES(iii,1:jjj) = cos(2 * pi * f(1,iii) * t(1,1:jjj)) + cos(2 * pi * f(2,iii) * t(1,1:jjj));   
    end
end



%%%% assignes a cosine wave for each character of the HexCharacters
for q = 1:StringLen                     %for each row
    for h = 1:CharLen                   %for each value in the row
        if HexCharacters(q,h) == '1';
            Y(((q - 1) * CharLen + h),:) = TONES(1,:);
        elseif HexCharacters(q,h) == '2';
            Y(((q - 1) * CharLen + h),:) = TONES(2,:);
        elseif HexCharacters(q,h) == '3';
            Y(((q - 1) * CharLen + h),:) = TONES(3,:);            
        elseif HexCharacters(q,h) == 'A';
            Y(((q - 1) * CharLen + h),:) = TONES(4,:);
        elseif HexCharacters(q,h) == '4';
            Y(((q - 1) * CharLen + h),:) = TONES(5,:);
        elseif HexCharacters(q,h) == '5';
            Y(((q - 1) * CharLen + h),:) = TONES(6,:);
        elseif HexCharacters(q,h) == '6';
            Y(((q - 1) * CharLen + h),:) = TONES(7,:);
        elseif HexCharacters(q,h) == 'B';
            Y(((q - 1) * CharLen + h),:) = TONES(8,:);        
        elseif HexCharacters(q,h) == '7';
            Y(((q - 1) * CharLen + h),:) = TONES(9,:);
        elseif HexCharacters(q,h) == '8';
            Y(((q - 1) * CharLen + h),:) = TONES(10,:);
        elseif HexCharacters(q,h) == '9';
            Y(((q - 1) * CharLen + h),:) = TONES(11,:);
        elseif HexCharacters(q,h) == 'C';
            Y(((q - 1) * CharLen + h),:) = TONES(12,:);
        elseif HexCharacters(q,h) == 'E';
            Y(((q - 1) * CharLen + h),:) = TONES(13,:);
        elseif HexCharacters(q,h) == '0';
            Y(((q - 1) * CharLen + h),:) = TONES(14,:);
        elseif HexCharacters(q,h) == 'F'; 
            Y(((q - 1) * CharLen + h),:) = TONES(15,:);
        else
            Y(((q - 1) * CharLen + h),:) = TONES(16,:);
        end
    end
end
% reshapes the matrix into one long array 
Y = reshape(Y',1,Fs*TotalLen);
Y=cat(2,delay,Y);  % adds the delay to the beginning
Y=(Y+noise);       % adds the noise into the signal
Signal = Y;        % the signal that is passed

plot(Signal);
%figure;
