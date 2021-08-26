with demo_xml as (
                  SELECT XMLELEMENT (
           "Employee",
           XMLAttributes (
               'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
               'http://www.oracle.com/Employee.xsd'
                  AS "xsi:nonamespaceSchemaLocation"),
           XMLELEMENT ("EmployeeNumber", id),
           XMLELEMENT ("EmployeeName", c_name),
           XMLELEMENT ("Location", c_doc)) xml
  FROM z#CLIENT
  WHERE ROWNUM = 1
                  )
select t.xml.extract('//EmployeeNumber/text()').getstringval()
from demo_xml t


select * from z#TEST_XML




<?xml version="1.0" encoding="UTF-8" ?>
<Employee xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<EmployeeNumber>101</EmployeeNumber>
<EmployeeName>CHEGRAVINA EKATERINA ANDREEVNA</EmployeeName>
<Location>351</Location>
</Employee>
                                


with demo_xml as (

select xmltype('<?xml version="1.0" encoding="UTF-8" ?>
<client xmlns:xsi="http://www.test.org" xsi:nonamespaceSchemaLocation="http://www.test.xsd">
<clientfio>
    <name></name>
    <surname></surname>
    <patronymic></patronymic>
    <datebirthday></datebirthday>
</clientfio>
<document>
    <num></num>
    <type></type>
    <whoissued></whoissued>
    <whereissued></whereissued>
    <date></date>
</document>
<contacts>
    <num></num>
    <type></type>
    <main></main>
</contacts>
<address>
    <country></country>
    <region></region>
    <city></city>
    <street></street>
    <house></house>
    <flat></flat>
</address>
</client>') xml
from dual 
                  )
select t.xml.extract('//type/text()').getstringval()
from demo_xml t