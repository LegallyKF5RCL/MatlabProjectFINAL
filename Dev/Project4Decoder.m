

%clear all
close all
clc


%Data = load('EncodedMessage.txt'); %load message
Data = Signal;

%information needed for decoding


Samples = 8000;              %sampling frequency 
Time = .02;                  %time in seconds alloted for each bit
SampTime = Samples*Time;     %ratio of samples to 1 second
TotalLen = length(Data);
Fqs = [697 770 852 941 1209 1336 1477 1633];    %the frequencies
FreqIndecies = round(Fqs / Samples * SampTime + 1);

TToneTable = ['1', '2', '3', 'A';
                '4', '5', '6', 'B';
                '7', '8', '9', 'C';
                'E', '0', 'F', 'D'];

PositionCounter = 0;
IterationCounter = 1;
DelayPoints = 0;
ArbCounter = 1;
RowCounter = 1;

%find when the signal starts
for i = 1:TotalLen
    if Data(1, i) > 1.6     %when the signal starts
        %PositionCounter = i;    
        DelayPoints = i;    %record the position we are in
        break               %leave loop
    end
end

%make data readable
for ii = 1:(TotalLen - DelayPoints)
    %take away the delay
    OrganizedData(RowCounter, ArbCounter) = Data(1, ii + DelayPoints);
    ArbCounter = ArbCounter + 1;    %begin counting
    if mod(ArbCounter - 1, 160) == 0
        ArbCounter = 1;
        RowCounter = RowCounter + 1;
    end
end

SizeOrgRow = size(OrganizedData);
SizeOrgCol = size(OrganizedData);

SizeOrgRow = SizeOrgRow(1,1);
SizeOrgCol = SizeOrgCol(1,2);

SizeFreqs = size(Fqs);
SizeFreqs = SizeFreqs(1,2);

GoGoGoertzel = zeros([SizeOrgRow, SizeFreqs]);
IndexMatrix = zeros([SizeOrgRow, 2]);

for j = 1:SizeOrgRow
    GoGoGoertzel(j,1:SizeFreqs) = abs(goertzel(OrganizedData(j,1:SizeOrgCol), FreqIndecies));
    [MaximumIndex1, Index1] = max(GoGoGoertzel(j, 1:4));
    [MaximumIndex2, Index2] = max(GoGoGoertzel(j, 5:8));
    IndexMatrix(j, 1:2) = [Index1, Index2];
end

for h = 1:SizeOrgRow
    F(1, h) = TToneTable(IndexMatrix(h,1),IndexMatrix(h,2));
end

Final = reshape(F,2,h/2);
Final = Final';
HexTwoDec = hex2dec(Final);
Print = char(HexTwoDec);

disp('~~~~~~~');
disp(Print');
disp('~~~~~~~');

disp('Finished...');