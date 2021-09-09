create or replace package body certificate_type_lib
is
      
    function get_type_ref_by_code (v_code in varchar2)
    return number
    is
    begin
        if cert_type.exists(v_code)
        then
            return cert_type(v_code).id;
        else
            raise exception_lib.cert_type_nf;
        end if;
    end;
    
    
    
    function check_doc_by_type(p_code in varchar2,p_numb in varchar2)
    return varchar2 
    is
        v_space_cnt number;
        space_position number;
        tmp_simvol varchar2(10);
        v_numb varchar2(100);
        v_cnt number := 1;
    begin
        if length(p_numb) = length(replace(cert_type(p_code).c_pattern,'_'))
        then
        -- посчитаем количество пробелов
        v_space_cnt := length(replace(cert_type(p_code).c_pattern,'*'));
        -- преобразуем по шаблону документа
            if v_space_cnt > 0
            then
                v_numb := p_numb;
                for idx2 in 1..v_space_cnt
                loop
                    /*ищем какой символ должен стоять до пробела, будем смещаться на 1 символ, 
                    так как на каждой итерациии будет  + 1 символ */
                    space_position := instr(cert_type(p_code).c_pattern,'_',1,idx2)- 1;
                   -- dbms_output.put_line ('space_position = '||space_position);
                    tmp_simvol := substr(v_numb,space_position ,1);
                   -- dbms_output.put_line ('tmp_simvol = '||tmp_simvol);
                    v_numb := regexp_replace(v_numb,tmp_simvol,tmp_simvol||' ',space_position ,1);
                   -- dbms_output.put_line ('v_numb = '||v_numb);
                    
                end loop;
            end if;
            return v_numb;        
         else
            raise exception_lib.cert_type_not_check;
         end if;
    end;
        
        
 
       
    begin
        
          if cert_type.count = 0
          then  
                for idx1 in (select *
                             from z#CERTIFICATE_TYPE)
                loop
                    cert_type(idx1.c_code).id := idx1.id;
                    cert_type(idx1.c_code).c_name := idx1.c_name;
                    cert_type(idx1.c_code).c_pattern := idx1.c_pattern;
                    cert_type(idx1.c_code).c_code := idx1.c_code;
                end loop;
          end if;
end certificate_type_lib;
