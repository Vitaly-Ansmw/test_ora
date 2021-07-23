create table z#QUEUES_LOG (
                            p_process varchar2(1000),
                            p_add timestamp default systimestamp not null,
                            p_msg varchar2(4000)
                            );