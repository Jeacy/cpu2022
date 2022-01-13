
module mem_wb (
    input                               clk          ,
    input                               rstn         ,
    input    [4:0]                      mem_rd_idx   ,
    input                               mem_rd_en    ,
    input    [31:0]                     mem_rd_data  ,

    output    [4:0]                     wb_rd_idx    ,
    output                              wb_rd_en     ,
    output    [31:0]                    wb_rd_data   

);


    reg    [4:0]                     wb_rd_idx    ;
    reg                              wb_rd_en     ;
    reg    [31:0]                    wb_rd_data   ;



    always @(posedge clk or negedge rstn) begin
        if(~rstn)begin
            wb_rd_idx         <=  1'b0  ; 
            wb_rd_en          <=  1'b0  ; 
            wb_rd_data        <=  1'b0  ;
        end
        else begin
            wb_rd_idx         <=  mem_rd_idx  ; 
            wb_rd_en          <=  mem_rd_en   ; 
            wb_rd_data        <=  mem_rd_data ;
        end
           
         
    end





    
endmodule