CREATE OR REPLACE package SYS.queues_arr_add
is
    queues_arr_ref queues_arr%rowtype;
    error_message varchar2(32000);
    queues_error exception;
    pragma exception_init (queues_error,-00002);
    function execute_add (p_id in number
                          ,p_type in number
                          ,p_collection_id number
                          ,p_id_query in number
                          ,p_active in number default 0)
    return number;
    
end;
/
