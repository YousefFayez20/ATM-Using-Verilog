`include "ATMCODEHL2.v"
module ATMTBCODEHL2;
    reg clk;
    reg rst;
    reg InserCard;
    reg Language;
    reg [3:0] Card_ID;
    reg [3:0] PIN0;
    reg [3:0] PIN1;
    reg [3:0] PIN2;
    reg [3:0] PIN3;
    reg [31:0] CashDeposited;
    reg [31:0] CashWithdrawed;
    reg [1:0] operation;

    wire [3:0] CurrentState, NextState;

    wire ValidPassword;
    wire AmountToWithdraw;
    wire AmountRequested;
    
     ATMCODEHL2 atm (
    .clk(clk),
    .rst(rst),
    .InserCard(InserCard),
    .Language(Language),
    .Card_ID(Card_ID),
    .PIN0(PIN0),
    .PIN1(PIN1),
    .PIN2(PIN2),
    .PIN3(PIN3),
    .CashDeposited(CashDeposited),
    .CashWithdrawed(CashWithdrawed),
    .operation(operation),
    .CurrentState(CurrentState),
    .NextState(NextState),
    .ValidPassword(ValidPassword),
    .AmountToWithdraw(AmountToWithdraw),
    .AmountRequested(AmountRequested)
  );
     // Clock generation
  always
    #1 clk = ~clk;
  
  // Initialize inputs
  initial begin
    clk = 0;
    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #10 rst = 0;#15
    // Direct Test Cases

    // card id = 0
    // Test case 1
    rst = 0;
    InserCard = 1;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;
    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // balances shown
    // Test Case 2
    rst = 0;
    InserCard = 1;
    Card_ID = 1;
    PIN0 = 1;
    PIN1 = 1;
    PIN2 = 1;
    PIN3 = 1;
    Language = 1;
    operation = 0;
    #14;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // cash depositied
    // Test Case 3
    rst = 0;
    InserCard = 1;
    Card_ID = 2;
    PIN0 = 2;
    PIN1 = 2;
    PIN2 = 2;
    PIN3 = 2;
    Language = 1;
    operation = 1;
    CashDeposited = 100;
    #14;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;
    

    //cash withdrawel
    // Test Case 4
    rst = 0;
    InserCard = 1;
    Card_ID = 3;
    PIN0 = 3;
    PIN1 = 3;
    PIN2 = 3;
    PIN3 = 3;
    Language = 1;
    operation = 2;
    CashWithdrawed = 200;
    #14;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;
    
    // operation default 
    // Test Case 5
    rst = 0;
    InserCard = 1;
    Card_ID = 4;
    PIN0 = 4;
    PIN1 = 4;
    PIN2 = 4;
    PIN3 = 4;
    Language = 1;
    operation = 3;
    #15;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // cashdeposited = 0
    // Test Case 6
    rst = 0;
    InserCard = 1;
    Card_ID = 4;
    PIN0 = 4;
    PIN1 = 4;
    PIN2 = 4;
    PIN3 = 4;
    Language = 1;
    operation = 1;
    CashDeposited = 0;
    #15;

    rst = 1;
    InserCard = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // cashwithdrawed = 0
    // Test Case 7
    rst = 0;
    InserCard = 1;
    Card_ID = 4;
    PIN0 = 4;
    PIN1 = 4;
    PIN2 = 4;
    PIN3 = 4;
    Language = 1;
    operation = 2;
    CashWithdrawed = 0;
    #15;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // cashwithdrawed > balance
    // Test Case 7
    rst = 0;
    InserCard = 1;
    Card_ID = 4;
    PIN0 = 4;
    PIN1 = 4;
    PIN2 = 4;
    PIN3 = 4;
    Language = 1;
    operation = 2;
    CashWithdrawed = 4294967295;
    #15;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // card_id = database
    // Test Case 8
    rst = 0;
    InserCard = 1;
    Card_ID = 5;
    PIN0 = 5;
    PIN1 = 5;
    PIN2 = 5;
    PIN3 = 5;
    Language = 1;
    operation = 0;
    #15;

    // Reset inputs for the next test case
    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // language = 0
    // Test Case 9
    rst = 0;
    InserCard = 1;
    Card_ID = 5;
    PIN0 = 5;
    PIN1 = 5;
    PIN2 = 5;
    PIN3 = 5;
    Language = 0;
    operation = 0;
    #15;

    // Reset inputs for the next test case
    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // pin i s wrong
    // Test Case 10
    rst = 0;
    InserCard = 1;
    Card_ID = 3;
    PIN0 = 5;
    PIN1 = 5;
    PIN2 = 5;
    PIN3 = 5;
    Language = 1;
    operation = 0;
    #15;

    // Reset inputs for the next test case
    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #15;

    // cashdepositied for toggle
    // Test Case 11
    rst = 0;
    InserCard = 1;
    Card_ID = 4;
    PIN0 = 4;
    PIN1 = 4;
    PIN2 = 4;
    PIN3 = 4;
    Language = 1;
    operation = 2;
    CashDeposited = 4294967295;
    #15;

    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
    #16;

    // Random Test Cases
    // Test Case 6
    repeat (5) begin
    #10;
    rst = 0;
    InserCard = $random%2;
    Card_ID = $random%5;
    PIN0 = $random%5;
    PIN1 = $random%5;
    PIN2 = $random%5;
    PIN3 = $random%5;
    Language = $random%2;
    operation = $random%4;
    #10;
    rst = 1;
    InserCard = 0;
    Language = 0;
    Card_ID = 0;
    PIN0 = 0;
    PIN1 = 0;
    PIN2 = 0;
    PIN3 = 0;
    CashDeposited = 0;
    CashWithdrawed = 0;
    operation = 0;
   end
  end
// psl assert always((rst == 1) -> next(CurrentState == 4'b0000))@(posedge clk);
// psl assert always((rst == 0) -> next(CurrentState == NextState))@(negedge rst);
// psl assert always(((CurrentState == 4'b0001)&&(Language == 1))->next(CurrentState == 4'b0010))@(posedge clk);
// psl assert always(((ValidPassword == 1)&&(rst == 0)&&(CurrentState == 4'b0010))->next(CurrentState == 4'b0011))@(posedge clk);
// assert always()
    initial 
    begin
      $monitor("time: %d, clk: %b, rst: %b, InserCard: %b, Language: %b, Card_ID: %b, PIN0: %b, PIN1: %b, PIN2: %b, PIN3: %b, CashDeposited: %b, CashWithdrawed: %b, operation: %b, CurrentState: %b, NextState: %b, ValidPassword: %b, AmountToWithdraw: %b, AmountRequested: %b",
                $time, clk, rst, InserCard, Language, Card_ID, PIN0, PIN1, PIN2, PIN3, CashDeposited, CashWithdrawed, operation, CurrentState, NextState, ValidPassword, AmountToWithdraw, AmountRequested); 
  end
       
endmodule
