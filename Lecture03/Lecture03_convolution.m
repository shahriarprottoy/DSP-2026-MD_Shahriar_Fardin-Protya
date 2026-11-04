%% Lecture 03 - Signal Operations, Convolution and Moving-Average Filtering
% Author: MD Shahriar Fardin Protya
% Course: Digital Signal Processing, Savonia UAS

clear;
close all;
clc;

% Use the same random noise each time
rng(1);

%% Create a clean discrete-time signal

n = 0:100;
clean = sin(0.1*pi*n);          % Period = 20 samples

%% Add noise

noise = 0.4*randn(size(n));
measured = clean + noise;

%% Display the clean and noisy signals

figure;

plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);

grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Clean and Noisy Signals');
legend('Clean Signal','Noisy Signal');

%% Task 1: Amplitude scaling + Task 2: Signal delay
% Both signal operations are shown in one figure (two subplots),
% saved as signal_operations.png

% Task 1: multiply every sample by 2
scaled = 2*measured;

% Task 2: delay by 5 samples = put 5 zeros in front of the signal
delay = 5;
delayed = [zeros(1,delay) measured];

n_measured = 0:length(measured)-1;      % 0 ... 100
n_delayed  = 0:length(delayed)-1;       % 0 ... 105 (5 samples longer)

figOps = figure('Name','Signal Operations','Position',[100 100 900 700]);

subplot(2,1,1);
plot(n,measured,'Color',[0.5 0.5 0.5],'LineWidth',1);
hold on;
plot(n,scaled,'r','LineWidth',1.2);
hold off;
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Task 1: Amplitude Scaling (scaled = 2 \times measured)');
legend('Noisy signal','Scaled signal (\times 2)','Location','northeast');

subplot(2,1,2);
plot(n_measured,measured,'o-','Color',[0.5 0.5 0.5],'MarkerSize',4);
hold on;
plot(n_delayed,delayed,'s-','Color',[0 0.6 0],'MarkerSize',4);
hold off;
grid on;
xlim([0 50]);                   % Zoom in so the 5-sample shift is visible
xlabel('Sample index n');
ylabel('Amplitude');
title('Task 2: Signal Delay by 5 Samples (first 50 samples shown)');
legend('Noisy signal','Delayed signal (5 samples)','Location','northeast');

saveas(figOps,'signal_operations.png');

%% Task 3: Five-point moving-average filter

h5 = ones(1,5)/5;               % Impulse response h[n]: five samples of 1/5
filtered5 = conv(measured,h5,'same');

figFilt = figure('Name','Noise Filtering');
plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);
plot(n,filtered5,'r--','LineWidth',1.5);
hold off;
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Five-Point Moving-Average Filter');
legend('Clean signal','Noisy signal','5-point filtered','Location','northeast');

saveas(figFilt,'noise_filtering.png');

%% Task 4: Compare two filter lengths

h15 = ones(1,15)/15;            % 15 samples of 1/15
filtered15 = conv(measured,h15,'same');

figCmp = figure('Name','Filter Comparison','Position',[100 100 900 500]);
plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.7 0.7 0.7]);
plot(n,filtered5,'r--','LineWidth',1.5);
plot(n,filtered15,'-.','Color',[0 0.6 0],'LineWidth',2);
hold off;
grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Comparison of 5-Point and 15-Point Moving-Average Filters');
legend('Clean signal','Noisy signal','5-point filtered','15-point filtered', ...
       'Location','northeast');

saveas(figCmp,'filter_comparison.png');

%% Numerical check (printed in the Command Window, used in README)
% RMS error compared to the clean signal: smaller = closer to the clean signal
% Edges (first/last 7 samples) are skipped because 'same' pads with zeros there
idx = 8:length(n)-7;
rmse = @(x) sqrt(mean((x(idx) - clean(idx)).^2));

fprintf('RMS error vs clean signal:\n');
fprintf('  Noisy signal      : %.3f\n', rmse(measured));
fprintf('  5-point filtered  : %.3f\n', rmse(filtered5));
fprintf('  15-point filtered : %.3f\n', rmse(filtered15));

fprintf('\nLargest value (middle part of the signal):\n');
fprintf('  Clean             : %.2f\n', max(abs(clean(idx))));
fprintf('  5-point filtered  : %.2f\n', max(abs(filtered5(idx))));
fprintf('  15-point filtered : %.2f\n', max(abs(filtered15(idx))));

fprintf('\nMax of |scaled| / max of |measured| = %.1f\n', ...
        max(abs(scaled))/max(abs(measured)));
fprintf('Length of measured = %d, length of delayed = %d\n', ...
        length(measured), length(delayed));
