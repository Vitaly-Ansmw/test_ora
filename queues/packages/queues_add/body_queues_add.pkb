CREATE OR REPLACE package body SYS.queues_add
is
    function execute_add (p_id in number
                          ,p_code in varchar2
                          ,p_name in varchar2
                          ,p_proc_type in number
                          ,p_queues_arr in number
                          ,p_in_queue in number
                          ,p_out_queue in number
                          ,p_suscriber in number)
    return number
    is
        v_in_queue number;
        v_out_queue number;
        queues_proc_ref queues_proc%rowtype;
        function check_dubl (v_value in varchar2
                             ,v_par in varchar2)
        return boolean
        is
            type founded_proc_tbl is table of number
            index by pls_integer;
            founded_proc founded_proc_tbl;
            cnt number := 0;
        begin
            founded_proc.delete;
            error_message := null;
            if v_value is null
            then
                error_message := 'Отсутствует значение для проверки дубликата'||chr(10);
                raise queues_error;
            elsif v_par is null
            then
                error_message := 'Отсутствует параметр для проверки дубликата'||chr(10);
                raise queues_error;
            end if;
            
            if v_par = 'ID'
            then
                select id
                bulk collect into founded_proc
                from queues_proc
                where id = v_value;
                
                cnt := founded_proc.count;

                if cnt = 0 
                then
                    return false;
                elsif cnt = 1
                then
                    error_message := 'Найдена похожая запись с id '||founded_proc(1)||chr(10);
                    return true;
                elsif cnt > 1
                then
                    for idx in founded_proc.first..founded_proc.last
                    loop
                        error_message := error_message||' Найдена похожая запись с кодом '||founded_proc(idx)||chr(10);
                    end loop;
                    return true;
                end if;
            
            elsif v_par = 'CODE'
            then
                select id
                bulk collect into founded_proc
                from queues_proc
                where c_code = v_value;
                
                cnt := founded_proc.count;
                
                if cnt = 0 
                then
                    return false;
                elsif cnt = 1
                then
                    error_message := 'Найдена похожая запись с кодом '||founded_proc(1)||chr(10);
                    return true;
                elsif cnt > 1
                then
                    for idx in founded_proc.first..founded_proc.last
                    loop
                        error_message := error_message||' Найдена похожая запись с кодом '||founded_proc(idx)||chr(10);
                    end loop;
                    return true;
                end if;
            end if;    
        end;

    begin
        if p_id is null
        then
                queues_proc_ref.id := get_id_object.nextval;
        else
            if check_dubl(p_id,'ID')
            then
                raise queues_error;
            else
                queues_proc_ref.id := p_id;
            end if;
        end if;
        
        if p_code is null
        then
            error_message := 'Код очереди пустой'||chr(10);
            raise queues_error;
        else
            if check_dubl(p_code,'CODE')
            then
                raise queues_error;
            else
                queues_proc_ref.c_code := p_code;
            end if;
        end if;
        
        if p_name is null
        then
            error_message := 'Наименование не может быть пустым'||chr(10);
            raise queues_error;
        else
            queues_proc_ref.c_name := p_name;
        end if;
            
        if p_in_queue = p_out_queue
        then 
            error_message := 'Очереди не могут быть идентичны друг другу'||chr(10);
            raise queues_error;
        else
            v_in_queue := p_in_queue;
            v_out_queue:= p_out_queue;
        end if;
        
        if p_proc_type is null
        then
            error_message := 'Отсутсвует значение процесса'||chr(10);
            raise queues_error;
        else
           queues_proc_ref.c_proc_type := p_proc_type;
        end if;
        
        if p_queues_arr is null
        then
            queues_proc_ref.c_queues_arr := get_collection.nextval;
        else
            queues_proc_ref.c_queues_arr := p_queues_arr;
        end if;
        
        if p_in_queue is not null
        then
            v_in_queue := queues_arr_add.execute_add(null,0,queues_proc_ref.c_queues_arr,p_in_queue);
        end if;
        
        if p_out_queue is not null
        then
            v_out_queue := queues_arr_add.execute_add(null,1,queues_proc_ref.c_queues_arr,p_out_queue);
        end if;
        
        insert into queues_proc (id,c_code, c_name, c_proc_type, c_queues_arr)
        values (queues_proc_ref.id, queues_proc_ref.c_code, queues_proc_ref.c_name, queues_proc_ref.c_proc_type, queues_proc_ref.c_queues_arr);
        
        return queues_proc_ref.id;
        
    exception when queues_error
    then
        dbms_output.put_line(error_message);
    when others
    then
        dbms_output.put_line(error_message);
    end;
            
end queues_add;
/