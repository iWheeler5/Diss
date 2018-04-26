
A = imread('mdb001.pgm');

[pixelCounts, GLs] = imhist(A);
NM = sum(pixelCounts); 


meanGL = sum(GLs .* (pixelCounts/NM));

varresult = 0; %temp varaible for variance
skewresult = 0; %temp variable for skewness
kurtresult = 0; %temp variable for kurtosis

for i = 0:1:length(pixelCounts) - 1
    varresult = varresult + (i - meanGL)^2 * (pixelCounts(i + 1)/NM);
    skewresult = skewresult + (i-meanGL)^3 * (pixelCounts(i+1)/NM);
    kurtresult = kurtresult + (i-meanGL)^4 * (pixelCounts(i+1)/NM)-3;
end

skewresult = skewresult * varresult ^-3; %calculates skewness
kurtresult = kurtresult * varresult ^-4; %calculates kurtosis

%energy
energy = sum((pixelCounts /NM) .^2);

%entropy
pI = pixelCounts / NM;
entropy1 = -sum(pI(pI~=0).*log2(pI(pI~=0)));

result = [meanGL, varresult, skewresult, kurtresult, energy, entropy1];

[LoD,HiD] = wfilters('haar','d');

[cA,cH,cV,cD] = dwt2(A,LoD,HiD,'mode','symh');
subplot(2,2,1)
imagesc(cA)
colormap gray
title('Approximation')
subplot(2,2,2)
imagesc(cH)
colormap gray
title('Horizontal')
subplot(2,2,3)
imagesc(cV)
colormap gray
title('Vertical')
subplot(2,2,4)
imagesc(cD)
colormap gray
title('Diagonal')

