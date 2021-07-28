create or replace package queues_lib
is
    function check_queue_proc(v_process in number)
    return boolean;
    procedure stop_queue_proc (p_process in number);
    procedure start_queue_proc (p_process in number);
    procedure status_queue_proc (p_process in number);
end queues_lib;