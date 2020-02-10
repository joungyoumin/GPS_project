%% GPS CA code generation
% 2020. 02. 10. Joung

clear all ; clc ; close all ;

svid = randi([1,32]) ;
cacode = generateCAcode(svid) ;
SNR = -20; % signal to noise power ratio (unit dB), C/No = 44 dB-Hz
attn = sqrt(0.5*10^(-SNR/10)) ; % attenuation factor for AWGN
 

%% oversampling: x16

oversampleRate = 16 ;
sig = Data_Sampling(cacode, oversampleRate) ;
len = length(sig)/2 ;

%% AWGN

alpha = 0.5 ; %the power ratio of LOS and a MP signals
MPdelay = 0.5 ; % chip, Tc

tau = MPdelay * oversampleRate ; % samples
noise = attn*randn(1,len*2);


corr = ifft(fft(sig) .* conj(fft(sig))) ; 
tmp = circshift(corr, [1, len]) ;
tmp1 = alpha.*(circshift(tmp, [1, tau])) ;
rxSig = tmp + alpha.*(circshift(tmp, [1, tau])) + noise ;

chipRange = 2*oversampleRate ; %2Tc

figure ;
subplot(3,1,1) ; plot(tmp(len-chipRange:len+chipRange)) ;
subplot(3,1,2) ; plot(tmp1(len-chipRange:len+chipRange)) ;
subplot(3,1,3) ; plot(rxSig(len-chipRange:len+chipRange)) ;
