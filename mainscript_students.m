
%original signal
load signal_orig.mat   % Data file containing time domain marine mammal calls recorded underwater


disp('Load original input signal and plot signal in time-domain and its spectrogram')


fs=1600;                % sampling frequency
tau=1/fs;               % sampling interval
N=length(signal); 

t=(0:N-1)*tau;           % time-axis in seconds


% Plot time-domain original signal and its corresponding spectrogram in one
% plot.  First we plot the time-domain signal.
 
figure(1)
subplot(2,1,1)
plot(t,signal);
set(gca,'fontsize',18)
title('Input signal in the time-domain')
xlabel('time (seconds)');
ylabel('Amplitude');
xlim([0 t(end)]);
position_dim1=get(gca,'Position');   %Position of this subplot needed to line up with spectrogram

% Plot normalized spectrogram image of the original time-domain signal.  The
% spectrogram is obtained by running-average short-time Fourier transform.

subplot(2,1,2)
plot_spectrogram(signal,fs)
position_dim2=get(gca,'Position');
set(gca,'Position',[position_dim1(1) position_dim2(2) position_dim1(3) position_dim1(4)]);
title('Normalized Spectrogram of Input Signal');


%listen to the sound at normal speed

disp('Signal sound played at normal speed.')
output1=audioplayer(real(signal)/max(real(signal)), 1*fs, 24);   % this is 24 bit data
figure(1);
output1.play

disp('Spectrogram frequency axis goes up to 800 Hz.  You should zoom in around 20 Hz to see fin whale calls.')

disp('Hit space to continue ... ')


pause

%listen to the sound played at higher speed


disp('Signal sound played at 12 times the normal speed.')
output2=audioplayer(real(signal)/max(real(signal)), 12*fs, 24);   % this is 24 bit data
figure(1);
output2.play
ylim([0 400]);

disp('Zoom in spectrogram around 0-200 Hz to see fin whale calls.');


% Calculate the signal Fourier transform and magnitude spectrum in deciBels.  
% Apply the Matlab fft code to calculate the Fourier transform of the signal.
% The fftshift code is needed to shift the frequency axis so that it ranges from 
% -fs/2 to fs/2.

disp('Hit space to continue.')
pause

disp('Calculate Fourier transform of input signal and make Bode plot of input signal spectrum.')

signal_f1=fftshift(fft(signal))*tau;
df=fs/N;
f_vec=[0:N-1]*df-fs/2;
signal_spectrum=20*log10(abs(signal_f1));


% Bode plot (signal spectrum vs a log frequency axis)
figure(2)
pp=find(f_vec>0);
semilogx(f_vec(pp:end),signal_spectrum(pp:end),'linewidth',2);          
set(gca,'fontsize',18);
xlabel('Frequency, (Hz)');
ylabel('Magnitude Spectrum, (dB)');
title(['Bode Plot of Input Signal Magnitude Spectrum']);
grid on
xlim([5 fs/2]);
hold on
sp_max=max(signal_spectrum(pp:end));
ylim([sp_max-80 sp_max+10])

disp('Hit space to continue.')
pause
disp('Designing a Second order low pass filter to extract fin whale vocalizations')

%design filter(low pass filter with cutoff frequency 30Hz)
Nfilter=5                     %order of low pass filter
Omega_vec=f_vec*2*pi;           % frequency axis of filter frequency response function matches that for data Fourier transform
s=1j*Omega_vec;
R2=1000; 
R1=1000;
K=R2/R1;
f_hp=32.77721;                        % Desired frequency half power width of filter  
w_hp=2*pi*f_hp;                   
w_cl=32.77721;                      % cut-off frequency of first-order filter.  Need to change this value for higher-order filter. 
                                
HL1_f=(-K*w_cl)./(s+w_cl);        % unity gain first-order low-pass active filter frequency response function 

% Bode plot (filter frequency response magnitude vs a log frequency axis)  


