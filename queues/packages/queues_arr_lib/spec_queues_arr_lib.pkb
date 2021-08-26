create or replace package queues_arr_lib
is
    not_founded_recs exception;
    pragma exception_init (not_founded_recs,-00004);
    collection_is_nulls exception;
    pragma exception_init (collection_is_nulls,-00005);
    cannot_change_status exception;
    pragma exception_init (cannot_change_status,-00008);
    
    type queues_arr_rec is record (id number
                                   ,collection_id number
                                   ,c_type number
                                   ,c_id_queury number
                                   ,c_active number(1)
                                   ,queue_name varchar2(1000)
                                   ,qid number
                                   ,unqueue_enabled varchar2(1000));
    type queues_arr_tbl is table of queues_arr_rec
    index by pls_integer;
    

    function get_info_recs (p_collection_id in number)
    return queues_arr_tbl;
    
    procedure change_status (p_id number
                             ,p_status in number);
    
end queues_arr_lib;


