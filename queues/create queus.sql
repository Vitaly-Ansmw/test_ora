-- создание обьектного типа, который будет содержать таблица очереди
create or replace type xml_to_clob as object(put_in clob);
-- создание таблиц для входящей и исходящей очереди:
begin
    dbms_aqadm.create_queue_table('CL_ADD_IN','xml_to_clob',multiple_consumers => true); -- Создание таблицы входящей очереди
end;
begin
    dbms_aqadm.create_queue_table('CL_ADD_OUT','xml_to_clob',multiple_consumers => true); -- Создание таблицы исходящей очереди
end;

-- проверка что таблицы очередей созданы
select * 
from user_queue_tables
where queue_table in ('CL_ADD_IN','CL_ADD_OUT');


-- Создание входящей и исходящей очереди
begin
    dbms_aqadm.create_queue('Q_ADD_CLIENT_IN','CL_ADD_IN'); -- Создание входящей очереди
end;
begin
    dbms_aqadm.create_queue('Q_ADD_CLIENT_OUT','CL_ADD_OUT'); -- Создание входящей очереди
end;

-- добавим запись в таблицу queues_proc
insert into queues_proc_type (id,c_code,c_name,c_note) 
values (get_id_object.nextval,'C_TEST','Тестовый входящий процесс','Тестовый входящей процесс'||chr(10)||'предназначен для добавления клиентов');
commit;
-- Проверка что добавился тип процесса
select * from queues_proc_type;
-- Создадим процесс
declare
    x number;
begin
    x := queues_add.execute_add(null,'TEST','Тестовый процесс',448,null,93472,93501,null);
    dbms_output.put_line(x);
    commit;
end;
-- проверим поцесс в таблице и коллекцию очередей
select * from queues_proc;
select * from queues_arr;


-- запуск очереди
begin
    dbms_aqadm.start_queue('CLIENT_Q');
end;
-- остановка очереди
begin
    dbms_aqadm.stop_queue('CLIENT_Q');
end;


truncate table queues_arr