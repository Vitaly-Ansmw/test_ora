create or replace package proc_type_parsing_client
is
    procedure interface (p_message in xmltype);
end;
        