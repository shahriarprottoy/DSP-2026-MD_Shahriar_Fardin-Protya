%% Lecture 02 - Sampling and Aliasing Investigation
% Author: MD Shahriar Fardin Protya
% Course: Digital signal processing
%
% A 10 Hz sine wave (the "analog" vibration signal) is sampled at
% 15, 20, 25, 50 and 100 Hz to see how the sampling frequency affects
% the digital representation and when aliasing happens.

clear; clc; close all;

%% Task 1: Original (near-continuous) signal
f = 10;                 % Signal frequency (Hz)
A = 1;                  % Amplitude
duration = 1;           % Duration (s)

dt = 1e-4;              % Very small time step (10 000 points per second)
t = 0:dt:duration;      % "Continuous" time vector
x = A * sin(2*pi*f*t);  % Original signal

fig1 = figure('Name', 'Task 1 - Original Signal');
plot(t, x, 'b', 'LineWidth', 1.5);
title('Original Signal: 10 Hz Sine Wave (near-continuous, dt = 0.1 ms)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original 10 Hz signal', 'Location', 'northeast');
ylim([-1.5 1.5]);
grid on;
saveas(fig1, 'original_signal.png');

%% Task 2: Sample the signal at different sampling frequencies
fs_list = [15 20 25 50 100];        % Sampling frequencies (Hz)
nyquist_rate = 2 * f;               % = 20 Hz

% Combined overview figure (five subplots) - for viewing
figAll = figure('Name', 'Task 2 - All Sampling Frequencies', ...
    'Position', [100 50 900 900]);

for k = 1:length(fs_list)
    fs = fs_list(k);                % Sampling frequency
    Ts = 1/fs;                      % Sampling period
    ts = 0:Ts:duration;             % Sampling instants
    xs = A * sin(2*pi*f*ts);        % Sampled values

    % Apparent (alias) frequency: the frequency the samples seem to have
    f_alias = f - fs * round(f/fs);

    % ----- Separate figure for each sampling frequency (saved as PNG) -----
    figk = figure('Name', sprintf('Sampling at %d Hz', fs));
    plotSampling(t, x, ts, xs, f, fs, Ts, f_alias, nyquist_rate);
    saveas(figk, sprintf('sampling_%dHz.png', fs));

    % ----- Same plot as a subplot in the overview figure -----
    figure(figAll);
    subplot(length(fs_list), 1, k);
    plotSampling(t, x, ts, xs, f, fs, Ts, f_alias, nyquist_rate);

    % Print a short summary in the Command Window
    fprintf('fs = %3d Hz | Ts = %.4f s | samples/cycle = %4.1f | apparent freq = %4.1f Hz\n', ...
        fs, Ts, fs/f, abs(f_alias));
end
figure(figAll);
sgtitle('Sampling a 10 Hz Sine Wave at Different Sampling Frequencies');

%% Task 3: Nyquist analysis (printed to the Command Window)
fprintf('\nNyquist rate: fs_min = 2 * fmax = 2 * %d Hz = %d Hz\n', f, nyquist_rate);
fprintf('Sampling frequencies with fs > 2*fmax: %s Hz\n', ...
    mat2str(fs_list(fs_list > nyquist_rate)));

%% Local function (must be at the end of the script)
function plotSampling(t, x, ts, xs, f, fs, Ts, f_alias, nyquist_rate)
plot(t, x, 'b', 'LineWidth', 1.2); hold on;
stem(ts, xs, 'r', 'filled', 'LineWidth', 1.2, 'MarkerSize', 5);

if fs < nyquist_rate
    % Undersampled: show the lower-frequency signal the samples look like
    plot(t, sin(2*pi*f_alias*t), 'k--', 'LineWidth', 1.2);
    legend('Original 10 Hz signal', 'Samples', ...
        sprintf('Apparent %g Hz signal (alias)', abs(f_alias)), ...
        'Location', 'eastoutside');
else
    legend('Original 10 Hz signal', 'Samples', 'Location', 'eastoutside');
end
hold off;

title(sprintf('f_s = %d Hz  (T_s = %.3f s, %.1f samples per cycle)', ...
    fs, Ts, fs/f));
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-1.5 1.5]);
grid on;
end
