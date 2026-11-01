# Lecture 01 – Signal Visualization in MATLAB

This folder contains my solution for the Lecture 01 assignment: generating, plotting and interpreting simple sine signals in MATLAB.

## Files

|File|Description|
|-|-|
|`Lecture01\_signal\_visualization.m`|MATLAB script for all tasks|
|`frequency\_comparison.png`|Task 2 – sine waves at 2, 5 and 10 Hz|
|`amplitude\_comparison.png`|Task 3 – sine waves with amplitudes 0.5, 1 and 2|
|`clean\_vs\_noisy\_signal.png`|Task 4 – clean vs noisy sine wave|

## How to run

1. Open MATLAB (desktop or MATLAB Online).
2. Set the *Current Folder* to this `Lecture01` folder.
3. Run `Lecture01\_signal\_visualization.m` (press **Run** or type `Lecture01\_signal\_visualization` in the Command Window).
4. Four figures open, and three PNG files are saved in the same folder.

All signals use a sampling frequency of 1000 Hz and a duration of 1 second. A sine wave is computed as `y = A \* sin(2\*pi\*f\*t)`.

\---

## Task 1 – Sine Wave

A sine wave with amplitude 1, frequency 5 Hz and duration 1 s is plotted with a title, axis labels and grid. Five full cycles are visible in one second.

## Task 2 – Frequency Comparison

!\[Frequency comparison](frequency\_comparison.png)

**Which signal changes fastest?**
The 10 Hz signal. It completes 10 full cycles per second, so its value goes up and down much faster than the others.

**Which signal has the lowest frequency?**
The 2 Hz signal. It completes only 2 cycles in one second.

**How can you see the difference in the plots?**
By counting the number of waves (peaks) in the 1-second window: 2 peaks for 2 Hz, 5 for 5 Hz and 10 for 10 Hz. The higher the frequency, the closer together the peaks are (shorter period, T = 1/f). The height of all three waves is the same because the amplitude is the same.

## Task 3 – Amplitude Comparison

!\[Amplitude comparison](amplitude\_comparison.png)

All three signals use the same frequency (5 Hz) and the same y-axis limits, so they can be compared directly.

**Which signal has the largest amplitude?**
The signal with amplitude 2. It reaches +2 and −2, while the others only reach ±1 and ±0.5.

**Does changing amplitude change frequency?**
No. All three signals still have 5 cycles per second and their peaks line up at the same times. Amplitude changes only the height of the wave, not how fast it repeats.

**Give one real-world example where amplitude is important.**
In audio, amplitude corresponds to loudness: a sound wave with a larger amplitude is heard as louder. Another example is a vibration sensor on a machine, where a growing vibration amplitude can indicate wear or a fault.

## Task 4 – Adding Noise

!\[Clean vs noisy signal](clean\_vs\_noisy\_signal.png)

Gaussian random noise (`randn`, standard deviation 0.3) was added to a clean 5 Hz sine wave. `rng(1)` is used so the result is the same every time the script runs.

**What changed after adding noise?**
The signal is no longer smooth. It has small random jumps up and down at every sample, and the peaks are sometimes higher or lower than ±1.

**Can you still recognize the original signal?**
Yes. The overall 5 Hz sine shape is still clearly visible, because the noise (std 0.3) is small compared to the signal amplitude (1). With much stronger noise the sine wave would become hard to see.

**Give one real-world source of signal noise.**
Electrical interference, for example from power lines (50 Hz in Finland) or nearby motors, picked up by sensor cables. Thermal noise inside electronic components is another source.

## Task 5 – Saved Figures

The script saves the figures with `saveas`:

* `frequency\_comparison.png`
* `amplitude\_comparison.png`
* `clean\_vs\_noisy\_signal.png`

\---

## Task 6 – AI Usage Note

**AI Tool Used:**
Claude (Anthropic)

**Prompt:**

<!-- Paste the prompt you actually used. Example below – edit so it matches what you asked. -->

"Help me with this MATLAB assignment: generate a 5 Hz sine wave, compare 2/5/10 Hz and amplitudes 0.5/1/2 in subplots, add noise to a sine wave, and save the figures as PNG files."

**What AI Suggested:**
A MATLAB script that creates a time vector with a 1000 Hz sampling rate, generates sine waves with `A\*sin(2\*pi\*f\*t)`, uses `subplot` loops for the frequency and amplitude comparisons, adds Gaussian noise with `randn`, and saves the figures with `saveas`.

**Did the code work immediately?**

Yes. The script ran without errors on the first try in MATLAB Online and created all three PNG files.

**What did you modify?**

In the clean vs noisy plot, the noisy signal's peaks were cut off at ±2, so I changed ylim(\[-2 2]) to ylim(\[-2.5 2.5]) for both subplots.

**How did you verify the result?**

\- Counted the cycles in the frequency plot: 2, 5 and 10 waves in 1 second.

\- Checked the amplitude plot peaks: ±0.5, ±1 and ±2, with all peaks at the same times.

\- Checked that the noisy signal still shows the 5 Hz sine shape.

\- Confirmed that the three PNG files were saved and open correctly.

