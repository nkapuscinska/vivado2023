module decode (
    input  wire [3:0] OPcode,
    input  wire       en,
    
    /* [0] - update Carry and Overflow flags; 
     * [1] - update Neg and  Zero flags;
     *  ADD, SUB - update all flags; 
     * AND, OR - update only Neg and Zero
     *  */
    output reg  [1:0] UpdateFlags,
     
    output reg  [1:0] ALUControl,
    output reg  [1:0] RegFileControl
);

localparam  ADD = 3'b000,
            SUB = 3'b001,
            AND = 3'b010,
            OR  = 3'b011,
            LDA = 3'b100,
            LDB = 3'b101,
            NOP = 3'b111;


always @*
    if(!en) // branch
        UpdateFlags = 2'b00;
    else begin    // execute
        case(OPcode[2:0])
            ADD, SUB:           UpdateFlags     = 2'b11;
            AND, OR:            UpdateFlags     = 2'b10;
            default:            UpdateFlags     = 2'b00;
        endcase
        end

always @*
    if(!en) // branch
        ALUControl = 2'b00;
    else begin    // execute
        case(OPcode[2:0])
            ADD:                ALUControl     = 2'b00;
            SUB:                ALUControl     = 2'b01;
            AND:                ALUControl     = 2'b10;
            OR:                 ALUControl     = 2'b11;
            default:            ALUControl     = 2'b00;
        endcase
        end



//------------------------------------------------------------------------------
always @*
    if(!en)
        RegFileControl = 2'b00;
    else
        if(OPcode[3]) // branch
            RegFileControl = 2'b00;
        else begin    // execute
            case(OPcode[2:0])
                ADD, SUB, AND, OR: RegFileControl = 2'b01;
                LDA: RegFileControl               = 2'b11;
                LDB: RegFileControl               = 2'b10;
                NOP: RegFileControl               = 2'b00;
                default: RegFileControl           = 2'b00;
            endcase
        end

endmodule
