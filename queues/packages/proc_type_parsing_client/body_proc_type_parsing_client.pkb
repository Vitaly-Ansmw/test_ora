create or replace package body proc_type_parsing_client
is
    procedure interface (p_message in xmltype)
    is
        datapack xmltype;
        firstname varchar2(1000);
        is_self_null exception;
        pragma exception_init(is_self_null,-30625);
        function checknode (v_message in out nocopy xmltype
                            ,v_par_group in varchar2
                            ,v_parameter in varchar2)
        return boolean
        is
        begin
            if v_message.existsnode('client/grouppar[@value = "'||v_par_group||'"]/parameter[@value = "'||v_parameter||'"]') = 1
            then
              return true;
            else
                return false;
            end if;
        end;
        function get_note_string(v_message in out nocopy xmltype
                                 ,v_par_group in varchar2
                                 ,v_parameter in varchar2)
        return varchar2
        is
        begin
            return v_message.extract('client/grouppar[@value = "'||v_par_group||'"]/parameter[@value = "'||v_parameter||'"]/text()').getstringval;
        exception when is_self_null
        then
            return null;
        end;
        
    begin
        datapack := p_message;
        if checknode (datapack,'ClientInfo','FirstName')
        then
            firstname := get_note_string (datapack,'ClientInfo','FirstName');
            dbms_output.put_line(firstname);
        end if;
    end;
end;
        