`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Patna
// Engineer: Azam
// Create Date:    15:10:33 10/22/2019 
// Design Name:    7-segment display
// Module Name:    7-segment display
// Target Devices: NEXYS4 DDR
// Description: General module of 7 segment display to show any 32 bit data
//////////////////////////////////////////////////////////////////////////////////
module top(
 input clock,
 output [7:0] AN,
 output CA,
 output CB,
 output CC,
 output CD,
 output CE,
 output CF,
 output CG
);
reg [31:0] data = 32'b0;
reg [24:0] counter = 25'b0;

always@(posedge clock)
	counter <= counter + 1;
always@(posedge counter[21])
	data<= data+1;
	
led_driver m1(.data(data),.clock(clock),.AN(AN),.CA(CA),.CB(CB),.CC(CC),.CD(CD),.CE(CE),.CF(CF),.CG(CG));
endmodule
 
module led_driver(
 input clock,
 input [31:0] data,
 output [7:0] AN,
 output reg CA,
 output reg CB,
 output reg CC,
 output reg CD,
 output reg CE,
 output reg CF,
 output reg CG
 );

reg [2:0] counter = 3'b000;

reg [25:0] clock_division = 26'b0;
always@(posedge clock)
	clock_division <= clock_division + 1;
	
always@(posedge clock_division[17]) //scanning rate...from right to left
	counter <= counter + 1;
	
assign AN[0] = !((!counter[2])&(!counter[1])&(!counter[0]));
assign AN[1] = !((!counter[2])&(!counter[1])&(counter[0]));
assign AN[2] = !((!counter[2])&(counter[1])&(!counter[0]));
assign AN[3] = !((!counter[2])&(counter[1])&(counter[0]));
assign AN[4] = !((counter[2])&(!counter[1])&(!counter[0]));
assign AN[5] = !((counter[2])&(!counter[1])&(counter[0]));
assign AN[6] = !((counter[2])&(counter[1])&(!counter[0]));
assign AN[7] = !((counter[2])&(counter[1])&(counter[0]));

always@(posedge clock)
	begin
		CA <= 1;
		CB <= 1;
		CC <= 1;
		CD <= 1;
		CE <= 1;
		CF <= 1;
		CG <= 1;
		case(counter)
		3'b000: begin
		case(data[3:0])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end 
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end
			default: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b001: begin
		case(data[7:4])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end  
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b010: begin
		case(data[11:8])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end 
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b011: begin
		case(data[15:12])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end  
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b100: begin
		case(data[19:16])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end 
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b101: begin
		case(data[23:20])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end  
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b110: begin
		case(data[27:24])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end  
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end
		3'b111: begin
		case(data[31:28])
			4'b0000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; end
			4'b0001: begin CB <= 0; CC <= 0; end
			4'b0010: begin CA <= 0; CB <= 0; CG <= 0; CE <= 0; CD <= 0; end
			4'b0011: begin CA <= 0; CB <= 0; CG <= 0; CC <= 0; CD <= 0; end
			4'b0100: begin CB <= 0; CC <= 0; CF <= 0; CG <= 0;  end //F G B C
			4'b0101: begin CA <= 0; CF <= 0; CG <= 0; CC <= 0; CD <= 0; end //A F G C D
			4'b0110: begin CA <= 0; CC <= 0; CD <=0; CE <= 0; CF <= 0; CG <= 0; end //EXCEPT B
			4'b0111: begin CA <= 0; CB <= 0; CC <= 0; end  
			4'b1000: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1001: begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CF <= 0; CG <= 0; end
			4'b1010: begin CA <= 0; CB <= 0; CC <= 0; CE <= 0; CF <= 0; CG <= 0; end 
			4'b1011: begin CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1100: begin CD <= 0; CE <= 0; CG <= 0; end
			4'b1101: begin CB <= 0; CC <= 0; CD <= 0; CE <= 0; CG <= 0; end
			4'b1110: begin CA <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
			4'b1111: begin CA <= 0; CE <= 0; CF <= 0; CG <= 0; end
			default:begin CA <= 0; CB <= 0; CC <= 0; CD <= 0; CE <= 0; CF <= 0; CG <= 0; end
		endcase
		end	
		endcase
	end
endmodule
