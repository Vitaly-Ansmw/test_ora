create or replace package certificate_type_lib
is
    function get_type_ref_by_code (p_code in varchar2)
    return number;
end;
    
        