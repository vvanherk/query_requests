-----------------------------------------------------------------------------------------------

--AUTO

select 
POLICYNUMBER,
LOCATION_ID,
EFFECTIVE_STARTDATE,
EFFECTIVE_ENDDATE,
ADDRESSLINE_1,
ADDRESSLINE_2,
CITY,
POSTAL_CODE,
STATE,
COUNTRY,
LATITUDE,
LONGITUDE,
LOB,
CREATE_DATETIME,
UPDATE_DATETIME,
TIV,
ANNUAL_PREMIUM

from
(
select distinct
pp.policynumber as POLICYNUMBER,
1 as LOCATION_ID,
TO_CHAR(PP.PERIODSTART, 'YYYY-MM-DD') as EFFECTIVE_STARTDATE,
TO_CHAR(PP.PERIODEND, 'YYYY-MM-DD') as EFFECTIVE_ENDDATE,
REPLACE(adr.addressline1, ',', ' ') as ADDRESSLINE_1,
REPLACE(adr.addressline2, ',', ' ') as ADDRESSLINE_2,
REPLACE(adr.city, ',', ' ') as CITY,
REPLACE(adr.postalcode, ',', ' ') as POSTAL_CODE,
REPLACE(st.typecode, ',', ' ') as STATE,
'CANADA' as COUNTRY,
adr.latitude as LATITUDE,
adr.longitude as LONGITUDE,
'AUTO' as LOB,
TO_CHAR(SYSDATE, 'YYYY-MM-DD') as CREATE_DATETIME,
TO_CHAR(SYSDATE, 'YYYY-MM-DD') as UPDATE_DATETIME,
NULL as TIV,
NULL as ANNUAL_PREMIUM

FROM pcuser.pc_policyperiod pp   
    INNER JOIN pcuser.pc_policy pol ON pol.id = pp.policyid   
    INNER JOIN PCUSER.PC_POLICYCONTACTROLE pcr on pp.id = pcr.branchid
    INNER JOIN PCUSER.PC_ACCOUNTCONTACTROLE acr on acr.id = pcr.accountcontactrole
    INNER JOIN PCUSER.PC_ACCOUNTCONTACT ac on ac.id = acr.accountcontact
    INNER JOIN PCUSER.PC_CONTACT con on con.id = ac.contact 
    INNER JOIN PCUSER.pc_address adr on adr.id = con.primaryaddressid
    INNER JOIN PCUSER.pctl_state st on adr.state = st.id
    
where
    pol.productcode in('IRAuto_CG') and
    pcr.subtype = 18 and
    --pcr.subtype = (select id from PCUSER.pctl_policycontactrole where PCUSER.pctl_policycontactrole.TYPECODE = 'PolicyPriNamedInsured') and
    
     pp.modeldate is not null and  
      trunc(pp.periodstart) < sysdate and  
      trunc(pp.periodend) > sysdate and 
       
      pp.termnumber = (select max(termnumber) from pcuser.pc_policyperiod pptest where pptest.policyid=pp.policyid  and  
      trunc(pptest.periodstart) < sysdate and  
      trunc(pptest.periodend) > sysdate and  
      trunc(pptest.modeldate) < sysdate 
      and trunc(pptest.editeffectivedate) < sysdate) and 
       
      pp.modeldate = (select max(modeldate) from pcuser.pc_policyperiod pptest where pptest.policyid=pp.policyid and  
      pptest.termnumber=pp.termnumber and trunc(pptest.modeldate) < sysdate 
      and trunc(pptest.editeffectivedate) < sysdate) and  
       
      (pp.cancellationdate is null or trunc(pp.cancellationdate) > sysdate) 
      and pp.retired=0 
)

