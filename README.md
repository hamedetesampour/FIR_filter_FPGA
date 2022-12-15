# FIR_filter_FPGA
## Finite Impulse Response filter design using Xilinx ISE (VHDL programming for FPGA implementation) 
This project aims to design a Finite Impulse Response (FIR) module that can be implemented by Field-programmable gate arrays. These filters are widely used in variety of communication and digital processing applications. 
## The Theoretical Background & Structure
FIR filters are popular for their straightforward procedure. Since there are no feedback loops in this form of filter it will converge to zero within finite time and that's why we call it "finite impulse response" (in contrast with Infinite Impulse Response or IIR filters). Moreover, due to their stability, phase linearity and less insensitivity to coefficients rounding, FIR filters are widely used in systems that are responsible for detecting instantaneous frequencies, such as Hilbert Transforms[^1]. 

The “impulse response” of a FIR filter is just the set of FIR coefficients. In other words if you put an “impulse” into a FIR filter which consists of a “1” sample followed by a large number of “0” samples, the output of the filter will be simply the set of coefficients, as the 1 valued sample moves past each coefficient in turn to form the output.[^2]

The order and values of the coefficients are the most important characteristics of the filter. The number of coefficients declare filter's order and coefficients' values will form its functionality, that is designed regarding to our purpose. FIR filter can be used in low-pass, band-pass, high-pass, notch or any other filtering designs. (just by altering the order and values of the coefficients). 

N-th order FIR filter structure demonstrated as below:

<p align="center">
<img src="https://www.typhoon-hil.com/documentation/typhoon-hil-software-manual/Images/fir_filter_04.gif" width="440" height="186" />
</p>

[^1]: A.K. Dwivedi, R.N. Patel, in Quantum Inspired Computational Intelligence, 2017
[^2]: Robert Oshana, in DSP Software Development Techniques for Embedded and Real-Time Systems, 2006

## Implementing in VHDL 
As you can realize from FIR filter's structrue, to implement this filter we need three sub-modules to work together as a whole:
1. Shift register: to shift and apply delays to the signal
2. Multiplier: to multiply coefficients to signals
3. Adder: to sum the above signals and form the final output

Eventually, since we are looking for a customizable module which can be used for different purposes with various digital signal types (n-bit input), we program each module seperately and then declare the overall inputs, so that the user can utilize this filter for different applications. 

Considering the abovementioned facts, each sub-module's input/output bits are defined by the number of coefficients we are willing to use and also by the number of bits that our input signal is consisted of. For example, for 10th-order low-pass filter, we use SINC function coefficients including an array with 10 values/coefficients (each value could be represented by 8 bits), and for 8-bit input signal we use 8-bit shift register and adder. However, the output bits are dependent to users' regarding to the specific accuracy they or looking for or type of the input signal they are working on (For sure, it can't be less than 8-bits for a 8-bit input signal).

The FIR filter as LPF[^3]:

<p align="center">
<img src="https://wirelesspi.com/wp-content/uploads/2016/08/figure-introduction-fir-filter-response.png" width="440" height="330" />
</p>  <br />

The final FIR module will look as below:


<p align="center">
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqHOOnggYq0UFGarOp0NlF0HRJ6zOzXWtvmA&usqp=CAU" width="220" height="135" />
</p>  <br />

[^3]: Finite Impulse Response (FIR) Filters, https://wirelesspi.com/finite-impulse-response-fir-filters/

## Testbench & Simulation
Finally to test our module and observe its function we use VHDL testbench with 11th order SINC coefficients and 8-bit input signal ,then we check our results with MATLAB to see if it is operating well enough.

Module:

<p align="center">
<img src="https://user-images.githubusercontent.com/108813301/207665349-1df2791b-3bf6-499b-b463-0ce2f19f6cb5.JPEG" width="176" height="149" />
<img src="https://user-images.githubusercontent.com/108813301/207814102-39cf7fd7-68f4-48bd-ad39-b1a1edbbcc4e.JPEG" width="597" height="149" />
</p>  <br />
  
  
Simulation output:
  
<p align="center">
<img src="https://user-images.githubusercontent.com/108813301/207817184-2dcff919-dae0-4f69-94f8-307fd354de99.jpeg" width="1268" height="177" />
</p>  <br />
  
  
MATLAB output (considering: [input,coeff] = [x,h]):
  
```
x = [0,1,2,3,4,5,6,7,8,9,10];
h = [-15,-13,7,38,66,78,66,38,7,-13,-15]
y = conv(x,h);
stem(y);
```
  
<p align="center">
<img src="https://user-images.githubusercontent.com/108813301/207814169-109d94c9-fb72-4b47-98d3-484ad758c433.JPEG" width="643" height="336" />
</p>  

-------------------------------------------------------------------------------------------------- <br />  
*at last you can find the raw vhd codes of the modules and testbench in the main directory, and also the whole project file in FIR_filter folder is available for you to run the project in Xilinx ISE Design*
