# softwaresecurity_fuzzing

## Radamsa: fuzzed bmp files
Created bmp files are ignored by git because these files are around 10gb... Only the fuzz files where dot crashes are stored here.

## Radamsa: bash script
In the bash script, the code to generate mutation files by radamsa are commented out, because we wanted to generate it once for fuzzing without ASan. Then we wanted the same mutation files for fuzzing with ASan.
