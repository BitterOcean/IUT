module Stopwatch(input clk, reset, start, stop, output [5:0] second,minute, output [4:0] hour,day, output[3:0] month, output [6:0] year);

wire Syncked_clk;
and U0 (Syncked_clk , clk, start, ~stop);
DayCounter U1 (Syncked_clk,reset,second,minute,hour,day,month,year);

endmodule