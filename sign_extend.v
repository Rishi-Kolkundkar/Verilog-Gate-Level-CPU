module sign_extend (
    input  wire [5:0] In,
    output wire [7:0] Out
);
    assign Out = { {2{In[5]}}, In };
endmodule

