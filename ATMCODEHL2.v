module ATMCODEHL2(
input clk,
input rst,
input InserCard,
input Language,
input wire [3:0] Card_ID,
input wire [3:0] PIN0,
input wire [3:0] PIN1,
input wire [3:0] PIN2,
input wire [3:0] PIN3,
input [31:0] CashDeposited,
input [31:0] CashWithdrawed,
input [1:0] operation,
output reg[3:0] CurrentState, NextState,
output reg ValidPassword = 1'b0,
output reg AmountToWithdraw = 1'b0,
output reg AmountRequested = 1'b0

);



parameter [3:0]  S0 = 4'b0000,
S1 = 4'b0001,
S2 = 4'b0010,
S3 = 4'b0011,
S4 = 4'b0100,
S5 = 4'b0101,
S6 = 4'b0110,
S7 = 4'b0111,
S8 = 4'b1000,
S9 = 4'b1001;


reg [3:0] 	CARDS [0:4];
reg [3:0] 	PINS [0:4][3:0];
reg [31:0]	BALANCES [0:4];


integer	DataBase = 6;
integer I;
initial
begin: INIT
	for(I = 1; I < DataBase; I = I + 1)
	begin
    CARDS[I] = I;
    PINS[I][0] = I;
    PINS[I][1] = I;
    PINS[I][2] = I;
    PINS[I][3] = I;
    BALANCES[I] = I*1000 + I*100 +I*10 + I;
	end
end




always @(posedge clk or posedge rst)
 begin
    if(rst)
    begin
        CurrentState <= S0;
    end
    else
    CurrentState <= NextState;
end

always @(*)
begin
    case (CurrentState)
        S0:begin 
            if(InserCard &&(Card_ID < DataBase || Card_ID > 0 ))
            NextState = S1;
            else
            NextState = S0;
        end
        S1: begin
            if(Language)
            NextState = S2;
            else
            NextState = S1;
         end
        S2: begin
            if(PIN0 == PINS[Card_ID][0] && PIN1 == PINS[Card_ID][1] && PIN2 == PINS[Card_ID][2] && PIN3 == PINS[Card_ID][3])
            ValidPassword = 1'b1;
            else
            ValidPassword = 1'b0;

            if(ValidPassword)
                    begin
                    NextState = S3;
                    end
            else
                begin
                NextState = S0;
                end
          end
        S3: begin
          case(operation)
            2'b00: NextState = S4;
            2'b01: NextState = S5;
            2'b10: NextState = S6;
            default: NextState = S3;
            endcase
            end
        S4:begin
            BALANCES[Card_ID] = BALANCES[Card_ID];
            NextState = S3;
         end
         S5:begin
            if(CashDeposited > 0)AmountRequested=1'b1;
            else AmountRequested = 1'b0;
            if(AmountRequested > 0)  NextState = S8;
            else NextState = S5;
         end
         S6:begin
         if(CashWithdrawed > 0) AmountRequested = 1'b1;
         else AmountRequested = 1'b0;
         if(AmountRequested) NextState = S7;
         else NextState = S6;
         end
         S7:
         begin
         if(CashWithdrawed <= BALANCES[Card_ID]) AmountToWithdraw =1'b1;
         else AmountToWithdraw = 1'b0;
         if(AmountToWithdraw) NextState = S9;
         else NextState = S6;
         end
         S8:
         begin
            BALANCES[Card_ID] = BALANCES[Card_ID] + CashDeposited;
            NextState = S3;
          end
        S9:begin
            BALANCES[Card_ID] = BALANCES[Card_ID] - CashWithdrawed;
            NextState = S3;
         end
        default: NextState = S0; 
    endcase
    end
endmodule
