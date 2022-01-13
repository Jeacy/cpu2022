
module bhazard (
    input     bjmp      ,

    output    b_flush     //flush if_id and id_exe 

);

 assign  b_flush  =  bjmp;
    
endmodule
