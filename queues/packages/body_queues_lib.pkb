create or replace package body queues_lib
is
    function init_queue_proc(v_process in number)
    return queues_proc_rec
    is
        queues_prc queues_proc_rec;
    begin
        select a1.id
        ,a1.c_code
        ,a1.c_name
        ,a1.c_proc_type
        ,a1.c_queues_arr
        into queues_prc.id
        ,queues_prc.c_code
        ,queues_prc.c_name
        ,queues_prc.c_proc_type
        ,queues_prc.c_queues_arr
        from queues_proc a1
        where a1.id = v_process;
        
        queues_prc.c_queues_arr_info := queues_arr_lib.get_info_recs(queues_prc.c_queues_arr);
        
        return queues_prc;
    end;
    
    procedure start_queue_proc (p_process in number)
    is
        queues_prc queues_proc_rec;
        in_par number; 
    begin
        if p_process is null
        then
            raise prc_is_null;
        end if;
        
        in_par := p_process;
                
        queues_prc := init_queue_proc(in_par);
        
        for idx1 in queues_prc.c_queues_arr_info.first..queues_prc.c_queues_arr_info.last
        loop
            begin
                if queues_prc.c_queues_arr_info(idx1).c_active = 0
                then
                    dbms_aqadm.start_queue(queues_prc.c_queues_arr_info(idx1).queue_name);
                    queues_arr_lib.change_status(queues_prc.c_queues_arr_info(idx1).id,1);
                end if;
            end;
        end loop;
    end;
    
    procedure stop_queue_proc (p_process in number)
    is 
        queues_prc queues_proc_rec;
        in_par number;
    begin
        if p_process is null
        then
            raise prc_is_null;
        end if;
        
        in_par := p_process;
                
        queues_prc := init_queue_proc(in_par);
        
        
        for idx1 in queues_prc.c_queues_arr_info.first..queues_prc.c_queues_arr_info.last
        loop
            begin
                if queues_prc.c_queues_arr_info(idx1).c_active = 1
                then
                    dbms_aqadm.stop_queue(queues_prc.c_queues_arr_info(idx1).queue_name);
                    queues_arr_lib.change_status(queues_prc.c_queues_arr_info(idx1).id,0);
                end if;
            end;
        end loop;
    end;
        
    function status_queue_proc (p_process in number)
    return queues_status_tbl pipelined
    is
        result_status queues_status_tbl;
    begin
        if p_process is null
        then
            raise prc_is_null;
        end if;
        
        select a1.c_name
        ,c1.name
        ,case when b1.c_type = 0
            then 'Исходящая'
            when b1.c_type = 1 
            then 'Входящая'
            else null
        end queue_type
        ,case when c1.enqueue_enabled = '  YES  '
            then 'Активна'
            when c1.enqueue_enabled = '  NO  '
            then 'Неактивна'
            else null
        end queue_status
        bulk collect into result_status
        from queues_proc a1
        ,queues_arr b1
        ,all_queues c1
        where b1.collection_id = a1.c_queues_arr
        and c1.qid = b1.c_id_query;
        
        if result_status.count = 0
        then
            return;
        elsif result_status.count > 0 
        then
            for idx1 in result_status.first..result_status.last
            loop
                pipe row(result_status(idx1));
            end loop;
        end if;
        
        return;
    end;

end queues_lib;

