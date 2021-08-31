create or replace package body certificate_type_lib
is
    function get_type_ref_by_code (p_code in varchar2)
    return number
    is
        founded_rec number;
    begin
       select a1.id
       into founded_rec
       from z#CERTIFICATE_TYPE a1
       where a1.c_code = p_code;
                            
    exception when no_data_found
    then
         raise exception_lib.cert_type_nf;
    when too_many_rows
    then
         raise exception_lib.cert_type_tmr;
    end;
end;