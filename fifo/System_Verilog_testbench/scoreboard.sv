import f_pkg::*;

class scoreboard;

transaction tr;
mailbox scbm;
int fifo[$:7];
logic [7:0] chimpu;
int num_checked = 0;
int pass = 0;
int failed = 0;
    task check();

        forever begin
            logic did_pop = 1'b0;
            scbm.get(tr);
            $display("transaction recieved from monitor rst_n = %0b || w_en = %0b || rd_en = %0b || data_in = %0b || data_out = %0b",
                            tr.rst_n,tr.write_en,tr.read_en,tr.data_in,tr.data_out);
            if(!tr.rst_n)begin 
                fifo.delete();
            end
            else begin
                if(tr.write_en && (fifo.size() < 8)) begin 
                    fifo.push_back(tr.data_in);
                end

                if(tr.read_en && (fifo.size() > 0)) begin
                    chimpu = fifo.pop_front();
                    did_pop = 1'b1;
                end

                if((fifo.size() == 8) !== tr.full) $display("full mismatch expected = %0d || got = %0d",fifo.size(),tr.full);
                if((fifo.size() == 0) !== tr.empty) $display("empty mismatch expected = %0d || got = %0d",fifo.size(),tr.empty);

                if(did_pop) begin
                    if(chimpu !== tr.data_out) begin
                        $display("\n=========================================\n");
                        $display("test failed rst_n = %0b | expected :: data_out = %0b || data_in = %0b || got :: w_en = %0b || rd_en = %0b || data_out = %0b ",
                                tr.rst_n,chimpu,tr.data_in,tr.write_en,tr.read_en,tr.data_out);
                                $display("\n=========================================\n");
                        failed++;
                    end 
                    else begin
                        $display("test passed expected data_out = %0b || got data_out = %0b ", chimpu,tr.data_out);
                        $display("\n=========================================\n");
                        pass++;
                    end
                end
            end
            num_checked++;          
        end
    endtask

endclass