create or replace package certificate_type_lib
is
    type cert_type_tbl is table of z#CERTIFICATE_TYPE%rowtype
    index by varchar2(100);
    cert_type cert_type_tbl;
    procedure reset_cashe;
    function get_type_ref_by_code (p_code in varchar2)
    return number;
end;
    
        