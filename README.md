# OceanEyes
Filtering Ocean Data to Isolate Various Marine Mammal Sounds

Objective: "The input time domain signal you are provided contains the vocalization signals of a fin whale (20 Hz centered calls) and a humpback whale song (50 Hz to 700 Hz) received simultaneously by a hydrophone (underwater microphone). The objective of this project is to isolate the fin whale call by filtering out the humpback whale song. You will need a low pass filter of sufficiently high-order (> 2) to eliminate the humpback whale song sufficiently in the output signal."

The original input signal data was characterized by a deep rumbling sound - the sound of the ocean - punctuated by short, high-frequency sounds. These short sounds were determined to be the song calls of the humpback whales. The fin whale calls could not be heard, as the frequency was too low, and were consumed by the higher-frequency sounds.

Thus, filters had to be designed to limit the higher frequency data to allow for the lower frequency fin whale data to be 'heard.' Thus, a low-pass filter had to be utilized. This was iterated throughout this project, and it was finally determined that a fifth-order low-pass filter would filter enough of the higher-frequency humpback whale data.   

Signal Processing was completed in MATLAB - adapted from a script provided by the professor - in both the time and frequency domains. The Fourier and Inverse Fourier Transforms were utilized to convert between the two domains. 
