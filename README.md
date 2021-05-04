# OceanEyes
Filtering Ocean Data to Isolate Various Marine Mammal Sounds

The original input dignal data contained the song calls of a fin whale (around 20 Hz) and a humpback whale (50-700 Hz) simultaneously recorded by an underwater microphone. This data was characterized by a deep rumbling sound - the sound of the ocean - punctuated by short, high-frequency sounds. These short sounds were determined to be the song calls of the humpback whales. The fin whale calls could not be heard, as the frequency was too low, and were consumed by the higher-frequency sounds.

Thus, filters had to be designed to limit the higher frequency data to allow for the lower frequency fin whale data to be 'heard.' Thus, a low-pass filter had to be utilized. This was iterated throughout this project, and it was finally determined that a fifth-order low-pass filter would filter enough of the higher-frequency humpback whale data.   

Signal Processing was completed in MATLAB in both the time and frequency domains. The Fourier and Inverse Fourier Transforms were utilized to convert between the two domains. 
