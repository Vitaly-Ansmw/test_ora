CREATE OR REPLACE package body SYS.queues_arr_add
is
    function execute_add (p_id in number
                          ,p_type in number
                          ,p_collection_id number
                          ,p_id_query in number
                          ,p_active in number default 0)
    return number
    is
    begin
        if p_id is null
        then
           queues_arr_ref.id := get_id_object.nextval;
        else
            queues_arr_ref.id := p_id;
        end if;
        
        if p_type is null
        then
            error_message := 'Некорректно задано значение типа очереди'||chr(10);
            raise queues_error;
        else
            queues_arr_ref.c_type := p_type;
        end if;
        
        if p_collection_id is null
        then
            error_message := 'Некорректно задано значение типа очереди'||chr(10);
            raise queues_error;
        else
            queues_arr_ref.collection_id := p_collection_id;
        end if;
        
        queues_arr_ref.c_id_query := p_id_query;
        queues_arr_ref.c_active := p_active;
        
        insert into queues_arr (id, collection_id, c_type, c_id_query, c_active)
        values (queues_arr_ref.id, queues_arr_ref.collection_id, queues_arr_ref.c_type, queues_arr_ref.c_id_query, queues_arr_ref.c_active);
        
        return queues_arr_ref.id;
    end;
end;
/