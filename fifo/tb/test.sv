import f_pkg :: *;


class test;

    environment env;
    virtual fifo_if f_if;

    function new();
    endfunction //new()

    function void connect();
        env.f_if = f_if;
        env.connect();
    endfunction

    virtual task run();
    endtask

endclass 

class random extends test;
    task run();
        connect();
        env.random();
    endtask
endclass

class write_write extends test;
    task run();
        connect();
        env.write_write();
    endtask
endclass

class read_read extends test;   
    task run();
        connect();
        env.read_read();
    endtask
endclass

class rd_aftr_wr extends test;
    task run();
        connect();
        env.rd_aftr_wr();
    endtask
endclass

class empty_full extends test;
    task run();
        connect();
        env.test_full();
    endtask
endclass