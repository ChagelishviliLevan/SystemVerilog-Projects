

module encoder4 (
    input  logic A0, A1, A2, A3,
    output logic V,
    output logic Q0, Q1
);
    always_comb 
    begin
        V  = 0;
        Q0 = 0;
        Q1 = 0;

        if(A3) 
        begin
            V  = 1;
            Q0 = 1;
            Q1 = 1;
        end 
        else if (A2)
        begin
            V  = 1;
            Q0 = 0;
            Q1 = 1;           
        end 
        else if (A1)
        begin
            V  = 1;
            Q0 = 1;
            Q1 = 0;           
        end 
        else if (A0)
        begin
            V  = 1;
            Q0 = 0;
            Q1 = 0;           
        end                
    end
endmodule

module mux4 (
    input  logic X0, X1, X2, X3,
    input  logic S0, S1,
    output logic  Q
);
    always_comb
    begin
        if(S0 == 1 && S1 == 0)
            Q = X1;
        else if(S0 == 0 && S1 == 1)
            Q = X2;
        else if(S0 == 1 && S1 == 1)
            Q = X3;
        else
            Q = X0; 
    end 
endmodule

module encoder16 (
    input  logic A0, A1, A2, A3,
    input  logic A4, A5, A6, A7,
    input  logic A8, A9, A10, A11,
    input  logic A12, A13, A14, A15,
    output logic V,
    output logic Q0, Q1, Q2, Q3
);
    logic v0, v1, v2, v3;
    logic q0_1, q0_0, q1_1, q1_0, q2_1, q2_0, q3_1, q3_0;

    encoder4 enc0 (
        .A0(A0), .A1(A1), .A2(A2), .A3(A3),
        .V(v0),
        .Q0(q0_0), .Q1(q0_1)
    );
    encoder4 enc1 (
        .A0(A4), .A1(A5), .A2(A6), .A3(A7),
        .V(v1),
        .Q0(q1_0), .Q1(q1_1)
    );
    encoder4 enc2 (
        .A0(A8), .A1(A9), .A2(A10), .A3(A11),
        .V(v2),
        .Q0(q2_0), .Q1(q2_1)
    );
    encoder4 enc3 (
        .A0(A12), .A1(A13), .A2(A14), .A3(A15),
        .V(v3),
        .Q0(q3_0), .Q1(q3_1)
    );
    encoder4 enc4 (
        .A0(v0), .A1(v1), .A2(v2), .A3(v3),
        .V(V),
        .Q0(s0), .Q1(s1)
    );    

    assign Q3 = s1;
    assign Q2 = s0;
    
    mux4 mux0(
        .X0(q0_0), .X1(q1_0), .X2(q2_0), .X3(q3_0),
        .S0(s0), .S1(s1),
        .Q(Q0)
    );
    mux4 mux1(
        .X0(q0_1), .X1(q1_1), .X2(q2_1), .X3(q3_1),
        .S0(s0), .S1(s1),
        .Q(Q1)
    );

endmodule

