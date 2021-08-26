CREATE OR REPLACE package SYS.queues_add
is
    error_message varchar2(32000);
    queues_error exception;
    pragma exception_init (queues_error,-00001);
    function execute_add (p_id in number
                          ,p_code in varchar2
                          ,p_name in varchar2
                          ,p_proc_type in number
                          ,p_queues_arr in number
                          ,p_in_queue in number
                          ,p_out_queue in number
                          ,p_suscriber in number)
    return number;
end queues_add;
/
