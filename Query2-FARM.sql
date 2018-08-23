-----------------------------------------------------------------------
--FARM


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
plc.locationnum as LOCATION_ID,
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
'FARM' as LOB,
TO_CHAR(SYSDATE, 'YYYY-MM-DD') as CREATE_DATETIME,
TO_CHAR(SYSDATE, 'YYYY-MM-DD') as UPDATE_DATETIME,
NULL as TIV,
NULL as ANNUAL_PREMIUM

FROM pcuser.pc_policyperiod pp   
    --INNER JOIN PCUSER.pc_uwcompany uwcompany on uwcompany.id = pp.uwcompany 
    INNER JOIN pcuser.pc_policy pol ON pol.id = pp.policyid   
    INNER JOIN PCUSER.pc_policylocation plc on pp.id = plc.branchid
    INNER JOIN PCUSER.pc_address adr on plc.accountlocation = adr.id
    INNER JOIN PCUSER.pctl_state st on adr.state = st.id
    
where
    pol.productcode in('Farm_CG') and
    (plc.expirationdate is NULL or trunc(plc.expirationdate) > sysdate) and 
    
     pp.modeldate is not null and  
      trunc(pp.periodstart) < sysdate and  
      trunc(pp.periodend) > sysdate and 
       
      pp.termnumber = (select max(termnumber) from pcuser.pc_policyperiod pptest where pptest.policyid=pp.policyid  and  
      trunc(pptest.periodstart)<sysdate and  
      trunc(pptest.periodend) > sysdate and  
      trunc(pptest.modeldate) < sysdate 
      and trunc(pptest.editeffectivedate) < sysdate) and 
       
      pp.modeldate = (select max(modeldate) from pcuser.pc_policyperiod pptest where pptest.policyid=pp.policyid and  
      pptest.termnumber=pp.termnumber and trunc(pptest.modeldate) < sysdate 
      and trunc(pptest.editeffectivedate) < sysdate) and  
       
      (pp.cancellationdate is null or trunc(pp.cancellationdate) > sysdate) 
      and pp.retired=0
      
  --and pp.policynumber = '1058793526'
  

)

;