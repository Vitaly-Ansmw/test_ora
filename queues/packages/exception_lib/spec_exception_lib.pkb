create or replace package exception_lib
is
    cert_type_nf exception;
    pragma exception_init(cert_type_nf,-000100);
    cert_is_null exception;
    pragma exception_init (cert_is_null,-000102);
    cert_doc_type exception;
    pragma exception_init (cert_doc_type,-000103);
    cert_numb_null exception;
    pragma exception_init (cert_numb_null,-000104);
    cert_type_not_check exception;
    pragma exception_init(cert_type_not_check,-000110);
    
end;