-- �������� ���������� ����, ������� ����� ��������� ������� �������
create or replace type xml_to_clob as object(put_in clob);
-- �������� ������� �������
begin
    dbms_aqadm.create_queue_table('CL_ACT','xml_to_clob',multiple_consumers => true);
end;
-- �������� ��� ������� ������� �������
select * from user_queue_tables;
-- ���� �������
select * from CL_ACT
-- ������� ������� CLIENT_Q
begin
    dbms_aqadm.create_queue('CLIENT_Q','CL_ACT');
end;
-- ������ �������
begin
    dbms_aqadm.start_queue('CLIENT_Q');
end;
-- ��������� �������
begin
    dbms_aqadm.stop_queue('CLIENT_Q');
end;