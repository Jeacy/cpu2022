
module tb (
);
    
    reg clk;
    reg rstn;
    
    wire [31:0] data1 ;
    wire [31:0] data2 ;
    wire [31:0] data3 ;
    wire [31:0] data4 ;
    wire [31:0] data5 ;
    wire [31:0] data6 ;
    wire [31:0] data7 ;
    wire [31:0] data8 ;
    wire [31:0] data9 ;
    wire [31:0] data10;
    
    wire is_trap;
    wire is_mret;
    
    
    
    
    

    cpu cpu_m0 (
    .clk       (clk),
    .rstn      (rstn),
    .data1     (data1 ),
    .data2     (data2 ),
    .data3     (data3 ),
    .data4     (data4 ),
    .data5     (data5 ),
    .data6     (data6 ),
    .data7     (data7 ),
    .data8     (data8 ),
    .data9     (data9 ),
    .data10    (data10),
    .is_trap   (is_trap),
    .is_mret   (is_mret)
    );


    initial begin
		clk = 0;
		rstn = 0;

		#200;
        rstn = 1;
	end
     
     
      always #50 clk = ~clk ;


   

	
	always@(*) begin
	
		if(is_trap) begin
			//ecall
				$display("ecall : go into trap\n");
					$display("%d\n", data1);
					$display("%d\n", data2 );
					$display("%d\n", data3 );
					$display("%d\n", data4 );
					$display("%d\n", data5 );
					$display("%d\n", data6 );
					$display("%d\n", data7 );
					$display("%d\n", data8 );
					$display("%d\n", data9 );
					$display("%d\n", data10);
				end	
	     else if(is_mret) begin
				$display("mret : return from trap\n");
				$display("%d\n", data1);
		end
	  end




endmodule