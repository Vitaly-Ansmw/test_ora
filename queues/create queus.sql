-- создание обьектного типа, который будет содержать таблица очереди
create or replace type xml_to_clob as object(put_in clob);
-- создание таблицы очереди
begin
    dbms_aqadm.create_queue_table('CL_ACT','xml_to_clob',multiple_consumers => true);
end;
-- проверка что таблицы очереди создана
select * from user_queue_tables;
-- сама таблица
select * from CL_ACT
-- создаем очередь CLIENT_Q
begin
    dbms_aqadm.create_queue('CLIENT_Q','CL_ACT');
end;
-- запуск очереди
begin
    dbms_aqadm.start_queue('CLIENT_Q');
end;
-- остановка очереди
begin
    dbms_aqadm.stop_queue('CLIENT_Q');
end;