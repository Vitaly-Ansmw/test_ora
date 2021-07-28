create table z#QUEUES_LOG (
                            p_process number,
                            p_add timestamp default systimestamp not null,
                            p_msg varchar2(4000)
                            );