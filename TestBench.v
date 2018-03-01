/*Title of Mini Project:-LIGHTS OUT GAME
 
  Abstract             :-In Lights Out Game,the Gamer asked to make all the LED'S(3*3) to LOW for a given set of initial HIGH LED'S under the Game rules
  Functionalities      :-Total Moves Counting
                         Automatic Solution Generator
                         Solution Storer
                         Required No of Moves to win Calucalator When Automatic Mode is ON
*/

//===============================================================================================================================
//TEST BENCH FOR BOTH DATA FLOW AND BEHAVIORAL MODELLING CODES
//PLEASE CHANGE THE NAME OF MODULE IN LINE NO:-35 TO USE SAME TESTBENCH FOR COMPILING WITH  DIFFERENT MODELLINGS 
//===============================================================================================================================
		
`timescale 1ns/100ps

module TESTBENCH;

reg [31:0] input_pad;       //Corresponds to BUTTON pressed in INPUT PAD
reg [8:0] present_state;    //Present OUTPUT of the 9 LED'S
reg automatic_mode;         //To go into the Automatic mode
reg [31:0]total;            //Used in TOTAL MOVES calucalation
reg clk;
wire [8:0] hint;            //STORES the SOLUTION to the present state of LED'S
wire led_1,led_2,led_3,led_4,led_5,led_6,led_7,led_8,led_o9;//Corresponds to 9 LED'S 
wire [8:0] output_led;      // NEXT STATE of LED'S 
wire [31:0]total_moves;     //TOTAL MOVES taken by GAMER
wire [8:0]initial_state;    // INITIAL state of LED'S
wire [3:0] moves_required;  //MINIMUM NO of moves required to win for a given STATE of LED'S
wire result;                //For WIN condtion DISPLAY purpose
integer i=0,j=0;
reg win;                    // IF win==0 gamer WON the game ELSE still playing
wire win_o;                 //Used in WIN condtion calucalation

VerilogBehavioral my_Behavioral(input_pad,present_state,automatic_mode,output_led,hint,led_1,led_2,led_3,led_4,led_5,led_6,led_7,led_8,led_9,total_moves,total,moves_required,initial_state,clk,win,win_o,result);
	
	initial
	begin
            $dumpfile("BM.vcd");
		    $dumpvars(0, TESTBENCH);
			$monitor("             INPUT              LED display               TOTAL MOVES       WIN\n       %d               %b   %b   %b             %d             %b\n\n                                %b   %b   %b\n\n                                %b   %b   %b\n\n\n\n",input_pad,led_1,led_2,led_3,total_moves,result,led_4,led_5,led_6,led_7,led_8,led_9);

	automatic_mode=1'b0;total=0;
	 
	for(j=0;j<5;j=j+1)
	begin
	#10 automatic_mode=1'b0;
	#10 clk=1;
	#10 $display("Your initial state is\n");
	    present_state=$random%9; total=0;
	    input_pad=0;win=1;
	
	#10 present_state=output_led;total=total_moves;
	    input_pad=1;total=0;win=win_o;
  	    
	#10 present_state=output_led;total=total_moves;
	    input_pad=3; win=win_o;
	
	#10 present_state=output_led;total=total_moves;
      	input_pad=5; win=win_o;
     
	#10 present_state=output_led;total=total_moves;
	    input_pad=6;win=win_o;
		
	#10 present_state=output_led;total=total_moves;
	    input_pad=9;win=win_o;
	    
    #10 present_state=output_led;total=total_moves;
	    input_pad=2; win=win_o;
	
	#10 present_state=output_led;total=total_moves;
      	input_pad=3; win=win_o;
     
	#10 present_state=output_led;total=total_moves;
	    input_pad=4;win=win_o;
		
	#10 present_state=output_led;total=total_moves;
	    input_pad=0;win=win_o;
   	 
	#10  automatic_mode=1'b1; 
	 
	#10 $display("Further Moves reqiured to WIN---'%d'-------\n\n\n",moves_required);  
     	for(i=0;i<10;i=i+1)
		begin
		  if(hint[i]==1'b1)
		  begin
		    #10  present_state=output_led;total=total_moves;   automatic_mode=1'b0;
			     input_pad=i+1;
		  end
		end
	
	#10 clk = ~clk;	
    end	
				
	end
	initial #1000 $finish;
endmodule

//===============================================================================================================================
//                 **********END OF TESTBENCH***********
//===============================================================================================================================
