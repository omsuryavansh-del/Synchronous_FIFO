
class transaction;
logic rst_n;
rand logic write_en;
rand logic read_en;
rand logic [7:0] data_in;
logic [7:0] data_out;
logic full;
logic empty;
typedef enum{WRITE_OP,READ_OP,SIM_OP,RAND_OP} ope;
rand ope op;

constraint rw_op {
    op == WRITE_OP  -> (write_en == 1 && read_en == 0);
    op == READ_OP   -> (write_en == 0 && read_en == 1);
    op == SIM_OP    -> (write_en == 1 && read_en == 1);
    op == RAND_OP   -> {write_en dist {1:=50, 0:=50}; read_en dist {1:=50, 0:=50}; write_en != read_en;}
}
endclass