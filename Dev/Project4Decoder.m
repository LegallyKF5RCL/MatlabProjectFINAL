clear all
close all
clc


Encodedmessage = load('EncodedMessage.txt'); %load message

%information needed for decoding


Freq = 8000000;              %sampling frequency 
BitLength = .001;                   %time in seconds alloted for each bit
Fs = BitLength*Freq;        %ratio of samples to 1 second
TotalLen = length(Encodedmessage)/Fs;

Y = reshape(Encodedmessage,TotalLen,Fs);
CharLen = 2;                            %length of char will always be 7
StringLen = TotalLen/CharLen;


%make matricies...
AxisX = linspace(-Fs/2, Fs/2, Fs);              %variable for plotting the frequency domain
X = linspace(0,BitLength,Fs);                   %create time domain
%Y = zeros([TotalLen,Fs]);                          %create a zero matrix for the signals
DecodedMessage = zeros([TotalLen,Fs]);              %create a zero matrix for decoding the message
DecodedBinary = int8(zeros([StringLen,CharLen]));   %create a zero matrix for the bits after the message is decoded

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


%begin decoding
DecodeTime = tic();         %start decode clock
for w = 1:StringLen         
    for d = 1:CharLen
        DecodedMessage(((w - 1) * CharLen + d), 1:Fs) = fft(Y(((w - 1) * CharLen + d), 1:Fs));                      %get the frequency domain
        DecodedMessage(((w - 1) * CharLen + d), 1:Fs) = fftshift(DecodedMessage(((w - 1) * CharLen + d), 1:Fs));    %shift it to where 0Hz is at center
        Magnitude = abs(DecodedMessage(((w - 1) * CharLen + d),1:Fs)).^2;                     %find the magnitudes of the freq components
        [MaximumIndex, Index] = max(Magnitude(Fs/2+2:Fs));              %find the index value where the maximum magnitude is
        %NOTE: this accounts for positive frequencies and offsets by two
        %for the zero frequency and the "sum" which apparently is part of fft()    
        if Index == f1                   %if the freq is 20k (with respect to 1ms)
            DecodedBinary(w, d) = 48;       %its a 0
        elseif Index == f2                   
            DecodedBinary(w, d) = 49;       %its a 1
        elseif Index == f3                   
            DecodedBinary(w, d) = 50;       %its a 2
        elseif Index == f4                   
            DecodedBinary(w, d) = 51;       %its a 3
        elseif Index == f5                   
            DecodedBinary(w, d) = 52;       %its a 4
        elseif Index == f6                   
            DecodedBinary(w, d) = 53;       %its a 5
        elseif Index == f7                   
            DecodedBinary(w, d) = 54;       %its a 6
        elseif Index == f8                   
            DecodedBinary(w, d) = 55;       %its a 7
        elseif Index == f9                   
            DecodedBinary(w, d) = 56;       %its a 8
        elseif Index == f10                   
            DecodedBinary(w, d) = 57;       %its a 9
        elseif Index == f11                   
            DecodedBinary(w, d) = 65;       %its a A
        elseif Index == f12                   
            DecodedBinary(w, d) = 66;       %its a B
        elseif Index == f13                   
            DecodedBinary(w, d) = 67;       %its a C
        elseif Index == f14                   
            DecodedBinary(w, d) = 68;       %its a D
        elseif Index == f16                   
            DecodedBinary(w, d) = 69;       %its a E
        else                 
            DecodedBinary(w, d) = 70;       %its a F
        end
    end
end

DecodeTimeElapsed = toc(DecodeTime);        %stop decode clock
disp('Time decoding:');                     %print
disp(DecodeTimeElapsed);                    %print the time

for ii = 1:StringLen                        %for each row
    for jj = 1:CharLen                      %for each bit in the row
         if DecodedBinary(ii,jj) == 48      %if that bit is a decimal 48
            A(ii,jj) = 0;                   %set the bit as a 0
         elseif DecodedBinary(ii,jj) == 49                                
            A(ii,jj) = 1;                   %set the bit as a 1
         elseif DecodedBinary(ii,jj) == 50                                
            A(ii,jj) = 2;                   %set the bit as a 2
         elseif DecodedBinary(ii,jj) == 51                                
            A(ii,jj) = 3;                   %set the bit as a 3
         elseif DecodedBinary(ii,jj) == 52                                
            A(ii,jj) = 4;                   %set the bit as a 4
         elseif DecodedBinary(ii,jj) == 53                                
            A(ii,jj) = 5;                   %set the bit as a 5
         elseif DecodedBinary(ii,jj) == 54                                
            A(ii,jj) = 6;                   %set the bit as a 6
         elseif DecodedBinary(ii,jj) == 55                                
            A(ii,jj) = 7;                   %set the bit as a 7
         elseif DecodedBinary(ii,jj) == 56                                
            A(ii,jj) = 8;                   %set the bit as a 8
         elseif DecodedBinary(ii,jj) == 57                                
            A(ii,jj) = 9;                   %set the bit as a 9
         elseif DecodedBinary(ii,jj) == 65                                
            A(ii,jj) = A;                   %set the bit as a A
         elseif DecodedBinary(ii,jj) == 66                                
            A(ii,jj) = B;                   %set the bit as a B
         elseif DecodedBinary(ii,jj) == 67                                
            A(ii,jj) = C;                   %set the bit as a C
         elseif DecodedBinary(ii,jj) == 68                                
            A(ii,jj) = D;                   %set the bit as a D
         elseif DecodedBinary(ii,jj) == 69                                
            A(ii,jj) = E;                   %set the bit as a E
         elseif DecodedBinary(ii,jj) == 70                                
            A(ii,jj) = F;                   %set the bit as a F
         end
    end
end

for kk = 1:StringLen                        %loop through everything
    for asdf = 1:CharLen
        B(kk,asdf) = dec2bin(A(kk,asdf));   %convert the decimals to a binary sequence
    end
end
B = hex2dec(B);     %convert the binary sequence into a decimal number that represents the message character

disp('~~~~~');
disp(char(B'));
disp('~~~~~');

disp('Finished...');