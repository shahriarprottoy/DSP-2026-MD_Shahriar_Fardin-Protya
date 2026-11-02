# Lecture 02 – Sampling and Aliasing

## Objective

A vibration sensor in a condition monitoring system produces an analog signal that must be sampled before it can be processed digitally. In this investigation, a 10 Hz sine wave is sampled at 15, 20, 25, 50 and 100 Hz. The goal is to see how the sampling frequency affects the digital representation, to apply the Nyquist Sampling Theorem, and to find out when aliasing happens.

**How to run:** open `Lecture02\_sampling\_aliasing.m` in MATLAB and press **Run**. The script plots all figures, saves the six PNG files and prints a summary in the Command Window.

## Files

|File|Description|
|-|-|
|`Lecture02\_sampling\_aliasing.m`|MATLAB script for all tasks|
|`original\_signal.png`|Task 1 – original 10 Hz signal (time step 0.1 ms)|
|`sampling\_15Hz.png` … `sampling\_100Hz.png`|Task 2 – original signal with sampled points (stems)|

## Original Signal

!\[Original signal](original\_signal.png)

The 10 Hz sine wave was generated with a time step of dt = 0.0001 s (10 000 points per second), which is small enough to look like a continuous-time signal. Ten full cycles are visible in one second.

## Nyquist Analysis

The Nyquist Sampling Theorem says the sampling frequency must be **more than twice** the highest frequency in the signal:

```
fs > 2 · fmax
fs\_min = 2 · 10 Hz = 20 Hz   (Nyquist rate)
```

|fs (Hz)|Ts = 1/fs (s)|Samples per cycle (fs/f)|fs > 20 Hz?|
|-|-|-|-|
|15|0.0667|1.5|No|
|20|0.0500|2.0|No (exactly at the limit)|
|25|0.0400|2.5|Yes|
|50|0.0200|5.0|Yes|
|100|0.0100|10.0|Yes|

**Which sampling frequencies satisfy the Nyquist criterion?**
25 Hz, 50 Hz and 100 Hz.

**Is sampling exactly at the Nyquist rate recommended in practice?**
No. At exactly 20 Hz there are only 2 samples per cycle, and the result depends on where the samples land. In this experiment, every sample fell on a zero crossing (sin(π·n) = 0), so the sampled signal is a flat line and the 10 Hz signal completely disappears. Real systems also need extra margin because real anti-aliasing filters are not ideal, real signals contain noise and harmonics above fmax, and clock frequencies drift. In practice, engineers sample at least 2.5–10 times fmax.

## Results

**15 Hz** – !\[15 Hz](sampling\_15Hz.png)
Only 1.5 samples per cycle. The samples do not follow the 10 Hz wave. Instead, they fit a slower **5 Hz** wave exactly (|10 − 15| = 5 Hz), shown as the dashed line. This is aliasing.

**20 Hz** – !\[20 Hz](sampling\_20Hz.png)
Exactly at the Nyquist rate. All samples are zero, because they land on the zero crossings of the sine wave. The digital signal shows no vibration at all, even though the real signal has amplitude 1.

**25 Hz** – !\[25 Hz](sampling\_25Hz.png)
Above the Nyquist rate (2.5 samples per cycle), so there is no aliasing and the 10 Hz frequency can be recovered in theory. Visually, the samples are sparse and the peaks are not captured well (the largest sample is about 0.95), so the shape is hard to see without reconstruction.

**50 Hz** – !\[50 Hz](sampling\_50Hz.png)
Five samples per cycle. The sine shape and the 10 Hz frequency are clearly recognisable from the samples.

**100 Hz** – !\[100 Hz](sampling\_100Hz.png)
Ten samples per cycle. The samples follow the original signal closely and the waveform is accurately represented.

## Aliasing Discussion

Aliasing occurs at **15 Hz**, where the 10 Hz vibration appears as a false 5 Hz signal. At **20 Hz** (exactly the Nyquist rate), sampling is on the limit. Here every sample is zero, so the signal is lost entirely. Aliasing occurs when the signal changes more than once between two samples. The samples cannot tell the true frequency apart from a lower one that passes through the same points, so a high frequency "folds" down to a false low frequency: f\_alias = |f − fs|. In a monitoring system this is dangerous, because a fault frequency could be reported at the wrong value.

## Engineering Recommendation

I recommend **100 Hz** (10 × fmax).

* **Accuracy:** 10 samples per cycle capture both the frequency and the waveform shape, including the peak amplitude. Peak amplitude matters for detecting vibration faults.
* **Processing:** 100 samples/s is a very small data rate for a microcontroller or MATLAB, so oversampling costs almost nothing.
* **Robustness:** the large margin above 20 Hz tolerates higher harmonics, noise, clock drift and a non-ideal anti-aliasing filter.

25 Hz is theoretically sufficient but has too little margin. 50 Hz would be an acceptable minimum.

## AI Usage

* **AI Tool Used:** Claude (Anthropic)
* **Prompt(s):**

  "Help me with this MATLAB assignment: sample a 10 Hz sine wave at 15, 20, 25, 50 and 100 Hz, plot the samples over the original signal, and explain Nyquist and aliasing."

* **Summary of AI Response:**
Claude generated a MATLAB script that creates the 10 Hz signal with dt = 0.1 ms, samples it at each frequency, plots stems over the continuous signal, and saves one figure per sampling frequency. For undersampled cases, it overlays the predicted alias frequency (f − fs·round(f/fs)). It also explained that the Nyquist rate is 20 Hz and that the 15 Hz case aliases to 5 Hz.
* **What I Modified:**

  &#x20; The AI's code ran without errors on the first try. I updated the header with my name and course. I also added a dotted line connecting the sampled points (`plot(ts, xs, 'r:')`) and added it to the legend. This makes it easier to see what the sampled signal looks like without reconstruction. For example, at 25 Hz the joined samples look distorted even though there is no aliasing, and at 15 Hz they clearly follow a 5 Hz wave.

* **How I Verified the Results:**

  * Calculated the Nyquist rate by hand: 2 × 10 = 20 Hz.
  * Calculated the expected alias at 15 Hz by hand: |10 − 15| = 5 Hz. Checked that the red samples lie exactly on the dashed 5 Hz curve.
  * Checked one 20 Hz sample by hand: sin(2π·10·0.05) = sin(π) = 0. This explains the flat line.
  * Counted the samples per cycle in each plot and compared them with fs/f in the table.
  * Compared the Command Window output with the table above.

