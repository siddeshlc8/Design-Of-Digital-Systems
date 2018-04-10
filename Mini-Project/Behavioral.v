/*Title of Mini Project:-LIGHTS OUT GAME
 
  Abstract             :-In Lights Out Game,the Gamer asked to make all the LED'S(3*3) to low for a given set of initial HIGH LED'S under the Game rules
  Functionalities      :-Total Moves Counting
                         Automatic Solution Generator
                         Solution Storer
                         Required No of Moves to win Calucalator When Automatic Mode is ON
*/
						 
//===============================================================================================================================
//Verilog:-- BEHAVIORAL MODELLING 
//===============================================================================================================================

module VerilogBehavioral(input_pad,present_state,automatic_mode,output_led,hint,led_1,led_2,led_3,led_4,led_5,led_6,led_7,led_8,led_9,total_moves,total,moves_required,initial_state,clk,win,win_o,result);//,hint_out);

input [31:0] input_pad;         //Corresponds to BUTTON pressed in INPUT PAD
input [8:0] present_state;      //Present OUTPUT of the 9 LED'S
input automatic_mode;           //To go into the Automatic mode
input[31:0] total;              //Used in TOTAL MOVES calucalation
output reg  [8:0] hint;         //STORES the SOLUTION to the present state of LED'S
output reg [31:0]total_moves;   //TOTAL MOVES taken by GAMER
output led_1,led_2,led_3,led_4,led_5,led_6,led_7,led_8,led_9;//Corresponds to 9 LED'S 
output reg [8:0] output_led;    // NEXT STATE of LED'S 
output reg [3:0] moves_required;//MINIMUM NO of moves required to win for a given STATE of LED'S
input  win;                     // IF win==0 gamer WON the game ELSE still playing
output win_o;                   //Used in WIN condtion calucalation
input clk;
output result;                  //For WIN condtion DISPLAY purpose
output [8:0] initial_state;     // INITIAL state of LED'S
always @ (*)
  
  
 if(!win)
		  begin
		   
		    output_led[0]=0;
		    output_led[1]=0;
		    output_led[2]=0;
		    output_led[3]=0;
		    output_led[4]=0;
		    output_led[5]=0;
		    output_led[6]=0;
		    output_led[7]=0;
		    output_led[8]=0;
			total_moves<=total;
			hint <= 9'b0;
			moves_required <= hint[0]+hint[1]+hint[2]+hint[3]+hint[4]+hint[5]+hint[6]+hint[7]+hint[8];
			end
			
  else if(!automatic_mode)
	begin
	    
		 total_moves <= total+1;
	   case(input_pad)
        
        1 : begin output_led[0]<=~present_state[0];
		          output_led[1]<=~present_state[1];
				  output_led[3]<=~present_state[3];
		    end
	    2 : begin output_led[1]<=~present_state[1];
		          output_led[0]<=~present_state[0];
				  output_led[2]<=~present_state[2];
				  output_led[4]<=~present_state[4];
		    end
		3 : begin output_led[2]<=~present_state[2];
		          output_led[1]<=~present_state[1];
				  output_led[5]<=~present_state[5];
		    end
		4 : begin output_led[3]<=~present_state[3];
		          output_led[0]<=~present_state[0];
				  output_led[4]<=~present_state[4];
				  output_led[6]<=~present_state[6];
		    end
		5 : begin output_led[4]<=~present_state[4];
		          output_led[1]<=~present_state[1];
				  output_led[7]<=~present_state[7];
				  output_led[3]<=~present_state[3];
				  output_led[5]<=~present_state[5];
		    end
		6 : begin output_led[5]<=~present_state[5];
		          output_led[4]<=~present_state[4];
				  output_led[2]<=~present_state[2];
				  output_led[8]<=~present_state[8];
		    end
		7 : begin output_led[6]<=~present_state[6];
		          output_led[3]<=~present_state[3];
				  output_led[7]<=~present_state[7];
		    end
		8 : begin output_led[7]<=~present_state[7];
		          output_led[4]<=~present_state[4];
				  output_led[6]<=~present_state[6];
				  output_led[8]<=~present_state[8];
		    end
		9 : begin output_led[8] <=~present_state[8];
		          output_led[7] <=~present_state[7];
				  output_led[5] <=~present_state[5];
		    end
		default: begin output_led <= present_state;
		               total_moves <= total;
			     end
       endcase
	
	end

	else  if(automatic_mode)
	   begin
	      hint[0]<=present_state[0]^present_state[2]^present_state[5]^present_state[6]^present_state[7];
	      hint[1]<=present_state[4]^present_state[6]^present_state[7]^present_state[8];
	      hint[2]<=present_state[0]^present_state[2]^present_state[3]^present_state[7]^present_state[8];
	      hint[3]<=present_state[2]^present_state[4]^present_state[5]^present_state[8];
	      hint[4]<=present_state[1]^present_state[3]^present_state[4]^present_state[5]^present_state[7];
	      hint[5]<=present_state[0]^present_state[3]^present_state[4]^present_state[6];
	      hint[6]<=present_state[0]^present_state[1]^present_state[5]^present_state[6]^present_state[8];
	      hint[7]<=present_state[0]^present_state[1]^present_state[2]^present_state[4];
	      hint[8]<=present_state[1]^present_state[2]^present_state[3]^present_state[6]^present_state[8];
		  
		  moves_required <= hint[0]+hint[1]+hint[2]+hint[3]+hint[4]+hint[5]+hint[6]+hint[7]+hint[8];
		  output_led <= present_state;
	   end 

	    assign led_1 = output_led[0];
		assign led_2 = output_led[1];
		assign led_3 = output_led[2];
	 	assign led_4 = output_led[3];
	 	assign led_5 = output_led[4];
		assign led_6 = output_led[5];
		assign led_7 = output_led[6];
		assign led_8 = output_led[7];
		assign led_9 = output_led[8];
		assign win_o= output_led[0]| output_led[1]| output_led[2]|output_led[3]| output_led[4]|output_led[5]|output_led[6]| output_led[7]| output_led[8]|0;
        assign result= ~automatic_mode&~(win_o);
endmodule
             		