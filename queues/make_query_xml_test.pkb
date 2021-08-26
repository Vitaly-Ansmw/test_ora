declare
    x xmltype;
begin
    select xmltype(
               '<?xml version="1.0" encoding="UTF-8" ?>
<client xmlns:xsi="/localhost/test.html" xsi:nonamespaceSchemaLocation="http://www.test.xsd">
<grouppar value="ClientInfo">
    <parameter value="FirstName"></parameter>
    <parameter value="LastName"></parameter>
    <parameter value="MiddleName"></parameter>
    <parameter value="Gender"></parameter>
    <parameter value="BirthDay"></parameter>
    <parameter value="BirthPlace"></parameter>
</grouppar>
<grouppar value="Documents">
    <parameter value="Type"></parameter>
    <parameter value="Series"></parameter>
    <parameter value="Number"></parameter>
    <parameter value="IssueDate"></parameter>
    <parameter value="IssueAuthority"></parameter>
    <parameter value="IssueCode"></parameter>
    <parameter value="IssuePlace"></parameter>
    <parameter value="OldNumber"></parameter>
    <parameter value="ExpiryDate"></parameter>
</grouppar>
<grouppar value="Phones">
    <parameter value="Type"></parameter>
    <parameter value="Number"></parameter>
    <parameter value="Main"></parameter>
</grouppar>
<grouppar value="Address">
    <parameter value="Type"></parameter>
    <parameter value="Location"></parameter>
    <parameter value="Street"></parameter>
    <parameter value="PostalCode"></parameter>
    <parameter value="Country"></parameter>
    <parameter value="Region"></parameter>
    <parameter value="District"></parameter>
    <parameter value="StreetType"></parameter>
    <parameter value="HouseNumber"></parameter>
    <parameter value="Block"></parameter>
    <parameter value="Building"></parameter>
    <parameter value="Apartment"></parameter>
</grouppar>
</client>')
into x
from dual ;

proc_type_parsing_client.interface(x);

end;


with demo as (select xmltype('<?xml version="1.0" encoding="UTF-8" ?>
<client xmlns:xsi="/localhost/test.html" xsi:nonamespaceSchemaLocation="http://www.test.xsd">
<grouppar value="ClientInfo">
    <parameter value="FirstName">asdasdasddsad</parameter>
    <parameter value="LastName"></parameter>
    <parameter value="MiddleName"></parameter>
    <parameter value="Gender"></parameter>
    <parameter value="BirthDay"></parameter>
    <parameter value="BirthPlace"></parameter>
</grouppar>
<grouppar value="Documents">
    <parameter value="Type"></parameter>
    <parameter value="Series"></parameter>
    <parameter value="Number"></parameter>
    <parameter value="IssueDate"></parameter>
    <parameter value="IssueAuthority"></parameter>
    <parameter value="IssueCode"></parameter>
    <parameter value="IssuePlace"></parameter>
    <parameter value="OldNumber"></parameter>
    <parameter value="ExpiryDate"></parameter>
</grouppar>
<grouppar value="Phones">
    <parameter value="Type"></parameter>
    <parameter value="Number"></parameter>
    <parameter value="Main"></parameter>
</grouppar>
<grouppar value="Address">
    <parameter value="Type"></parameter>
    <parameter value="Location"></parameter>
    <parameter value="Street"></parameter>
    <parameter value="PostalCode"></parameter>
    <parameter value="Country"></parameter>
    <parameter value="Region"></parameter>
    <parameter value="District"></parameter>
    <parameter value="StreetType"></parameter>
    <parameter value="HouseNumber"></parameter>
    <parameter value="Block"></parameter>
    <parameter value="Building"></parameter>
    <parameter value="Apartment"></parameter>
</grouppar>
</client>') xml
from dual )
select extract(xml,'client/grouppar[@value = "ClientInfo"]/parameter[@value = "FirstName"]/text()').getstringval()
,existsnode(xml,'client/grouppar[@value = "ClientInfo"]/parameter[@value = "FirstName"]')
from demo