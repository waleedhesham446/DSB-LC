clc ;
close all;
clear all;


% ----------signal in time domain ------------------
  [audioSignal,fs] = audioread('audio.wav');
  audioSignal = audioSignal(:,1);
  t = 1/fs;
  n= length(audioSignal);
  time = linspace(0, (n/fs) , n);

  plot(time,audioSignal); 
  xlabel('time in Sec'); 
  ylabel('singal');
  title('signal in time domain ');
  sound(audioSignal,fs);

% ------------signal amblitude in freq Domain --------------
  Freq_signal = fftshift(fft(audioSignal,n));
  freq = linspace(-fs/2,fs/2,n);
  amblitude = abs(Freq_signal);
  figure
  plot(freq(1:n),amblitude(1:n));
  xlabel('Frequency');
  ylabel('Amplitude');
  title('signal Amblitude in Freq Domain');

% -----------signal phase in  freq Domain ------------
  phase = angle(Freq_signal);
  figure
  plot(freq(1:n/2),phase(1:n/2));  
  xlabel('Frequency');
  ylabel('Phase');
  title('Singal phase in freq domain');
% ----------- Modulated signal ----------------

  omega = 2*pi*10000;
  carrier= cos(omega * time );
  Ac = max(abs(audioSignal));
  modulated_signal = (Ac + audioSignal)'.*carrier;
  figure
  plot (time, modulated_signal); 
  xlabel('Seconds'); 
  ylabel('Amplitude Modulated');
  title('modulated_signal in time domain');

% -------modulated_signal amblitude in freq domain-----------
  
  modulated_freq_signal = fftshift(fft(modulated_signal,n));
  modulated_amblitude = abs(modulated_freq_signal); 
  figure;
  plot(freq(1:n),modulated_amblitude(1:n));    
  xlabel('Frequency');
  ylabel('modulated_signal amblitude');
  title('modulated_amblitude')


% -------modulated_signal phase in freq domain-----------

  modulated_phase = angle(modulated_freq_signal);
  figure;
  plot(freq(1:n),modulated_phase(1:n));   
  xlabel('Frequency');
  ylabel('Phase Modulated');
  title('modulated_phase');
  
% ------- demodulation -----------
  %pkg load signal
  demodulated_signal = modulated_signal.* carrier;
  order = 40; 
  Wc = 20 / 44;
  [b,a] = butter(order, Wc); 
  filtered_signal = filter(b,a, demodulated_signal);  
  final_signal = 2*filtered_signal - Ac ; 


  figure
  plot(time,final_signal);
  xlabel('Seconds');
  ylabel('Amplitude Demodulated');
  title('final signal');
  sound(final_signal,fs);
% ------- demodulated signal freq -----------
  demodulated_freq_singal =fftshift(fft(final_signal,n));
  demodulated_amblitude   =abs(demodulated_freq_singal); 
  figure
  plot(freq(1:n),demodulated_amblitude(1:n));    
  xlabel('Frequency');
  ylabel('Amplitude Demodulated');
  title('demodulated amblitude');
  
% ------- demodulated signal phase -----------
  demodulated_phase = angle(final_signal); 
  figure
  plot(freq(1:n),demodulated_phase(1:n)); 
  xlabel('Frequency');
  ylabel('Phase Demodulated');
  title('demodulated_phase');