Select   
acc.accountnumber,  
pp.policynumber,  
pp.primaryinsuredname as "PRIMARY NAMED INSURED",  
pc.code as "PRODUCER CODE",   
pc.description as "PRODUCER NAME",  
prov.l_en_ca PROVINCE,
TO_CHAR(PP.PERIODSTART, 'yyyy-mm-dd') AS "POLICY EFFECTIVE DATE",     
TO_CHAR(PP.PERIODEND, 'yyyy-mm-dd')  as  "POLICY EXPIRY DATE",  
termtype.description TERM,
locn.locationnum   
from pcuser.pc_policylocation locn  
inner join PCUSER.pc_policyperiod pp on locn.branchid = pp.policyid  
inner join PCUSER.pc_job job on job.id = pp.jobid  
inner join pcuser.pc_policy po on po.id = pp.policyid   
inner join PCUSER.pc_producercode pc on pc.id = po.producercodeofserviceid   
inner join PCUSER.pctl_firehalldistance_cg dist on dist.id = locn.firehalldistance_cg  
INNER JOIN PCUSER.PC_UWCOMPANY uw ON uw.id = pp.uwcompany  
inner join PCUSER.pc_account acc on acc.id = po.accountid  
inner join pcuser.pctl_job jobtype on jobtype.id = job.subtype 
inner join PCUSER.pctl_jurisdiction prov on prov.id = pp.basestate
inner join PCUSER.pctl_termtype termtype on termtype.id = pp.termnumber
where 1 = 1  
and dist.retired = 1  
and job.subtype <> 2 
and uw.parentname <> 'CGIC' 
and pp.policynumber not like 'Invalid%'  
and pp.policynumber <> 'Unassigned'  
and locn.expirationdate is null  
and po.productcode = 'Farm_CG'  
AND    
(   
  ( pp.termnumber IS NULL   
  AND NOT EXISTS   
    (SELECT id   
      FROM pcuser.pc_policyperiod pterm   
      WHERE pterm.policyid =pp.policyid   
      AND pterm.termnumber IS NOT NULL   
  )    
)   
OR    
(    
  pp.termnumber=   
    (   
      SELECT MAX(termnumber)   
      FROM pcuser.pc_policyperiod pterm   
      WHERE pterm.policyid=pp.policyid   
    )   
AND (    
      pp.mostrecentmodel=1   
      OR NOT EXISTS   
      (   
        SELECT id   
        FROM pcuser.pc_policyperiod pterm   
        WHERE pterm.policyid =pp.policyid   
        AND pterm.termnumber =pp.termnumber   
        AND pterm.mostrecentmodel=1   
      )    
      ) ) )    
order by pp.policynumber, locn.locationnum
;
