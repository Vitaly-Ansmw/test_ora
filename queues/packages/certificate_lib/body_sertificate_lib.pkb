create or replace package body certificate_lib
is
    function add_certificate(p_client in client_lib.client_type
                             ,p_doc_type in varchar2
                             ,p_numb in varchar2
                             ,p_main in boolean
                             ,p_check in boolean default true)
    return type_certificate
    is
        cert_rec type_certificate; 
    begin
        if p_check 
        then  
            if p_client.id is null
            then
                raise exception_lib.cert_is_null;
            elsif p_doc_type is null
            then
                raise exception_lib.cert_doc_type;
            elsif p_numb is null
            then
                raise exception_lib.cert_numb_null;
            end if;
            
            cert_rec.c_doc_type := certificate_type_lib.get_type_ref_by_code(p_doc_type);
            cert_rec.c_numb_strock := certificate_type_lib.check_doc_by_type(p_doc_type,p_numb);
        end if;
    end;
end certificate_lib;
            