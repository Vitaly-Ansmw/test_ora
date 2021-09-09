create or replace package certificate_lib
is
    subtype type_certificate is  z#CERTIFICATE%rowtype;
    
    function add_certificate(p_client in client_lib.client_type
                             ,p_doc_type in varchar2
                             ,p_numb in varchar2
                             ,p_main in boolean
                             ,p_check in boolean default true)
    return type_certificate;
end certificate_lib;
                             