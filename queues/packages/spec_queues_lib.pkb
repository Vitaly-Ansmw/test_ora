create or replace package queues_lib
is
    prc_is_null exception;
    pragma exception_init (prc_is_null,-00007);
    type queues_proc_rec is record (id number
                                    ,c_code varchar2(1000)
                                    ,c_name varchar2(1000)
                                    ,c_proc_type number
                                    ,c_queues_arr number
                                    ,c_queues_arr_info queues_arr_lib.queues_arr_tbl);
                                        
    function init_queue_proc(v_process in number)
    return queues_proc_rec;
    procedure start_queue_proc (p_process in number);
  /*  procedure stop_queue_proc (p_process in number);
    procedure status_queue_proc (p_process in number);*/
end queues_lib;