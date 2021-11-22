# 2D CFAR Implementation README

In the report, an overview of the implementation of the 2D Constant False Alarm Rate (CFAR) is explained. The choice behind selecting the hyperparameters for doppler frequency and range are also mentioned.

## Implementation Steps

First, as explained in the coursework, a 1D Range Doppler Map is constructed by iterating over each spatial location in the range spectrum and the doppler frequency range.

For every spatial location in the Range Doppler Map, a 2-dimensional window is  considered. The size of this window is a function of a set of hyperparameters which is expressed below:

1. Guard Range Rows (Gr) is the number of rows away from the centre that are avoided in the calculation. The total is
   $$
   2Gr+1
   $$
   .

2. Guard Doppler Columns (Gd) is the number of columns away from the centre that are avoided in the calculation. The total is 
   $$
   2Gd+1
   $$

3. Training range rows (Tr) operate in the same way as guard range rows but the key difference being that Tr is used to examine the elements in the RDM. The total is 
   $$
   2Tr+1
   $$

4. Training doppler columns (Td) operate in the same way as guard Doppler Columns but the key difference being that Td is used to examine the elements in the RDM. The total is 
   $$
   2Td+1
   $$
   

 

Thus, the total size of the window for each spatial location is Therefore, the size of the window under examination is
$$
(2Tr+2Gr+1)(2Td+2Gd+1) - (2Gr+1)(2Gd+1)
$$
For each 2D window, an average of the elements that are considered training elements  while the guard row and column elements are skipped. An offset is added to this quantity as per a known SNR threshold (acts as an uncertainty from the environment). If the SNR threshold is larger than the average taken by the elements, we set the output of the spatial location which is the centre of the examination window to be 1, else 0. For implementing the offset bias, the RDM has to be converted from dB to a unitless magnitude and offset by the SNR and reconvert that expression to dB scale.  

 A vectorisation implementation is adopted in the code submit using a mask technique. This mask is simply composed of all `1`s that are of size `2 * Tr + 2 * Gr + 1` x `2 * Td + 2 * Gd + 1` except for the guard region and centre location with are set to 0.  The mask is then normalised by the sum of the components to facilitate averaging per spatial location.  We first transform the RDM from dB into unitless magnitude, perform the convolution on the RDM then convert the result back into dB, and apply the offset to finally get the thresholds per location in the RDM.  In a vectorised fashion, we use logical operators to simultaneously check all elements in this threshold output and see if the corresponding position in the RDM is greater or lesser and set the output value to 0 or 1 accordingly.

## 

Due to repeated experimentation and observing the output, the following hyperparameters were chosen:

* `Td = 10`
* `Tr = 8`
* `Gr = 4`
* `Gd = 4`
* `offset = 6`

The initial hyperparameters chosen were already good enough, so they remain in the final version of this project.

## 
