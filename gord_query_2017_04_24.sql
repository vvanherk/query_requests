select distinct a.accountnumber, pp.policynumber, pc.code as producercode, uwcom.parentname as company,    
to_char(trunc(pp.periodstart,'dd'),'yyyymmdd') as policyeffectivedate,  
to_char(trunc(pp.periodend,'dd'),'yyyymmdd') as policyexpirydate, pp.termnumber, s.typecode as locationprovince, b.buildingnum, ro.name as risktype, 
es.typecode as evaluationsource, b.replacementcost_cg,
jt.name as Jobtype 
from pcuser.pc_building b 
inner join pcuser.pc_policyperiod pp on b.branchid = pp.id 
inner join pcuser.pc_policy p on pp.policyid = p.id 
INNER JOIN PCUSER.PCTL_POLICYPERIODSTATUS pps ON pps.id = pp.status 
INNER JOIN pcuser.pc_job j ON j.id = pp.jobid  
INNER JOIN pcuser.pctl_job jt ON jt.id = j.subtype  
inner join pcuser.pc_account a on p.accountid = a.id 
inner join pcuser.pc_producercode pc on pp.producercodeofrecordid = pc.id 
inner join pcuser.pc_uwcompany uwcom on pp.uwcompany = uwcom.id 
inner join pcuser.pc_policylocation pl on pp.id = pl.branchid 
inner join pcuser.pctl_state s on pl.stateinternal = s.id 
inner join pcuser.pctl_riskoption_cg ro on b.riskoption_cg = ro.id 
inner join pcuser.pctl_evaluationsoftware_cg es on b.evaluationsource_cg = es.id 
left outer join pcuser.pcx_fpropbuilding_cg ppb on ppb.branchid = pp.id 
where pp.retired = 0 
and uwcom.parentname = 'CGIC' 
and pp.mostrecentmodel = 1  
and jt.typecode != 'Cancellation'  
and pps.typecode = 'Bound'
and b.actualcashvalueamt_cg is null
--and es.typecode != 'RCT'  
and b.replacementcost_cg < 10000
--and pp.policynumber = '1005943767'
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
      order by policyexpirydate
