create or replace package body queues_arr_lib
is
  
    function get_info_recs (p_collection_id in number)
    return queues_arr_tbl
    is
        founded_recs queues_arr_tbl;
    begin
        
        if p_collection_id is null
        then
            raise collection_is_nulls;
        end if;
        
        select a1.id
        ,a1.collection_id
        ,a1.c_type
        ,a1.c_id_query
        ,a1.c_active
        ,b1.name
        ,b1.qid
        ,b1.enqueue_enabled
        bulk collect into founded_recs
        from queues_arr a1
        ,all_queues b1
        where a1.collection_id = p_collection_id
        and b1.qid = a1.c_id_query
        for update;
        
        return founded_recs;
        
    end;
    
    procedure change_status (p_id number
                             ,p_status in number)
    is
        v_status number(1);
        v_id number;
    begin
        if p_status is null or p_id is null
        then
            raise cannot_change_status;
        end if;
        
        v_status := p_status;
        v_id := p_id;
        
        update queues_arr a1
        set a1.c_active = v_status
        where a1.id = v_id;
    end;
    
end queues_arr_lib;
