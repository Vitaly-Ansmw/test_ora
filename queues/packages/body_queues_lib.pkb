create or replace package body queues_lib
is
    function check_queue_proc(v_process in number)
    return boolean
    is
        type founded_rec is record (id number
                                    ,
    begin
        
    select * 
    from queues_proc a, queues_arr b
    where b.collection_id = a.c_queues_arr
    
    

    
    
    
    end;
    procedure stop_queue_proc (p_process in number);
    procedure start_queue_proc (p_process in number);
    procedure status_queue_proc (p_process in number);
end queues_lib;