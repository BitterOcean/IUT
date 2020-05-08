# Synthesise   
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-verilog-orange)

:wink: Take a look at <a href="https://github.com/BitterOcean/IUT/issues/6"> issues#6 </a> to **Download Xilinx ISE Design Suite v14.7**    

****

<p align="center">
  <a href="https://github.com/BitterOcean/IUT/edit/master/FPGA/HW3">
    <img src="https://user-images.githubusercontent.com/60509979/81408434-7553e680-9152-11ea-9872-2314a4639d1a.png" alt="Master">
  </a>
</p>

## :anger: &nbsp;Table of Contents

- **[P Counter](#P-Counter)**
- **[Day Counter](#Day-Counter)**
- **[Stopwatch](#Stopwatch)**
- **[PWM Generator](#PWM-Generator)**
- **[PWM Detector](#PWM-Detector)**
- **[Support](#Support)**
- **[License](#License)**

****

## P Counter  

- **Synthesis Report** 
```
Release 14.7 - xst P.20131013 (nt64)
Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--> Parameter TMPDIR set to xst/projnav.tmp


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.13 secs
 
--> Parameter xsthdpdir set to xst


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.13 secs
 
--> Reading design: PCounter.prj

TABLE OF CONTENTS
  1) Synthesis Options Summary
  2) HDL Parsing
  3) HDL Elaboration
  4) HDL Synthesis
       4.1) HDL Synthesis Report
  5) Advanced HDL Synthesis
       5.1) Advanced HDL Synthesis Report
  6) Low Level Synthesis
  7) Partition Report
  8) Design Summary
       8.1) Primitive and Black Box Usage
       8.2) Device utilization summary
       8.3) Partition Resource Summary
       8.4) Timing Report
            8.4.1) Clock Information
            8.4.2) Asynchronous Control Signals Information
            8.4.3) Timing Summary
            8.4.4) Timing Details
            8.4.5) Cross Clock Domains Report


=========================================================================
*                      Synthesis Options Summary                        *
=========================================================================
---- Source Parameters
Input File Name                    : "PCounter.prj"
Ignore Synthesis Constraint File   : NO

---- Target Parameters
Output File Name                   : "PCounter"
Output Format                      : NGC
Target Device                      : xc6slx16-3-csg324

---- Source Options
Top Module Name                    : PCounter
Automatic FSM Extraction           : YES
FSM Encoding Algorithm             : Auto
Safe Implementation                : No
FSM Style                          : LUT
RAM Extraction                     : Yes
RAM Style                          : Auto
ROM Extraction                     : Yes
Shift Register Extraction          : YES
ROM Style                          : Auto
Resource Sharing                   : YES
Asynchronous To Synchronous        : NO
Shift Register Minimum Size        : 2
Use DSP Block                      : Auto
Automatic Register Balancing       : No

---- Target Options
LUT Combining                      : Auto
Reduce Control Sets                : Auto
Add IO Buffers                     : YES
Global Maximum Fanout              : 100000
Add Generic Clock Buffer(BUFG)     : 16
Register Duplication               : YES
Optimize Instantiated Primitives   : NO
Use Clock Enable                   : Auto
Use Synchronous Set                : Auto
Use Synchronous Reset              : Auto
Pack IO Registers into IOBs        : Auto
Equivalent register Removal        : YES

---- General Options
Optimization Goal                  : Speed
Optimization Effort                : 1
Power Reduction                    : NO
Keep Hierarchy                     : No
Netlist Hierarchy                  : As_Optimized
RTL Output                         : Yes
Global Optimization                : AllClockNets
Read Cores                         : YES
Write Timing Constraints           : NO
Cross Clock Analysis               : NO
Hierarchy Separator                : /
Bus Delimiter                      : <>
Case Specifier                     : Maintain
Slice Utilization Ratio            : 100
BRAM Utilization Ratio             : 100
DSP48 Utilization Ratio            : 100
Auto BRAM Packing                  : NO
Slice Utilization Ratio Delta      : 5

=========================================================================


=========================================================================
*                          HDL Parsing                                  *
=========================================================================
Analyzing Verilog file "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" into library work
Parsing module <PCounter>.

=========================================================================
*                            HDL Elaboration                            *
=========================================================================

Elaborating module <PCounter>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" Line 22: Result of 8-bit expression is truncated to fit in 7-bit target.

=========================================================================
*                           HDL Synthesis                               *
=========================================================================

Synthesizing Unit <PCounter>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v".
        MAX_SIZE = 7
        p = 7'b0111011
    Found 1-bit register for signal <out>.
    Found 7-bit register for signal <cnt_out>.
    Found 7-bit adder for signal <cnt_out[6]_GND_1_o_add_3_OUT> created at line 22.
    Found 7-bit comparator greater for signal <cnt_out[6]_GND_1_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   8 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter> synthesized.

=========================================================================
HDL Synthesis Report

Macro Statistics
# Adders/Subtractors                                   : 1
 7-bit adder                                           : 1
# Registers                                            : 2
 1-bit register                                        : 1
 7-bit register                                        : 1
# Comparators                                          : 1
 7-bit comparator greater                              : 1
# Multiplexers                                         : 3
 1-bit 2-to-1 multiplexer                              : 2
 7-bit 2-to-1 multiplexer                              : 1

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================


Synthesizing (advanced) Unit <PCounter>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter> synthesized (advanced).

=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# Counters                                             : 1
 7-bit up counter                                      : 1
# Registers                                            : 1
 Flip-Flops                                            : 1
# Comparators                                          : 1
 7-bit comparator greater                              : 1
# Multiplexers                                         : 2
 1-bit 2-to-1 multiplexer                              : 2

=========================================================================

=========================================================================
*                         Low Level Synthesis                           *
=========================================================================

Optimizing unit <PCounter> ...
WARNING:Xst:1293 - FF/Latch <cnt_out_6> has a constant value of 0 in block <PCounter>. This FF/Latch will be trimmed during the optimization process.
WARNING:Xst:1293 - FF/Latch <cnt_out_6> has a constant value of 0 in block <PCounter>. This FF/Latch will be trimmed during the optimization process.
WARNING:Xst:1293 - FF/Latch <cnt_out_6> has a constant value of 0 in block <PCounter>. This FF/Latch will be trimmed during the optimization process.

Mapping all equations...
Building and optimizing final netlist ...
Found area constraint ratio of 100 (+ 5) on block PCounter, actual ratio is 0.

Final Macro Processing ...

=========================================================================
Final Register Report

Macro Statistics
# Registers                                            : 7
 Flip-Flops                                            : 7

=========================================================================

=========================================================================
*                           Partition Report                            *
=========================================================================

Partition Implementation Status
-------------------------------

  No Partitions were found in this design.

-------------------------------

=========================================================================
*                            Design Summary                             *
=========================================================================

Top Level Output File Name         : PCounter.ngc

Primitive and Black Box Usage:
------------------------------
# BELS                             : 11
#      GND                         : 1
#      INV                         : 1
#      LUT2                        : 3
#      LUT6                        : 6
# FlipFlops/Latches                : 7
#      FDCE                        : 7
# Clock Buffers                    : 1
#      BUFGP                       : 1
# IO Buffers                       : 10
#      IBUF                        : 2
#      OBUF                        : 8

Device utilization summary:
---------------------------

Selected Device : 6slx16csg324-3 


Slice Logic Utilization: 
 Number of Slice Registers:               7  out of  18224     0%  
 Number of Slice LUTs:                   10  out of   9112     0%  
    Number used as Logic:                10  out of   9112     0%  

Slice Logic Distribution: 
 Number of LUT Flip Flop pairs used:     10
   Number with an unused Flip Flop:       3  out of     10    30%  
   Number with an unused LUT:             0  out of     10     0%  
   Number of fully used LUT-FF pairs:     7  out of     10    70%  
   Number of unique control sets:         2

IO Utilization: 
 Number of IOs:                          11
 Number of bonded IOBs:                  11  out of    232     4%  

Specific Feature Utilization:
 Number of BUFG/BUFGCTRLs:                1  out of     16     6%  

---------------------------
Partition Resource Summary:
---------------------------

  No Partitions were found in this design.

---------------------------


=========================================================================
Timing Report

NOTE: THESE TIMING NUMBERS ARE ONLY A SYNTHESIS ESTIMATE.
      FOR ACCURATE TIMING INFORMATION PLEASE REFER TO THE TRACE REPORT
      GENERATED AFTER PLACE-and-ROUTE.

Clock Information:
------------------
-----------------------------------+------------------------+-------+
Clock Signal                       | Clock buffer(FF name)  | Load  |
-----------------------------------+------------------------+-------+
clk                                | BUFGP                  | 7     |
-----------------------------------+------------------------+-------+

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 2.712ns (Maximum Frequency: 368.745MHz)
   Minimum input arrival time before clock: 3.252ns
   Maximum output required time after clock: 3.820ns
   Maximum combinational path delay: No path found

Timing Details:
---------------
All values displayed in nanoseconds (ns)

=========================================================================
Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 2.712ns (frequency: 368.745MHz)
  Total number of paths / destination ports: 43 / 7
-------------------------------------------------------------------------
Delay:               2.712ns (Levels of Logic = 2)
  Source:            cnt_out_2 (FF)
  Destination:       out (FF)
  Source Clock:      clk rising
  Destination Clock: clk rising

  Data Path: cnt_out_2 to out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   1.138  cnt_out_2 (cnt_out_2)
     LUT6:I0->O            2   0.203   0.617  cnt_out[6]_GND_1_o_LessThan_3_o_inv_inv11 (cnt_out[6]_GND_1_o_LessThan_3_o_inv_inv)
     LUT2:I1->O            1   0.205   0.000  Mmux_GND_1_o_cnt_out[6]_MUX_15_o11 (GND_1_o_cnt_out[6]_MUX_15_o)
     FDCE:D                    0.102          out
    ----------------------------------------
    Total                      2.712ns (0.957ns logic, 1.755ns route)
                                       (35.3% logic, 64.7% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'clk'
  Total number of paths / destination ports: 16 / 15
-------------------------------------------------------------------------
Offset:              3.252ns (Levels of Logic = 2)
  Source:            reset (PAD)
  Destination:       cnt_out_0 (FF)
  Destination Clock: clk rising

  Data Path: reset to cnt_out_0
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O             3   1.222   0.650  reset_IBUF (reset_IBUF)
     INV:I->O              6   0.206   0.744  GND_1_o_GND_1_o_AND_1_o1_INV_0 (GND_1_o_GND_1_o_AND_1_o)
     FDCE:CLR                  0.430          cnt_out_0
    ----------------------------------------
    Total                      3.252ns (1.858ns logic, 1.394ns route)
                                       (57.1% logic, 42.9% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'clk'
  Total number of paths / destination ports: 7 / 7
-------------------------------------------------------------------------
Offset:              3.820ns (Levels of Logic = 1)
  Source:            cnt_out_0 (FF)
  Destination:       cnt_out<0> (PAD)
  Source Clock:      clk rising

  Data Path: cnt_out_0 to cnt_out<0>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             8   0.447   0.802  cnt_out_0 (cnt_out_0)
     OBUF:I->O                 2.571          cnt_out_0_OBUF (cnt_out<0>)
    ----------------------------------------
    Total                      3.820ns (3.018ns logic, 0.802ns route)
                                       (79.0% logic, 21.0% route)

=========================================================================

Cross Clock Domains Report:
--------------------------

Clock to Setup on destination clock clk
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
clk            |    2.712|         |         |         |
---------------+---------+---------+---------+---------+

=========================================================================


Total REAL time to Xst completion: 8.00 secs
Total CPU time to Xst completion: 7.66 secs
 
--> 

Total memory usage is 4510308 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    4 (   0 filtered)
Number of infos    :    0 (   0 filtered)
```  

- **RT Circuite**  

![RT_2](https://user-images.githubusercontent.com/60509979/81445894-0648b300-918f-11ea-8842-fc2e49237dd2.png)


## Day Counter  

- **Synthesis Report** 

```
Release 14.7 - xst P.20131013 (nt64)
Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--> Parameter TMPDIR set to xst/projnav.tmp


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.08 secs
 
--> Parameter xsthdpdir set to xst


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.08 secs
 
--> Reading design: DayCounter.prj

TABLE OF CONTENTS
  1) Synthesis Options Summary
  2) HDL Parsing
  3) HDL Elaboration
  4) HDL Synthesis
       4.1) HDL Synthesis Report
  5) Advanced HDL Synthesis
       5.1) Advanced HDL Synthesis Report
  6) Low Level Synthesis
  7) Partition Report
  8) Design Summary
       8.1) Primitive and Black Box Usage
       8.2) Device utilization summary
       8.3) Partition Resource Summary
       8.4) Timing Report
            8.4.1) Clock Information
            8.4.2) Asynchronous Control Signals Information
            8.4.3) Timing Summary
            8.4.4) Timing Details
            8.4.5) Cross Clock Domains Report


=========================================================================
*                      Synthesis Options Summary                        *
=========================================================================
---- Source Parameters
Input File Name                    : "DayCounter.prj"
Ignore Synthesis Constraint File   : NO

---- Target Parameters
Output File Name                   : "DayCounter"
Output Format                      : NGC
Target Device                      : xc6slx16-3-csg324

---- Source Options
Top Module Name                    : DayCounter
Automatic FSM Extraction           : YES
FSM Encoding Algorithm             : Auto
Safe Implementation                : No
FSM Style                          : LUT
RAM Extraction                     : Yes
RAM Style                          : Auto
ROM Extraction                     : Yes
Shift Register Extraction          : YES
ROM Style                          : Auto
Resource Sharing                   : YES
Asynchronous To Synchronous        : NO
Shift Register Minimum Size        : 2
Use DSP Block                      : Auto
Automatic Register Balancing       : No

---- Target Options
LUT Combining                      : Auto
Reduce Control Sets                : Auto
Add IO Buffers                     : YES
Global Maximum Fanout              : 100000
Add Generic Clock Buffer(BUFG)     : 16
Register Duplication               : YES
Optimize Instantiated Primitives   : NO
Use Clock Enable                   : Auto
Use Synchronous Set                : Auto
Use Synchronous Reset              : Auto
Pack IO Registers into IOBs        : Auto
Equivalent register Removal        : YES

---- General Options
Optimization Goal                  : Speed
Optimization Effort                : 1
Power Reduction                    : NO
Keep Hierarchy                     : No
Netlist Hierarchy                  : As_Optimized
RTL Output                         : Yes
Global Optimization                : AllClockNets
Read Cores                         : YES
Write Timing Constraints           : NO
Cross Clock Analysis               : NO
Hierarchy Separator                : /
Bus Delimiter                      : <>
Case Specifier                     : Maintain
Slice Utilization Ratio            : 100
BRAM Utilization Ratio             : 100
DSP48 Utilization Ratio            : 100
Auto BRAM Packing                  : NO
Slice Utilization Ratio Delta      : 5

=========================================================================


=========================================================================
*                          HDL Parsing                                  *
=========================================================================
Analyzing Verilog file "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" into library work
Parsing module <PCounter>.
Analyzing Verilog file "C:\Users\msaee\Documents\ISE14.7\Q1_1\DayCounter.v" into library work
Parsing module <DayCounter>.

=========================================================================
*                            HDL Elaboration                            *
=========================================================================

Elaborating module <DayCounter>.

Elaborating module <PCounter(MAX_SIZE=6,p=59)>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" Line 22: Result of 7-bit expression is truncated to fit in 6-bit target.

Elaborating module <PCounter(MAX_SIZE=5,p=23)>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" Line 22: Result of 6-bit expression is truncated to fit in 5-bit target.

Elaborating module <PCounter(MAX_SIZE=5,p=29)>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" Line 22: Result of 6-bit expression is truncated to fit in 5-bit target.

Elaborating module <PCounter(MAX_SIZE=4,p=11)>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" Line 22: Result of 5-bit expression is truncated to fit in 4-bit target.

Elaborating module <PCounter(MAX_SIZE=7,p=99)>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v" Line 22: Result of 8-bit expression is truncated to fit in 7-bit target.
WARNING:HDLCompiler:1127 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\DayCounter.v" Line 36: Assignment to year_out ignored, since the identifier is never used

=========================================================================
*                           HDL Synthesis                               *
=========================================================================

Synthesizing Unit <DayCounter>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\DayCounter.v".
INFO:Xst:3210 - "C:\Users\msaee\Documents\ISE14.7\Q1_1\DayCounter.v" line 36: Output port <out> of the instance <U5> is unconnected or connected to loadless signal.
    Summary:
	no macro.
Unit <DayCounter> synthesized.

Synthesizing Unit <PCounter_1>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v".
        MAX_SIZE = 6
        p = 6'b111011
    Found 1-bit register for signal <out>.
    Found 6-bit register for signal <cnt_out>.
    Found 6-bit adder for signal <cnt_out[5]_GND_2_o_add_3_OUT> created at line 22.
    Found 6-bit comparator greater for signal <cnt_out[5]_PWR_2_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   7 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter_1> synthesized.

Synthesizing Unit <PCounter_2>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v".
        MAX_SIZE = 5
        p = 5'b10111
    Found 1-bit register for signal <out>.
    Found 5-bit register for signal <cnt_out>.
    Found 5-bit adder for signal <cnt_out[4]_GND_3_o_add_3_OUT> created at line 22.
    Found 5-bit comparator greater for signal <cnt_out[4]_PWR_3_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   6 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter_2> synthesized.

Synthesizing Unit <PCounter_3>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v".
        MAX_SIZE = 5
        p = 5'b11101
    Found 1-bit register for signal <out>.
    Found 5-bit register for signal <cnt_out>.
    Found 5-bit adder for signal <cnt_out[4]_GND_4_o_add_3_OUT> created at line 22.
    Found 5-bit comparator greater for signal <cnt_out[4]_PWR_4_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   6 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter_3> synthesized.

Synthesizing Unit <PCounter_4>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v".
        MAX_SIZE = 4
        p = 4'b1011
    Found 1-bit register for signal <out>.
    Found 4-bit register for signal <cnt_out>.
    Found 4-bit adder for signal <cnt_out[3]_GND_5_o_add_3_OUT> created at line 22.
    Found 4-bit comparator greater for signal <cnt_out[3]_PWR_5_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   5 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter_4> synthesized.

Synthesizing Unit <PCounter_5>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Q1_1\PCounter.v".
        MAX_SIZE = 7
        p = 7'b1100011
    Found 1-bit register for signal <out>.
    Found 7-bit register for signal <cnt_out>.
    Found 7-bit adder for signal <cnt_out[6]_GND_6_o_add_3_OUT> created at line 22.
    Found 7-bit comparator greater for signal <cnt_out[6]_PWR_6_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   8 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter_5> synthesized.

=========================================================================
HDL Synthesis Report

Macro Statistics
# Adders/Subtractors                                   : 6
 4-bit adder                                           : 1
 5-bit adder                                           : 2
 6-bit adder                                           : 2
 7-bit adder                                           : 1
# Registers                                            : 12
 1-bit register                                        : 6
 4-bit register                                        : 1
 5-bit register                                        : 2
 6-bit register                                        : 2
 7-bit register                                        : 1
# Comparators                                          : 6
 4-bit comparator greater                              : 1
 5-bit comparator greater                              : 2
 6-bit comparator greater                              : 2
 7-bit comparator greater                              : 1
# Multiplexers                                         : 18
 1-bit 2-to-1 multiplexer                              : 12
 4-bit 2-to-1 multiplexer                              : 1
 5-bit 2-to-1 multiplexer                              : 2
 6-bit 2-to-1 multiplexer                              : 2
 7-bit 2-to-1 multiplexer                              : 1

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================


Synthesizing (advanced) Unit <PCounter_1>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter_1> synthesized (advanced).

Synthesizing (advanced) Unit <PCounter_2>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter_2> synthesized (advanced).

Synthesizing (advanced) Unit <PCounter_3>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter_3> synthesized (advanced).

Synthesizing (advanced) Unit <PCounter_4>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter_4> synthesized (advanced).

Synthesizing (advanced) Unit <PCounter_5>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter_5> synthesized (advanced).

=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# Counters                                             : 6
 4-bit up counter                                      : 1
 5-bit up counter                                      : 2
 6-bit up counter                                      : 2
 7-bit up counter                                      : 1
# Registers                                            : 6
 Flip-Flops                                            : 6
# Comparators                                          : 6
 4-bit comparator greater                              : 1
 5-bit comparator greater                              : 2
 6-bit comparator greater                              : 2
 7-bit comparator greater                              : 1
# Multiplexers                                         : 12
 1-bit 2-to-1 multiplexer                              : 12

=========================================================================

=========================================================================
*                         Low Level Synthesis                           *
=========================================================================

Optimizing unit <DayCounter> ...

Optimizing unit <PCounter_1> ...

Optimizing unit <PCounter_2> ...

Optimizing unit <PCounter_3> ...

Optimizing unit <PCounter_4> ...

Optimizing unit <PCounter_5> ...
WARNING:Xst:2677 - Node <U5/out> of sequential type is unconnected in block <DayCounter>.

Mapping all equations...
Building and optimizing final netlist ...
Found area constraint ratio of 100 (+ 5) on block DayCounter, actual ratio is 0.

Final Macro Processing ...

=========================================================================
Final Register Report

Macro Statistics
# Registers                                            : 38
 Flip-Flops                                            : 38

=========================================================================

=========================================================================
*                           Partition Report                            *
=========================================================================

Partition Implementation Status
-------------------------------

  No Partitions were found in this design.

-------------------------------

=========================================================================
*                            Design Summary                             *
=========================================================================

Top Level Output File Name         : DayCounter.ngc

Primitive and Black Box Usage:
------------------------------
# BELS                             : 48
#      INV                         : 1
#      LUT2                        : 4
#      LUT3                        : 2
#      LUT4                        : 6
#      LUT5                        : 13
#      LUT6                        : 20
#      MUXF7                       : 2
# FlipFlops/Latches                : 38
#      FDCE                        : 38
# Clock Buffers                    : 1
#      BUFGP                       : 1
# IO Buffers                       : 35
#      IBUF                        : 2
#      OBUF                        : 33

Device utilization summary:
---------------------------

Selected Device : 6slx16csg324-3 


Slice Logic Utilization: 
 Number of Slice Registers:              38  out of  18224     0%  
 Number of Slice LUTs:                   46  out of   9112     0%  
    Number used as Logic:                46  out of   9112     0%  

Slice Logic Distribution: 
 Number of LUT Flip Flop pairs used:     46
   Number with an unused Flip Flop:       8  out of     46    17%  
   Number with an unused LUT:             0  out of     46     0%  
   Number of fully used LUT-FF pairs:    38  out of     46    82%  
   Number of unique control sets:        11

IO Utilization: 
 Number of IOs:                          36
 Number of bonded IOBs:                  36  out of    232    15%  

Specific Feature Utilization:
 Number of BUFG/BUFGCTRLs:                1  out of     16     6%  

---------------------------
Partition Resource Summary:
---------------------------

  No Partitions were found in this design.

---------------------------


=========================================================================
Timing Report

NOTE: THESE TIMING NUMBERS ARE ONLY A SYNTHESIS ESTIMATE.
      FOR ACCURATE TIMING INFORMATION PLEASE REFER TO THE TRACE REPORT
      GENERATED AFTER PLACE-and-ROUTE.

Clock Information:
------------------
-----------------------------------+------------------------+-------+
Clock Signal                       | Clock buffer(FF name)  | Load  |
-----------------------------------+------------------------+-------+
U0/out                             | NONE(U1/cnt_out_5)     | 7     |
clk                                | BUFGP                  | 7     |
U1/out                             | NONE(U2/cnt_out_4)     | 6     |
U2/out                             | NONE(U3/cnt_out_4)     | 6     |
U3/out                             | NONE(U4/cnt_out_3)     | 5     |
U4/out                             | NONE(U5/cnt_out_6)     | 7     |
-----------------------------------+------------------------+-------+
INFO:Xst:2169 - HDL ADVISOR - Some clock signals were not automatically buffered by XST with BUFG/BUFR resources. Please use the buffer_type constraint in order to insert these buffers to the clock signals to help prevent skew problems.

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 2.614ns (Maximum Frequency: 382.614MHz)
   Minimum input arrival time before clock: 3.963ns
   Maximum output required time after clock: 3.874ns
   Maximum combinational path delay: No path found

Timing Details:
---------------
All values displayed in nanoseconds (ns)

=========================================================================
Timing constraint: Default period analysis for Clock 'U0/out'
  Clock period: 2.414ns (frequency: 414.164MHz)
  Total number of paths / destination ports: 41 / 7
-------------------------------------------------------------------------
Delay:               2.414ns (Levels of Logic = 2)
  Source:            U1/cnt_out_1 (FF)
  Destination:       U1/out (FF)
  Source Clock:      U0/out rising
  Destination Clock: U0/out rising

  Data Path: U1/cnt_out_1 to U1/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   0.878  U1/cnt_out_1 (U1/cnt_out_1)
     LUT2:I0->O            1   0.203   0.580  U1/Mmux_GND_2_o_cnt_out[5]_MUX_13_o1_SW0 (N2)
     LUT6:I5->O            1   0.205   0.000  U1/Mmux_GND_2_o_cnt_out[5]_MUX_13_o1 (U1/GND_2_o_cnt_out[5]_MUX_13_o)
     FDCE:D                    0.102          U1/out
    ----------------------------------------
    Total                      2.414ns (0.957ns logic, 1.457ns route)
                                       (39.6% logic, 60.4% route)

=========================================================================
Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 2.414ns (frequency: 414.164MHz)
  Total number of paths / destination ports: 41 / 7
-------------------------------------------------------------------------
Delay:               2.414ns (Levels of Logic = 2)
  Source:            U0/cnt_out_1 (FF)
  Destination:       U0/out (FF)
  Source Clock:      clk rising
  Destination Clock: clk rising

  Data Path: U0/cnt_out_1 to U0/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   0.878  U0/cnt_out_1 (U0/cnt_out_1)
     LUT2:I0->O            1   0.203   0.580  U0/Mmux_GND_2_o_cnt_out[5]_MUX_13_o1_SW0 (N4)
     LUT6:I5->O            1   0.205   0.000  U0/Mmux_GND_2_o_cnt_out[5]_MUX_13_o1 (U0/GND_2_o_cnt_out[5]_MUX_13_o)
     FDCE:D                    0.102          U0/out
    ----------------------------------------
    Total                      2.414ns (0.957ns logic, 1.457ns route)
                                       (39.6% logic, 60.4% route)

=========================================================================
Timing constraint: Default period analysis for Clock 'U1/out'
  Clock period: 1.890ns (frequency: 529.198MHz)
  Total number of paths / destination ports: 27 / 6
-------------------------------------------------------------------------
Delay:               1.890ns (Levels of Logic = 1)
  Source:            U2/cnt_out_4 (FF)
  Destination:       U2/out (FF)
  Source Clock:      U1/out rising
  Destination Clock: U1/out rising

  Data Path: U2/cnt_out_4 to U2/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   1.138  U2/cnt_out_4 (U2/cnt_out_4)
     LUT6:I0->O            1   0.203   0.000  U2/Mmux_GND_3_o_cnt_out[4]_MUX_26_o11 (U2/GND_3_o_cnt_out[4]_MUX_26_o)
     FDCE:D                    0.102          U2/out
    ----------------------------------------
    Total                      1.890ns (0.752ns logic, 1.138ns route)
                                       (39.8% logic, 60.2% route)

=========================================================================
Timing constraint: Default period analysis for Clock 'U2/out'
  Clock period: 1.890ns (frequency: 529.198MHz)
  Total number of paths / destination ports: 30 / 6
-------------------------------------------------------------------------
Delay:               1.890ns (Levels of Logic = 1)
  Source:            U3/cnt_out_2 (FF)
  Destination:       U3/out (FF)
  Source Clock:      U2/out rising
  Destination Clock: U2/out rising

  Data Path: U3/cnt_out_2 to U3/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   1.138  U3/cnt_out_2 (U3/cnt_out_2)
     LUT6:I0->O            1   0.203   0.000  U3/Mmux_GND_4_o_cnt_out[4]_MUX_29_o11 (U3/GND_4_o_cnt_out[4]_MUX_29_o)
     FDCE:D                    0.102          U3/out
    ----------------------------------------
    Total                      1.890ns (0.752ns logic, 1.138ns route)
                                       (39.8% logic, 60.2% route)

=========================================================================
Timing constraint: Default period analysis for Clock 'U3/out'
  Clock period: 1.841ns (frequency: 543.257MHz)
  Total number of paths / destination ports: 19 / 5
-------------------------------------------------------------------------
Delay:               1.841ns (Levels of Logic = 1)
  Source:            U4/cnt_out_3 (FF)
  Destination:       U4/out (FF)
  Source Clock:      U3/out rising
  Destination Clock: U3/out rising

  Data Path: U4/cnt_out_3 to U4/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             6   0.447   1.089  U4/cnt_out_3 (U4/cnt_out_3)
     LUT5:I0->O            1   0.203   0.000  U4/Mmux_GND_5_o_cnt_out[3]_MUX_40_o11 (U4/GND_5_o_cnt_out[3]_MUX_40_o)
     FDCE:D                    0.102          U4/out
    ----------------------------------------
    Total                      1.841ns (0.752ns logic, 1.089ns route)
                                       (40.9% logic, 59.1% route)

=========================================================================
Timing constraint: Default period analysis for Clock 'U4/out'
  Clock period: 2.614ns (frequency: 382.614MHz)
  Total number of paths / destination ports: 56 / 7
-------------------------------------------------------------------------
Delay:               2.614ns (Levels of Logic = 2)
  Source:            U5/cnt_out_3 (FF)
  Destination:       U5/cnt_out_4 (FF)
  Source Clock:      U4/out rising
  Destination Clock: U4/out rising

  Data Path: U5/cnt_out_3 to U5/cnt_out_4
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             9   0.447   1.077  U5/cnt_out_3 (U5/cnt_out_3)
     LUT4:I0->O            1   0.203   0.580  U5/Mcount_cnt_out_xor<4>121 (U5/Mcount_cnt_out_xor<4>12)
     LUT4:I3->O            1   0.205   0.000  U5/Mcount_cnt_out_xor<4>11 (U5/Mcount_cnt_out4)
     FDCE:D                    0.102          U5/cnt_out_4
    ----------------------------------------
    Total                      2.614ns (0.957ns logic, 1.657ns route)
                                       (36.6% logic, 63.4% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'U0/out'
  Total number of paths / destination ports: 16 / 15
-------------------------------------------------------------------------
Offset:              3.963ns (Levels of Logic = 2)
  Source:            enable (PAD)
  Destination:       U1/out (FF)
  Destination Clock: U0/out rising

  Data Path: enable to U1/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            39   1.222   1.392  enable_IBUF (enable_IBUF)
     LUT2:I1->O            5   0.205   0.714  U1/Mmux_GND_2_o_GND_2_o_MUX_14_o11 (U1/GND_2_o_GND_2_o_MUX_14_o)
     FDCE:CLR                  0.430          U1/out
    ----------------------------------------
    Total                      3.963ns (1.857ns logic, 2.106ns route)
                                       (46.9% logic, 53.1% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'clk'
  Total number of paths / destination ports: 16 / 15
-------------------------------------------------------------------------
Offset:              3.963ns (Levels of Logic = 2)
  Source:            enable (PAD)
  Destination:       U0/out (FF)
  Destination Clock: clk rising

  Data Path: enable to U0/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            39   1.222   1.392  enable_IBUF (enable_IBUF)
     LUT2:I1->O            5   0.205   0.714  U1/Mmux_GND_2_o_GND_2_o_MUX_14_o11 (U1/GND_2_o_GND_2_o_MUX_14_o)
     FDCE:CLR                  0.430          U0/out
    ----------------------------------------
    Total                      3.963ns (1.857ns logic, 2.106ns route)
                                       (46.9% logic, 53.1% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'U1/out'
  Total number of paths / destination ports: 14 / 13
-------------------------------------------------------------------------
Offset:              3.963ns (Levels of Logic = 2)
  Source:            enable (PAD)
  Destination:       U2/out (FF)
  Destination Clock: U1/out rising

  Data Path: enable to U2/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            39   1.222   1.392  enable_IBUF (enable_IBUF)
     LUT2:I1->O            5   0.205   0.714  U1/Mmux_GND_2_o_GND_2_o_MUX_14_o11 (U1/GND_2_o_GND_2_o_MUX_14_o)
     FDCE:CLR                  0.430          U2/out
    ----------------------------------------
    Total                      3.963ns (1.857ns logic, 2.106ns route)
                                       (46.9% logic, 53.1% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'U2/out'
  Total number of paths / destination ports: 14 / 13
-------------------------------------------------------------------------
Offset:              3.963ns (Levels of Logic = 2)
  Source:            enable (PAD)
  Destination:       U3/out (FF)
  Destination Clock: U2/out rising

  Data Path: enable to U3/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            39   1.222   1.392  enable_IBUF (enable_IBUF)
     LUT2:I1->O            5   0.205   0.714  U1/Mmux_GND_2_o_GND_2_o_MUX_14_o11 (U1/GND_2_o_GND_2_o_MUX_14_o)
     FDCE:CLR                  0.430          U3/out
    ----------------------------------------
    Total                      3.963ns (1.857ns logic, 2.106ns route)
                                       (46.9% logic, 53.1% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'U3/out'
  Total number of paths / destination ports: 12 / 11
-------------------------------------------------------------------------
Offset:              3.963ns (Levels of Logic = 2)
  Source:            enable (PAD)
  Destination:       U4/out (FF)
  Destination Clock: U3/out rising

  Data Path: enable to U4/out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            39   1.222   1.392  enable_IBUF (enable_IBUF)
     LUT2:I1->O            5   0.205   0.714  U1/Mmux_GND_2_o_GND_2_o_MUX_14_o11 (U1/GND_2_o_GND_2_o_MUX_14_o)
     FDCE:CLR                  0.430          U4/out
    ----------------------------------------
    Total                      3.963ns (1.857ns logic, 2.106ns route)
                                       (46.9% logic, 53.1% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'U4/out'
  Total number of paths / destination ports: 14 / 14
-------------------------------------------------------------------------
Offset:              3.936ns (Levels of Logic = 2)
  Source:            reset (PAD)
  Destination:       U5/cnt_out_6 (FF)
  Destination Clock: U4/out rising

  Data Path: reset to U5/cnt_out_6
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O             7   1.222   0.773  reset_IBUF (reset_IBUF)
     INV:I->O             33   0.206   1.305  U1/GND_2_o_GND_2_o_AND_1_o1_INV_0 (U1/GND_2_o_GND_2_o_AND_1_o)
     FDCE:CLR                  0.430          U5/cnt_out_0
    ----------------------------------------
    Total                      3.936ns (1.858ns logic, 2.078ns route)
                                       (47.2% logic, 52.8% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'clk'
  Total number of paths / destination ports: 6 / 6
-------------------------------------------------------------------------
Offset:              3.820ns (Levels of Logic = 1)
  Source:            U0/cnt_out_5 (FF)
  Destination:       second<5> (PAD)
  Source Clock:      clk rising

  Data Path: U0/cnt_out_5 to second<5>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             8   0.447   0.802  U0/cnt_out_5 (U0/cnt_out_5)
     OBUF:I->O                 2.571          second_5_OBUF (second<5>)
    ----------------------------------------
    Total                      3.820ns (3.018ns logic, 0.802ns route)
                                       (79.0% logic, 21.0% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'U0/out'
  Total number of paths / destination ports: 6 / 6
-------------------------------------------------------------------------
Offset:              3.820ns (Levels of Logic = 1)
  Source:            U1/cnt_out_5 (FF)
  Destination:       minute<5> (PAD)
  Source Clock:      U0/out rising

  Data Path: U1/cnt_out_5 to minute<5>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             8   0.447   0.802  U1/cnt_out_5 (U1/cnt_out_5)
     OBUF:I->O                 2.571          minute_5_OBUF (minute<5>)
    ----------------------------------------
    Total                      3.820ns (3.018ns logic, 0.802ns route)
                                       (79.0% logic, 21.0% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'U1/out'
  Total number of paths / destination ports: 5 / 5
-------------------------------------------------------------------------
Offset:              3.791ns (Levels of Logic = 1)
  Source:            U2/cnt_out_4 (FF)
  Destination:       hour<4> (PAD)
  Source Clock:      U1/out rising

  Data Path: U2/cnt_out_4 to hour<4>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   0.773  U2/cnt_out_4 (U2/cnt_out_4)
     OBUF:I->O                 2.571          hour_4_OBUF (hour<4>)
    ----------------------------------------
    Total                      3.791ns (3.018ns logic, 0.773ns route)
                                       (79.6% logic, 20.4% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'U2/out'
  Total number of paths / destination ports: 5 / 5
-------------------------------------------------------------------------
Offset:              3.791ns (Levels of Logic = 1)
  Source:            U3/cnt_out_4 (FF)
  Destination:       day<4> (PAD)
  Source Clock:      U2/out rising

  Data Path: U3/cnt_out_4 to day<4>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   0.773  U3/cnt_out_4 (U3/cnt_out_4)
     OBUF:I->O                 2.571          day_4_OBUF (day<4>)
    ----------------------------------------
    Total                      3.791ns (3.018ns logic, 0.773ns route)
                                       (79.6% logic, 20.4% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'U3/out'
  Total number of paths / destination ports: 4 / 4
-------------------------------------------------------------------------
Offset:              3.762ns (Levels of Logic = 1)
  Source:            U4/cnt_out_3 (FF)
  Destination:       month<3> (PAD)
  Source Clock:      U3/out rising

  Data Path: U4/cnt_out_3 to month<3>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             6   0.447   0.744  U4/cnt_out_3 (U4/cnt_out_3)
     OBUF:I->O                 2.571          month_3_OBUF (month<3>)
    ----------------------------------------
    Total                      3.762ns (3.018ns logic, 0.744ns route)
                                       (80.2% logic, 19.8% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'U4/out'
  Total number of paths / destination ports: 7 / 7
-------------------------------------------------------------------------
Offset:              3.874ns (Levels of Logic = 1)
  Source:            U5/cnt_out_2 (FF)
  Destination:       year<2> (PAD)
  Source Clock:      U4/out rising

  Data Path: U5/cnt_out_2 to year<2>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q            10   0.447   0.856  U5/cnt_out_2 (U5/cnt_out_2)
     OBUF:I->O                 2.571          year_2_OBUF (year<2>)
    ----------------------------------------
    Total                      3.874ns (3.018ns logic, 0.856ns route)
                                       (77.9% logic, 22.1% route)

=========================================================================

Cross Clock Domains Report:
--------------------------

Clock to Setup on destination clock U0/out
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
U0/out         |    2.414|         |         |         |
---------------+---------+---------+---------+---------+

Clock to Setup on destination clock U1/out
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
U1/out         |    1.890|         |         |         |
---------------+---------+---------+---------+---------+

Clock to Setup on destination clock U2/out
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
U2/out         |    1.890|         |         |         |
---------------+---------+---------+---------+---------+

Clock to Setup on destination clock U3/out
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
U3/out         |    1.841|         |         |         |
---------------+---------+---------+---------+---------+

Clock to Setup on destination clock U4/out
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
U4/out         |    2.614|         |         |         |
---------------+---------+---------+---------+---------+

Clock to Setup on destination clock clk
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
clk            |    2.414|         |         |         |
---------------+---------+---------+---------+---------+

=========================================================================


Total REAL time to Xst completion: 5.00 secs
Total CPU time to Xst completion: 5.65 secs
 
--> 

Total memory usage is 4510568 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    7 (   0 filtered)
Number of infos    :    2 (   0 filtered)

```
- **RT Circuite**  

![RT_2](https://user-images.githubusercontent.com/60509979/81446056-5d4e8800-918f-11ea-8623-63dbf8d91ce5.png)


## Stopwatch  

- **Synthesis Report**  
```
Release 14.7 - xst P.20131013 (nt64)
Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--> Parameter TMPDIR set to xst/projnav.tmp


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.09 secs
 
--> Parameter xsthdpdir set to xst


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.09 secs
 
--> Reading design: PCounter.prj

TABLE OF CONTENTS
  1) Synthesis Options Summary
  2) HDL Parsing
  3) HDL Elaboration
  4) HDL Synthesis
       4.1) HDL Synthesis Report
  5) Advanced HDL Synthesis
       5.1) Advanced HDL Synthesis Report
  6) Low Level Synthesis
  7) Partition Report
  8) Design Summary
       8.1) Primitive and Black Box Usage
       8.2) Device utilization summary
       8.3) Partition Resource Summary
       8.4) Timing Report
            8.4.1) Clock Information
            8.4.2) Asynchronous Control Signals Information
            8.4.3) Timing Summary
            8.4.4) Timing Details
            8.4.5) Cross Clock Domains Report


=========================================================================
*                      Synthesis Options Summary                        *
=========================================================================
---- Source Parameters
Input File Name                    : "PCounter.prj"
Ignore Synthesis Constraint File   : NO

---- Target Parameters
Output File Name                   : "PCounter"
Output Format                      : NGC
Target Device                      : xc6slx16-3-csg324

---- Source Options
Top Module Name                    : PCounter
Automatic FSM Extraction           : YES
FSM Encoding Algorithm             : Auto
Safe Implementation                : No
FSM Style                          : LUT
RAM Extraction                     : Yes
RAM Style                          : Auto
ROM Extraction                     : Yes
Shift Register Extraction          : YES
ROM Style                          : Auto
Resource Sharing                   : YES
Asynchronous To Synchronous        : NO
Shift Register Minimum Size        : 2
Use DSP Block                      : Auto
Automatic Register Balancing       : No

---- Target Options
LUT Combining                      : Auto
Reduce Control Sets                : Auto
Add IO Buffers                     : YES
Global Maximum Fanout              : 100000
Add Generic Clock Buffer(BUFG)     : 16
Register Duplication               : YES
Optimize Instantiated Primitives   : NO
Use Clock Enable                   : Auto
Use Synchronous Set                : Auto
Use Synchronous Reset              : Auto
Pack IO Registers into IOBs        : Auto
Equivalent register Removal        : YES

---- General Options
Optimization Goal                  : Speed
Optimization Effort                : 1
Power Reduction                    : NO
Keep Hierarchy                     : No
Netlist Hierarchy                  : As_Optimized
RTL Output                         : Yes
Global Optimization                : AllClockNets
Read Cores                         : YES
Write Timing Constraints           : NO
Cross Clock Analysis               : NO
Hierarchy Separator                : /
Bus Delimiter                      : <>
Case Specifier                     : Maintain
Slice Utilization Ratio            : 100
BRAM Utilization Ratio             : 100
DSP48 Utilization Ratio            : 100
Auto BRAM Packing                  : NO
Slice Utilization Ratio Delta      : 5

=========================================================================


=========================================================================
*                          HDL Parsing                                  *
=========================================================================
Analyzing Verilog file "C:\Users\msaee\Documents\ISE14.7\Assignment3\PCounter.v" into library work
Parsing module <PCounter>.

=========================================================================
*                            HDL Elaboration                            *
=========================================================================

Elaborating module <PCounter>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Assignment3\PCounter.v" Line 22: Result of 8-bit expression is truncated to fit in 7-bit target.

=========================================================================
*                           HDL Synthesis                               *
=========================================================================

Synthesizing Unit <PCounter>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Assignment3\PCounter.v".
        MAX_SIZE = 7
        p = 7'b0111011
    Found 1-bit register for signal <out>.
    Found 7-bit register for signal <cnt_out>.
    Found 7-bit adder for signal <cnt_out[6]_GND_1_o_add_3_OUT> created at line 22.
    Found 7-bit comparator greater for signal <cnt_out[6]_GND_1_o_LessThan_3_o> created at line 21
    Summary:
	inferred   1 Adder/Subtractor(s).
	inferred   8 D-type flip-flop(s).
	inferred   1 Comparator(s).
	inferred   3 Multiplexer(s).
Unit <PCounter> synthesized.

=========================================================================
HDL Synthesis Report

Macro Statistics
# Adders/Subtractors                                   : 1
 7-bit adder                                           : 1
# Registers                                            : 2
 1-bit register                                        : 1
 7-bit register                                        : 1
# Comparators                                          : 1
 7-bit comparator greater                              : 1
# Multiplexers                                         : 3
 1-bit 2-to-1 multiplexer                              : 2
 7-bit 2-to-1 multiplexer                              : 1

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================


Synthesizing (advanced) Unit <PCounter>.
The following registers are absorbed into counter <cnt_out>: 1 register on signal <cnt_out>.
Unit <PCounter> synthesized (advanced).

=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# Counters                                             : 1
 7-bit up counter                                      : 1
# Registers                                            : 1
 Flip-Flops                                            : 1
# Comparators                                          : 1
 7-bit comparator greater                              : 1
# Multiplexers                                         : 2
 1-bit 2-to-1 multiplexer                              : 2

=========================================================================

=========================================================================
*                         Low Level Synthesis                           *
=========================================================================

Optimizing unit <PCounter> ...
WARNING:Xst:1293 - FF/Latch <cnt_out_6> has a constant value of 0 in block <PCounter>. This FF/Latch will be trimmed during the optimization process.
WARNING:Xst:1293 - FF/Latch <cnt_out_6> has a constant value of 0 in block <PCounter>. This FF/Latch will be trimmed during the optimization process.
WARNING:Xst:1293 - FF/Latch <cnt_out_6> has a constant value of 0 in block <PCounter>. This FF/Latch will be trimmed during the optimization process.

Mapping all equations...
Building and optimizing final netlist ...
Found area constraint ratio of 100 (+ 5) on block PCounter, actual ratio is 0.

Final Macro Processing ...

=========================================================================
Final Register Report

Macro Statistics
# Registers                                            : 7
 Flip-Flops                                            : 7

=========================================================================

=========================================================================
*                           Partition Report                            *
=========================================================================

Partition Implementation Status
-------------------------------

  No Partitions were found in this design.

-------------------------------

=========================================================================
*                            Design Summary                             *
=========================================================================

Top Level Output File Name         : PCounter.ngc

Primitive and Black Box Usage:
------------------------------
# BELS                             : 11
#      GND                         : 1
#      INV                         : 1
#      LUT2                        : 3
#      LUT6                        : 6
# FlipFlops/Latches                : 7
#      FDCE                        : 7
# Clock Buffers                    : 1
#      BUFGP                       : 1
# IO Buffers                       : 10
#      IBUF                        : 2
#      OBUF                        : 8

Device utilization summary:
---------------------------

Selected Device : 6slx16csg324-3 


Slice Logic Utilization: 
 Number of Slice Registers:               7  out of  18224     0%  
 Number of Slice LUTs:                   10  out of   9112     0%  
    Number used as Logic:                10  out of   9112     0%  

Slice Logic Distribution: 
 Number of LUT Flip Flop pairs used:     10
   Number with an unused Flip Flop:       3  out of     10    30%  
   Number with an unused LUT:             0  out of     10     0%  
   Number of fully used LUT-FF pairs:     7  out of     10    70%  
   Number of unique control sets:         2

IO Utilization: 
 Number of IOs:                          11
 Number of bonded IOBs:                  11  out of    232     4%  

Specific Feature Utilization:
 Number of BUFG/BUFGCTRLs:                1  out of     16     6%  

---------------------------
Partition Resource Summary:
---------------------------

  No Partitions were found in this design.

---------------------------


=========================================================================
Timing Report

NOTE: THESE TIMING NUMBERS ARE ONLY A SYNTHESIS ESTIMATE.
      FOR ACCURATE TIMING INFORMATION PLEASE REFER TO THE TRACE REPORT
      GENERATED AFTER PLACE-and-ROUTE.

Clock Information:
------------------
-----------------------------------+------------------------+-------+
Clock Signal                       | Clock buffer(FF name)  | Load  |
-----------------------------------+------------------------+-------+
clk                                | BUFGP                  | 7     |
-----------------------------------+------------------------+-------+

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 2.712ns (Maximum Frequency: 368.745MHz)
   Minimum input arrival time before clock: 3.252ns
   Maximum output required time after clock: 3.820ns
   Maximum combinational path delay: No path found

Timing Details:
---------------
All values displayed in nanoseconds (ns)

=========================================================================
Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 2.712ns (frequency: 368.745MHz)
  Total number of paths / destination ports: 43 / 7
-------------------------------------------------------------------------
Delay:               2.712ns (Levels of Logic = 2)
  Source:            cnt_out_2 (FF)
  Destination:       out (FF)
  Source Clock:      clk rising
  Destination Clock: clk rising

  Data Path: cnt_out_2 to out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             7   0.447   1.138  cnt_out_2 (cnt_out_2)
     LUT6:I0->O            2   0.203   0.617  cnt_out[6]_GND_1_o_LessThan_3_o_inv_inv11 (cnt_out[6]_GND_1_o_LessThan_3_o_inv_inv)
     LUT2:I1->O            1   0.205   0.000  Mmux_GND_1_o_cnt_out[6]_MUX_15_o11 (GND_1_o_cnt_out[6]_MUX_15_o)
     FDCE:D                    0.102          out
    ----------------------------------------
    Total                      2.712ns (0.957ns logic, 1.755ns route)
                                       (35.3% logic, 64.7% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'clk'
  Total number of paths / destination ports: 16 / 15
-------------------------------------------------------------------------
Offset:              3.252ns (Levels of Logic = 2)
  Source:            reset (PAD)
  Destination:       cnt_out_0 (FF)
  Destination Clock: clk rising

  Data Path: reset to cnt_out_0
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O             3   1.222   0.650  reset_IBUF (reset_IBUF)
     INV:I->O              6   0.206   0.744  GND_1_o_GND_1_o_AND_1_o1_INV_0 (GND_1_o_GND_1_o_AND_1_o)
     FDCE:CLR                  0.430          cnt_out_0
    ----------------------------------------
    Total                      3.252ns (1.858ns logic, 1.394ns route)
                                       (57.1% logic, 42.9% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'clk'
  Total number of paths / destination ports: 7 / 7
-------------------------------------------------------------------------
Offset:              3.820ns (Levels of Logic = 1)
  Source:            cnt_out_0 (FF)
  Destination:       cnt_out<0> (PAD)
  Source Clock:      clk rising

  Data Path: cnt_out_0 to cnt_out<0>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDCE:C->Q             8   0.447   0.802  cnt_out_0 (cnt_out_0)
     OBUF:I->O                 2.571          cnt_out_0_OBUF (cnt_out<0>)
    ----------------------------------------
    Total                      3.820ns (3.018ns logic, 0.802ns route)
                                       (79.0% logic, 21.0% route)

=========================================================================

Cross Clock Domains Report:
--------------------------

Clock to Setup on destination clock clk
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
clk            |    2.712|         |         |         |
---------------+---------+---------+---------+---------+

=========================================================================


Total REAL time to Xst completion: 6.00 secs
Total CPU time to Xst completion: 5.91 secs
 
--> 

Total memory usage is 4509608 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    4 (   0 filtered)
Number of infos    :    0 (   0 filtered)
```

- **RT Circuite**  

![RT_2](https://user-images.githubusercontent.com/60509979/81446203-a9013180-918f-11ea-88fe-fc1a23f70798.png)


## PWM Generator 

- **Synthesis Report**  
```
Release 14.7 - xst P.20131013 (nt64)
Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--> Parameter TMPDIR set to xst/projnav.tmp


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.10 secs
 
--> Parameter xsthdpdir set to xst


Total REAL time to Xst completion: 0.00 secs
Total CPU time to Xst completion: 0.10 secs
 
--> Reading design: pwm_generator.prj

TABLE OF CONTENTS
  1) Synthesis Options Summary
  2) HDL Parsing
  3) HDL Elaboration
  4) HDL Synthesis
       4.1) HDL Synthesis Report
  5) Advanced HDL Synthesis
       5.1) Advanced HDL Synthesis Report
  6) Low Level Synthesis
  7) Partition Report
  8) Design Summary
       8.1) Primitive and Black Box Usage
       8.2) Device utilization summary
       8.3) Partition Resource Summary
       8.4) Timing Report
            8.4.1) Clock Information
            8.4.2) Asynchronous Control Signals Information
            8.4.3) Timing Summary
            8.4.4) Timing Details
            8.4.5) Cross Clock Domains Report


=========================================================================
*                      Synthesis Options Summary                        *
=========================================================================
---- Source Parameters
Input File Name                    : "pwm_generator.prj"
Ignore Synthesis Constraint File   : NO

---- Target Parameters
Output File Name                   : "pwm_generator"
Output Format                      : NGC
Target Device                      : xc6slx16-3-csg324

---- Source Options
Top Module Name                    : pwm_generator
Automatic FSM Extraction           : YES
FSM Encoding Algorithm             : Auto
Safe Implementation                : No
FSM Style                          : LUT
RAM Extraction                     : Yes
RAM Style                          : Auto
ROM Extraction                     : Yes
Shift Register Extraction          : YES
ROM Style                          : Auto
Resource Sharing                   : YES
Asynchronous To Synchronous        : NO
Shift Register Minimum Size        : 2
Use DSP Block                      : Auto
Automatic Register Balancing       : No

---- Target Options
LUT Combining                      : Auto
Reduce Control Sets                : Auto
Add IO Buffers                     : YES
Global Maximum Fanout              : 100000
Add Generic Clock Buffer(BUFG)     : 16
Register Duplication               : YES
Optimize Instantiated Primitives   : NO
Use Clock Enable                   : Auto
Use Synchronous Set                : Auto
Use Synchronous Reset              : Auto
Pack IO Registers into IOBs        : Auto
Equivalent register Removal        : YES

---- General Options
Optimization Goal                  : Speed
Optimization Effort                : 1
Power Reduction                    : NO
Keep Hierarchy                     : No
Netlist Hierarchy                  : As_Optimized
RTL Output                         : Yes
Global Optimization                : AllClockNets
Read Cores                         : YES
Write Timing Constraints           : NO
Cross Clock Analysis               : NO
Hierarchy Separator                : /
Bus Delimiter                      : <>
Case Specifier                     : Maintain
Slice Utilization Ratio            : 100
BRAM Utilization Ratio             : 100
DSP48 Utilization Ratio            : 100
Auto BRAM Packing                  : NO
Slice Utilization Ratio Delta      : 5

=========================================================================


=========================================================================
*                          HDL Parsing                                  *
=========================================================================
Analyzing Verilog file "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_generator.v" into library work
Parsing module <pwm_generator>.

=========================================================================
*                            HDL Elaboration                            *
=========================================================================

Elaborating module <pwm_generator>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_generator.v" Line 42: Result of 32-bit expression is truncated to fit in 16-bit target.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_generator.v" Line 54: Result of 32-bit expression is truncated to fit in 16-bit target.

=========================================================================
*                           HDL Synthesis                               *
=========================================================================

Synthesizing Unit <pwm_generator>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_generator.v".
    Found 16-bit register for signal <HighCounter>.
    Found 1-bit register for signal <turn>.
    Found 16-bit register for signal <Low>.
    Found 16-bit register for signal <LowCounter>.
    Found 1-bit register for signal <pwm_out>.
    Found 16-bit register for signal <High>.
    Found 16-bit subtractor for signal <GND_1_o_GND_1_o_sub_8_OUT<15:0>> created at line 42.
    Found 16-bit subtractor for signal <GND_1_o_GND_1_o_sub_13_OUT<15:0>> created at line 54.
    Summary:
	inferred   2 Adder/Subtractor(s).
	inferred  66 D-type flip-flop(s).
	inferred   5 Multiplexer(s).
Unit <pwm_generator> synthesized.

=========================================================================
HDL Synthesis Report

Macro Statistics
# Adders/Subtractors                                   : 2
 16-bit subtractor                                     : 2
# Registers                                            : 6
 1-bit register                                        : 2
 16-bit register                                       : 4
# Multiplexers                                         : 5
 1-bit 2-to-1 multiplexer                              : 1
 16-bit 2-to-1 multiplexer                             : 4

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================


=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# Adders/Subtractors                                   : 2
 16-bit subtractor                                     : 2
# Registers                                            : 66
 Flip-Flops                                            : 66
# Multiplexers                                         : 5
 1-bit 2-to-1 multiplexer                              : 1
 16-bit 2-to-1 multiplexer                             : 4

=========================================================================

=========================================================================
*                         Low Level Synthesis                           *
=========================================================================

Optimizing unit <pwm_generator> ...

Mapping all equations...
Building and optimizing final netlist ...
Found area constraint ratio of 100 (+ 5) on block pwm_generator, actual ratio is 1.

Final Macro Processing ...

=========================================================================
Final Register Report

Macro Statistics
# Registers                                            : 66
 Flip-Flops                                            : 66

=========================================================================

=========================================================================
*                           Partition Report                            *
=========================================================================

Partition Implementation Status
-------------------------------

  No Partitions were found in this design.

-------------------------------

=========================================================================
*                            Design Summary                             *
=========================================================================

Top Level Output File Name         : pwm_generator.ngc

Primitive and Black Box Usage:
------------------------------
# BELS                             : 141
#      GND                         : 1
#      INV                         : 30
#      LUT1                        : 2
#      LUT2                        : 3
#      LUT3                        : 1
#      LUT4                        : 1
#      LUT5                        : 32
#      LUT6                        : 8
#      MUXCY                       : 30
#      VCC                         : 1
#      XORCY                       : 32
# FlipFlops/Latches                : 66
#      FD                          : 2
#      FDE                         : 64
# Clock Buffers                    : 1
#      BUFGP                       : 1
# IO Buffers                       : 19
#      IBUF                        : 18
#      OBUF                        : 1

Device utilization summary:
---------------------------

Selected Device : 6slx16csg324-3 


Slice Logic Utilization: 
 Number of Slice Registers:              66  out of  18224     0%  
 Number of Slice LUTs:                   77  out of   9112     0%  
    Number used as Logic:                77  out of   9112     0%  

Slice Logic Distribution: 
 Number of LUT Flip Flop pairs used:    109
   Number with an unused Flip Flop:      43  out of    109    39%  
   Number with an unused LUT:            32  out of    109    29%  
   Number of fully used LUT-FF pairs:    34  out of    109    31%  
   Number of unique control sets:         5

IO Utilization: 
 Number of IOs:                          20
 Number of bonded IOBs:                  20  out of    232     8%  

Specific Feature Utilization:
 Number of BUFG/BUFGCTRLs:                1  out of     16     6%  

---------------------------
Partition Resource Summary:
---------------------------

  No Partitions were found in this design.

---------------------------


=========================================================================
Timing Report

NOTE: THESE TIMING NUMBERS ARE ONLY A SYNTHESIS ESTIMATE.
      FOR ACCURATE TIMING INFORMATION PLEASE REFER TO THE TRACE REPORT
      GENERATED AFTER PLACE-and-ROUTE.

Clock Information:
------------------
-----------------------------------+------------------------+-------+
Clock Signal                       | Clock buffer(FF name)  | Load  |
-----------------------------------+------------------------+-------+
clk                                | BUFGP                  | 66    |
-----------------------------------+------------------------+-------+

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 3.930ns (Maximum Frequency: 254.430MHz)
   Minimum input arrival time before clock: 3.905ns
   Maximum output required time after clock: 3.597ns
   Maximum combinational path delay: No path found

Timing Details:
---------------
All values displayed in nanoseconds (ns)

=========================================================================
Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 3.930ns (frequency: 254.430MHz)
  Total number of paths / destination ports: 932 / 66
-------------------------------------------------------------------------
Delay:               3.930ns (Levels of Logic = 3)
  Source:            LowCounter_7 (FF)
  Destination:       turn (FF)
  Source Clock:      clk rising
  Destination Clock: clk rising

  Data Path: LowCounter_7 to turn
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDE:C->Q              2   0.447   0.981  LowCounter_7 (LowCounter_7)
     LUT6:I0->O            2   0.203   0.981  GND_1_o_GND_1_o_equal_12_o<15>2 (GND_1_o_GND_1_o_equal_12_o<15>1)
     LUT6:I0->O            1   0.203   0.808  _n00571 (_n0057)
     LUT4:I1->O            1   0.205   0.000  turn_rstpot (turn_rstpot)
     FD:D                      0.102          turn
    ----------------------------------------
    Total                      3.930ns (1.160ns logic, 2.770ns route)
                                       (29.5% logic, 70.5% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'clk'
  Total number of paths / destination ports: 129 / 129
-------------------------------------------------------------------------
Offset:              3.905ns (Levels of Logic = 2)
  Source:            high_wr (PAD)
  Destination:       HighCounter_0 (FF)
  Destination Clock: clk rising

  Data Path: high_wr to HighCounter_0
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            18   1.222   1.154  high_wr_IBUF (high_wr_IBUF)
     LUT2:I0->O           16   0.203   1.004  _n0061_inv1 (_n0061_inv)
     FDE:CE                    0.322          HighCounter_0
    ----------------------------------------
    Total                      3.905ns (1.747ns logic, 2.158ns route)
                                       (44.7% logic, 55.3% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'clk'
  Total number of paths / destination ports: 1 / 1
-------------------------------------------------------------------------
Offset:              3.597ns (Levels of Logic = 1)
  Source:            pwm_out (FF)
  Destination:       pwm_out (PAD)
  Source Clock:      clk rising

  Data Path: pwm_out to pwm_out
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FD:C->Q               1   0.447   0.579  pwm_out (pwm_out_OBUF)
     OBUF:I->O                 2.571          pwm_out_OBUF (pwm_out)
    ----------------------------------------
    Total                      3.597ns (3.018ns logic, 0.579ns route)
                                       (83.9% logic, 16.1% route)

=========================================================================

Cross Clock Domains Report:
--------------------------

Clock to Setup on destination clock clk
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
clk            |    3.930|         |         |         |
---------------+---------+---------+---------+---------+

=========================================================================


Total REAL time to Xst completion: 6.00 secs
Total CPU time to Xst completion: 6.08 secs
 
--> 

Total memory usage is 4509544 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    2 (   0 filtered)
Number of infos    :    0 (   0 filtered)

```  

- **RT Circuite**

![RT_2](https://user-images.githubusercontent.com/60509979/81446235-bd452e80-918f-11ea-9150-03872523a786.png)


## PWM Detector  

- **Synthesis Report**  
```
Release 14.7 - xst P.20131013 (nt64)
Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--> Parameter TMPDIR set to xst/projnav.tmp


Total REAL time to Xst completion: 1.00 secs
Total CPU time to Xst completion: 0.10 secs
 
--> Parameter xsthdpdir set to xst


Total REAL time to Xst completion: 1.00 secs
Total CPU time to Xst completion: 0.10 secs
 
--> Reading design: pwm_detector.prj

TABLE OF CONTENTS
  1) Synthesis Options Summary
  2) HDL Parsing
  3) HDL Elaboration
  4) HDL Synthesis
       4.1) HDL Synthesis Report
  5) Advanced HDL Synthesis
       5.1) Advanced HDL Synthesis Report
  6) Low Level Synthesis
  7) Partition Report
  8) Design Summary
       8.1) Primitive and Black Box Usage
       8.2) Device utilization summary
       8.3) Partition Resource Summary
       8.4) Timing Report
            8.4.1) Clock Information
            8.4.2) Asynchronous Control Signals Information
            8.4.3) Timing Summary
            8.4.4) Timing Details
            8.4.5) Cross Clock Domains Report


=========================================================================
*                      Synthesis Options Summary                        *
=========================================================================
---- Source Parameters
Input File Name                    : "pwm_detector.prj"
Ignore Synthesis Constraint File   : NO

---- Target Parameters
Output File Name                   : "pwm_detector"
Output Format                      : NGC
Target Device                      : xc6slx16-3-csg324

---- Source Options
Top Module Name                    : pwm_detector
Automatic FSM Extraction           : YES
FSM Encoding Algorithm             : Auto
Safe Implementation                : No
FSM Style                          : LUT
RAM Extraction                     : Yes
RAM Style                          : Auto
ROM Extraction                     : Yes
Shift Register Extraction          : YES
ROM Style                          : Auto
Resource Sharing                   : YES
Asynchronous To Synchronous        : NO
Shift Register Minimum Size        : 2
Use DSP Block                      : Auto
Automatic Register Balancing       : No

---- Target Options
LUT Combining                      : Auto
Reduce Control Sets                : Auto
Add IO Buffers                     : YES
Global Maximum Fanout              : 100000
Add Generic Clock Buffer(BUFG)     : 16
Register Duplication               : YES
Optimize Instantiated Primitives   : NO
Use Clock Enable                   : Auto
Use Synchronous Set                : Auto
Use Synchronous Reset              : Auto
Pack IO Registers into IOBs        : Auto
Equivalent register Removal        : YES

---- General Options
Optimization Goal                  : Speed
Optimization Effort                : 1
Power Reduction                    : NO
Keep Hierarchy                     : No
Netlist Hierarchy                  : As_Optimized
RTL Output                         : Yes
Global Optimization                : AllClockNets
Read Cores                         : YES
Write Timing Constraints           : NO
Cross Clock Analysis               : NO
Hierarchy Separator                : /
Bus Delimiter                      : <>
Case Specifier                     : Maintain
Slice Utilization Ratio            : 100
BRAM Utilization Ratio             : 100
DSP48 Utilization Ratio            : 100
Auto BRAM Packing                  : NO
Slice Utilization Ratio Delta      : 5

=========================================================================


=========================================================================
*                          HDL Parsing                                  *
=========================================================================
Analyzing Verilog file "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_detector.v" into library work
Parsing module <pwm_detector>.

=========================================================================
*                            HDL Elaboration                            *
=========================================================================

Elaborating module <pwm_detector>.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_detector.v" Line 22: Result of 17-bit expression is truncated to fit in 16-bit target.
WARNING:HDLCompiler:413 - "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_detector.v" Line 29: Result of 17-bit expression is truncated to fit in 16-bit target.

=========================================================================
*                           HDL Synthesis                               *
=========================================================================

Synthesizing Unit <pwm_detector>.
    Related source file is "C:\Users\msaee\Documents\ISE14.7\Assignment3\pwm_detector.v".
    Found 16-bit register for signal <LowCounter>.
    Found 16-bit register for signal <HighCounter>.
    Found 16-bit register for signal <High>.
    Found 16-bit register for signal <Z_1_o_dff_26_OUT>.
    Found 1-bit register for signal <GND_1_o_clk_DFF_17>.
    Found 16-bit register for signal <Low>.
    Found 16-bit adder for signal <HighCounter[15]_GND_1_o_add_5_OUT> created at line 22.
    Found 16-bit adder for signal <LowCounter[15]_GND_1_o_add_13_OUT> created at line 29.
    Found 1-bit tristate buffer for signal <data_out<15>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<14>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<13>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<12>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<11>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<10>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<9>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<8>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<7>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<6>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<5>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<4>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<3>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<2>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<1>> created at line 33
    Found 1-bit tristate buffer for signal <data_out<0>> created at line 33
    Found 16-bit comparator not equal for signal <n0001> created at line 20
    Found 16-bit comparator not equal for signal <n0011> created at line 27
    Summary:
	inferred   2 Adder/Subtractor(s).
	inferred  81 D-type flip-flop(s).
	inferred   2 Comparator(s).
	inferred   1 Multiplexer(s).
	inferred  16 Tristate(s).
Unit <pwm_detector> synthesized.

=========================================================================
HDL Synthesis Report

Macro Statistics
# Adders/Subtractors                                   : 2
 16-bit adder                                          : 2
# Registers                                            : 6
 1-bit register                                        : 1
 16-bit register                                       : 5
# Comparators                                          : 2
 16-bit comparator not equal                           : 2
# Multiplexers                                         : 1
 16-bit 2-to-1 multiplexer                             : 1
# Tristates                                            : 16
 1-bit tristate buffer                                 : 16

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================


Synthesizing (advanced) Unit <pwm_detector>.
The following registers are absorbed into counter <LowCounter>: 1 register on signal <LowCounter>.
The following registers are absorbed into counter <HighCounter>: 1 register on signal <HighCounter>.
Unit <pwm_detector> synthesized (advanced).

=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# Counters                                             : 2
 16-bit up counter                                     : 2
# Registers                                            : 49
 Flip-Flops                                            : 49
# Comparators                                          : 2
 16-bit comparator not equal                           : 2
# Multiplexers                                         : 16
 1-bit 2-to-1 multiplexer                              : 16

=========================================================================

=========================================================================
*                         Low Level Synthesis                           *
=========================================================================

Optimizing unit <pwm_detector> ...

Mapping all equations...
Building and optimizing final netlist ...
Found area constraint ratio of 100 (+ 5) on block pwm_detector, actual ratio is 1.

Final Macro Processing ...

=========================================================================
Final Register Report

Macro Statistics
# Registers                                            : 81
 Flip-Flops                                            : 81

=========================================================================

=========================================================================
*                           Partition Report                            *
=========================================================================

Partition Implementation Status
-------------------------------

  No Partitions were found in this design.

-------------------------------

=========================================================================
*                            Design Summary                             *
=========================================================================

Top Level Output File Name         : pwm_detector.ngc

Primitive and Black Box Usage:
------------------------------
# BELS                             : 177
#      GND                         : 1
#      INV                         : 4
#      LUT1                        : 30
#      LUT2                        : 3
#      LUT3                        : 16
#      LUT5                        : 34
#      LUT6                        : 14
#      MUXCY                       : 42
#      VCC                         : 1
#      XORCY                       : 32
# FlipFlops/Latches                : 81
#      FD                          : 17
#      FDE                         : 32
#      FDRE                        : 32
# Clock Buffers                    : 1
#      BUFGP                       : 1
# IO Buffers                       : 19
#      IBUF                        : 3
#      OBUFT                       : 16

Device utilization summary:
---------------------------

Selected Device : 6slx16csg324-3 


Slice Logic Utilization: 
 Number of Slice Registers:              81  out of  18224     0%  
 Number of Slice LUTs:                  101  out of   9112     1%  
    Number used as Logic:               101  out of   9112     1%  

Slice Logic Distribution: 
 Number of LUT Flip Flop pairs used:    101
   Number with an unused Flip Flop:      20  out of    101    19%  
   Number with an unused LUT:             0  out of    101     0%  
   Number of fully used LUT-FF pairs:    81  out of    101    80%  
   Number of unique control sets:         5

IO Utilization: 
 Number of IOs:                          20
 Number of bonded IOBs:                  20  out of    232     8%  

Specific Feature Utilization:
 Number of BUFG/BUFGCTRLs:                1  out of     16     6%  

---------------------------
Partition Resource Summary:
---------------------------

  No Partitions were found in this design.

---------------------------


=========================================================================
Timing Report

NOTE: THESE TIMING NUMBERS ARE ONLY A SYNTHESIS ESTIMATE.
      FOR ACCURATE TIMING INFORMATION PLEASE REFER TO THE TRACE REPORT
      GENERATED AFTER PLACE-and-ROUTE.

Clock Information:
------------------
-----------------------------------+------------------------+-------+
Clock Signal                       | Clock buffer(FF name)  | Load  |
-----------------------------------+------------------------+-------+
clk                                | BUFGP                  | 81    |
-----------------------------------+------------------------+-------+

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 3.509ns (Maximum Frequency: 284.949MHz)
   Minimum input arrival time before clock: 4.538ns
   Maximum output required time after clock: 4.807ns
   Maximum combinational path delay: No path found

Timing Details:
---------------
All values displayed in nanoseconds (ns)

=========================================================================
Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 3.509ns (frequency: 284.949MHz)
  Total number of paths / destination ports: 1904 / 112
-------------------------------------------------------------------------
Delay:               3.509ns (Levels of Logic = 7)
  Source:            HighCounter_0 (FF)
  Destination:       High_0 (FF)
  Source Clock:      clk rising
  Destination Clock: clk rising

  Data Path: HighCounter_0 to High_0
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FDRE:C->Q             4   0.447   1.028  HighCounter_0 (HighCounter_0)
     LUT6:I1->O            1   0.203   0.000  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_lut<0> (Mcompar_High[15]_HighCounter[15]_not_equal_10_o_lut<0>)
     MUXCY:S->O            1   0.172   0.000  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<0> (Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<0>)
     MUXCY:CI->O           1   0.019   0.000  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<1> (Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<1>)
     MUXCY:CI->O           1   0.019   0.000  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<2> (Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<2>)
     MUXCY:CI->O           1   0.019   0.000  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<3> (Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<3>)
     MUXCY:CI->O           1   0.019   0.000  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<4> (Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<4>)
     MUXCY:CI->O          16   0.258   1.004  Mcompar_High[15]_HighCounter[15]_not_equal_10_o_cy<5> (High[15]_HighCounter[15]_not_equal_10_o)
     FDE:CE                    0.322          High_0
    ----------------------------------------
    Total                      3.509ns (1.478ns logic, 2.031ns route)
                                       (42.1% logic, 57.9% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'clk'
  Total number of paths / destination ports: 114 / 113
-------------------------------------------------------------------------
Offset:              4.538ns (Levels of Logic = 3)
  Source:            pwm_in (PAD)
  Destination:       High_0 (FF)
  Destination Clock: clk rising

  Data Path: pwm_in to High_0
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O            35   1.222   1.699  pwm_in_IBUF (pwm_in_IBUF)
     LUT6:I0->O           16   0.203   1.109  _n0083_inv1 (_n0083_inv1)
     LUT5:I3->O            1   0.203   0.000  High_0_dpot (High_0_dpot)
     FDE:D                     0.102          High_0
    ----------------------------------------
    Total                      4.538ns (1.730ns logic, 2.808ns route)
                                       (38.1% logic, 61.9% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'clk'
  Total number of paths / destination ports: 32 / 16
-------------------------------------------------------------------------
Offset:              4.807ns (Levels of Logic = 2)
  Source:            GND_1_o_clk_DFF_17 (FF)
  Destination:       data_out<15> (PAD)
  Source Clock:      clk rising

  Data Path: GND_1_o_clk_DFF_17 to data_out<15>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FD:C->Q               1   0.447   0.579  GND_1_o_clk_DFF_17 (GND_1_o_clk_DFF_17)
     INV:I->O             16   0.206   1.004  GND_1_o_clk_DFF_17_inv1_INV_0 (GND_1_o_clk_DFF_17_inv)
     OBUFT:T->O                2.571          data_out_15_OBUFT (data_out<15>)
    ----------------------------------------
    Total                      4.807ns (3.224ns logic, 1.583ns route)
                                       (67.1% logic, 32.9% route)

=========================================================================

Cross Clock Domains Report:
--------------------------

Clock to Setup on destination clock clk
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
clk            |    3.509|         |         |         |
---------------+---------+---------+---------+---------+

=========================================================================


Total REAL time to Xst completion: 7.00 secs
Total CPU time to Xst completion: 6.12 secs
 
--> 

Total memory usage is 4509480 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    2 (   0 filtered)
Number of infos    :    0 (   0 filtered)

```

- **RT Circuite**  

![RT_2](https://user-images.githubusercontent.com/60509979/81446261-cf26d180-918f-11ea-86dc-164e755af8b0.png)


## Support

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## License  

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
