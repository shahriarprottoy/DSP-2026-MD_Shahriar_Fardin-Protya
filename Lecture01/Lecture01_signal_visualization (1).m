%% Lecture 01 - Signal Visualization in MATLAB
% Author: Shahriar
% Course: Savonia UAS
%
% This script generates simple sine signals, compares frequencies and
% amplitudes, adds noise, and saves the figures as PNG files.

clear; clc; close all;

%% Common settings
fs = 1000;              % Sampling frequency (Hz) - 1000 samples per second
duration = 1;           % Signal duration (seconds)
t = 0:1/fs:duration;    % Time vector from 0 to 1 s

%% Task 1: Create a sine wave (A = 1, f = 5 Hz, 1 s)
A = 1;                  % Amplitude
f = 5;                  % Frequency (Hz)
y = A * sin(2*pi*f*t);  % Sine wave

figure('Name', 'Task 1 - Sine Wave');
plot(t, y, 'b', 'LineWidth', 1.5);
title('Sine Wave: Amplitude = 1, Frequency = 5 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Task 2: Compare different frequencies (2, 5, 10 Hz)
freqs = [2 5 10];

fig2 = figure('Name', 'Task 2 - Frequency Comparison');
for k = 1:length(freqs)
    subplot(3, 1, k);
    plot(t, sin(2*pi*freqs(k)*t), 'LineWidth', 1.5);
    title(sprintf('Sine Wave: f = %d Hz, A = 1', freqs(k)));
    xlabel('Time (s)');
    ylabel('Amplitude');
    ylim([-1.2 1.2]);
    grid on;
end
sgtitle('Frequency Comparison');

%% Task 3: Compare different amplitudes (0.5, 1, 2) at the same frequency
amps = [0.5 1 2];
f_same = 5;             % Same frequency for all three signals

fig3 = figure('Name', 'Task 3 - Amplitude Comparison');
for k = 1:length(amps)
    subplot(3, 1, k);
    plot(t, amps(k) * sin(2*pi*f_same*t), 'LineWidth', 1.5);
    title(sprintf('Sine Wave: A = %.1f, f = %d Hz', amps(k), f_same));
    xlabel('Time (s)');
    ylabel('Amplitude');
    ylim([-2.5 2.5]);   % Same y-axis on all plots so amplitudes can be compared
    grid on;
end
sgtitle('Amplitude Comparison');

%% Task 4: Add noise
rng(1);                             % Fixed seed so the result is repeatable
clean = sin(2*pi*5*t);              % Clean 5 Hz sine wave, A = 1
noise_level = 0.3;                  % Standard deviation of the noise
noise = noise_level * randn(size(t));   % Gaussian (random) noise
noisy = clean + noise;              % Noisy signal

fig4 = figure('Name', 'Task 4 - Clean vs Noisy Signal');
subplot(2, 1, 1);
plot(t, clean, 'b', 'LineWidth', 1.5);
title('Clean Signal (5 Hz, A = 1)');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2 2]);
grid on;

subplot(2, 1, 2);
plot(t, noisy, 'r');
title(sprintf('Noisy Signal (Gaussian noise, std = %.1f)', noise_level));
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2 2]);
grid on;
sgtitle('Clean vs Noisy Signal');

%% Task 5: Save figures as PNG files
saveas(fig2, 'frequency_comparison.png');
saveas(fig3, 'amplitude_comparison.png');
saveas(fig4, 'clean_vs_noisy_signal.png');

disp('Figures saved:');
disp('  frequency_comparison.png');
disp('  amplitude_comparison.png');
disp('  clean_vs_noisy_signal.png');
