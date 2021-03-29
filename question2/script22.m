[y,fs]=audioread('C:\Users\georg\Desktop\Askisi_1_2020_2021\speech.wav');
player = audioplayer(y,fs);
N = player.BitsPerSample;

yn = normalize(y);

% Calculate distortion of singal
Dyn =  mean(yn.^2);

% ------------------ N = 2 ------------------ %
[xq1,centers1,D1] = Lloyd_Max(yn,2,-1,1);

yq1 = centers1(xq1);
Dq1 = mean((yn-yq1).^2);

SQNR1 =Dyn/Dq1;
SQNR1db = 10 * log10(SQNR1);

% ------------------ N = 4 ------------------ %
[xq2,centers2,D2] = Lloyd_Max(yn,4,-1,1);

yq2 = centers2(xq2);
Dq2 = mean((yn-yq2).^2);

SQNR2 = Dyn/Dq2;
SQNR2db = 10 * log10(SQNR2);

% ------------------ N = 6 ------------------ %
[xq3,centers3,D3] = Lloyd_Max(yn,6,-1,1);

yq3 = centers3(xq3);
Dq3 = mean((yn-yq3).^2);


SQNR3 = Dyn/Dq3;
SQNR3db = 10 * log10(SQNR3);
