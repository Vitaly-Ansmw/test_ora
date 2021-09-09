create or replace package client_lib
is
    subtype client_type is z#CLIENT%rowtype;
end;