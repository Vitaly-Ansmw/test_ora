create or replace package exception_lib
is
    cert_type_nf exception;
    pragma exception_init(cert_type_nf,-000100);
    cert_type_tmr exception;
    pragma exception_init(cert_type_nf,-000101);
    
end;