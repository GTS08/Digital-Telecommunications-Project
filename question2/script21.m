% Create the input signal
M = 10000;
t = (randn(M,1)+j*randn(M,1))/sqrt(2);
x = abs(t) .^ 2;

% Calculate distortion of singal
Dx = mean(x.^2);

% Quantize the signal with N = 4
[xq1,centers1] = my_quantizer(x, 4, 0, 4);
yq1 = centers1(xq1);

% Calculate distortion of noise
Dxq1 = mean((x-yq1).^2);

% Calculate SQNR
SQNR1 = Dx / Dxq1;
SQNR1db = 10 * log10(SQNR1);

% Quantize the signal with N = 6
[xq2,centers2] = my_quantizer(x, 6, 0, 4);
yq2 = centers2(xq2);

% Calculate distortion of noise
Dxq2 = mean((x - yq2).^2);

% Calculate SQNR
SQNR2 = Dx / Dxq2;
SQNR2db = 10 * log10(SQNR2);

% Calculate distortion overload probability
p = length(x(x<0 | x>4)) / length(x);
