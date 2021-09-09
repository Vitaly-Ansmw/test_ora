create or replace package certificate_type_lib
is
    type cert_type_tbl is table of z#CERTIFICATE_TYPE%rowtype
    index by varchar2(100);
    cert_type cert_type_tbl;
    type cert_rec is record (id number
                             ,c_code varchar2(100)
                             ,c_ret_numb varchar2(100)
                             ,c_ret_strock varchar2(100)
                             ,c_ret_numb_strock varchar2(100));
    function get_type_ref_by_code (v_code in varchar2)
    return number;
    function check_doc_by_type(p_code in varchar2,p_numb in varchar2)
    return varchar2;
end;
    
        