figure(3)
semilogx(f_vec(pp:end),20*log10(abs(HL1_f(pp:end))),'linewidth',2);   % Bode plot of first order filter
ylim([-30 0])
set(gca,'fontsize',18);
xlabel('Frequency, (Hz)');
ylabel('Filter Frequency Response Function Magnitude, (dB)');
title(['Bode plot of Filter Magnitude Response Function']);
legend('fifth-order')
grid on
xlim([5 fs/2]);


pause
disp('Calculating output signal obtained via frequency domain analysis')

% Linear Systems Analysis in the frequency domain 
% Calculate output filtered signal.

Y1_f=signal_f1.*HL1_f';                     %output FT from first order filter
y1_t=real(ifft(ifftshift(Y1_f)))/tau;       % output signal using first order filter       


% Plot output filtered signal and compare to original signal. 

figure(4)
subplot(2,1,1)
plot(t,signal,'b','linewidth',2)
hold on;
plot(t,y1_t,'g','linewidth',2)
set(gca,'fontsize',18)
title('Filtered output signal compared to original input signal')
xlabel('time (seconds)');
ylabel('Amplitude');
xlim([0 t(end)]);
legend('original signal','fifth-order filtered output')

% Plot spectrogram image of the output filtered signal.  The
% spectrogram is obtained by running-average short-time Fourier transform.

subplot(2,1,2)
plot_spectrogram(y1_t,fs)
position_dim2=get(gca,'Position');
set(gca,'Position',[position_dim1(1) position_dim2(2) position_dim1(3) position_dim1(4)]);
position_dim1=get(gca,'Position');   %Position of this subplot needed to line up with spectrogram
title('Spectrogram of output from 5th-order filter');


% Bode plot (output filtered signal spectrum vs a log frequency axis)
figure(2)
semilogx(f_vec(pp:end),signal_spectrum(pp:end),'g','linewidth',2);          
set(gca,'fontsize',18);
hold on;
semilogx(f_vec(pp:end),20*log10(abs(Y1_f(pp:end))),'r','linewidth',2);          
set(gca,'fontsize',18);
hold off;
xlabel('Frequency, (Hz)');
ylabel('Filter Frequency Response Function Magnitude, (dB)');
title(['Bode Plot of Output Filtered and Original Input Signal Magnitude Spectra']);
legend('Input signal','Output signal');

disp('press space to continue.')
pause

%listen to the low-pass filtered output signal

disp('Listen to the first-order filtered output signal played 12 times faster.')
output3=audioplayer(real(y1_t)/max(real(y1_t)), 12*fs, 24);
figure(4)
ylim([0 400]);
output3.play


disp('Zoom in spectrogram around 0-200 Hz to see fin whale calls.');

disp('Compare Figure 4 filtered output signal spectrogram with Figure 1 original input signal spectrogram.');

disp('press space to continue ...');
pause

% Calculate and plot impulse response fuctions of filters.

disp('Calculating and plotting impulse response function of first order filter.')
hL1_t=real(fftshift(ifft(ifftshift(HL1_f))))/tau;

figure(5)
plot(t,hL1_t,'k','linewidth',2)
set(gca,'fontsize',18);
title('Impulse response function of filter')
xlabel('time (seconds)');
ylabel('Amplitude');
xlim([0 t(end)]);
legend('fifth-order filter')


disp('press space to continue ...');

pause

%Calculate and plot output filtered signal by time-domain convolution with
%low pass filter impulse response function

disp('LTI systems analysis in the time-domain via convolution.')

y1o_t=conv(signal,hL1_t,'same')*tau;    


figure(6)
plot(t,signal);
hold on;
plot(t,y1_t,'g');
plot(t,y1o_t,'k');
set(gca,'fontsize',18)
title('Filtered signal obtained via time-domain convolution')
xlabel('time (seconds)');
ylabel('Amplitude');
xlim([0 t(end)]);
legend('Input signal','output (frequency domain analysis)','output (from convolution)');

disp('The end.')
return;
