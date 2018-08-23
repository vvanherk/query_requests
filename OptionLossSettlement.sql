select distinct  
acc.accountnumber "Account Number",  
pp.policynumber "Policy Number",  
pp.primaryinsuredname "Primary Named Insured",  
pcode.code "Producer Code",  
g.name "Agent Office",  
to_char(pp.periodstart, 'YYYY-MM-DD') "Period Effective Date",  
to_char(pp.periodend, 'YYYY-MM-DD') "Period Expiration Date",  
jtl.name "Job Type",  
j.jobnumber "Work Order",  
pp.termnumber "Term Number",  
stl.name "Location Province", 
estl.name "Evaluation Source" 
from  
pcuser.pc_policyperiod pp  
inner join pcuser.pc_policy p on pp.policyid = p.id  
inner join pcuser.pc_account acc on p.accountid = acc.id  
inner join pcuser.pc_job j on pp.jobid = j.id  
inner join pcuser.pctl_job jtl on j.subtype = jtl.id  
inner join pcuser.pcx_calccovterm_cg cov on pp.id = cov.branchid  
inner join pcuser.pcx_ppropbuildingcov_cg ppbcov on cov.ppropbuildingcov_cg = ppbcov.id  
inner join pcuser.pcx_ppropbuilding_cg ppb on ppbcov.ppropbuilding_cg = ppb.id  
inner join pcuser.pc_building b on ppb.building_cg = b.id  
inner join pcuser.pctl_riskoption_cg rtl on b.riskoption_cg = rtl.id  
inner join pcuser.pc_policylocation pl on b.policylocation = pl.id  
inner join pcuser.pctl_state stl on pl.stateinternal = stl.id  
inner join pcuser.pc_producercode pcode on pp.producercodeofrecordid = pcode.id  
inner join pcuser.pc_group g on pcode.branchid = g.id  
inner join pcuser.pctl_policyperiodstatus ptl on pp.status = ptl.id  
left join pcuser.pctl_evaluationsoftware_cg estl on b.evaluationsource_cg = estl.id 
where cov.covtermcode_cg = 'BuildingSettlement_c'  
and cov.covtermvalue_cg = 140  
and ptl.name = 'Bound'  
and jtl.name != 'Cancellation'  
and pp.policynumber not like '%nassigned%'  
and ( ( pp.termnumber IS NULL  
AND NOT EXISTS  
  (SELECT id  
  FROM pcuser.pc_policyperiod pterm  
  WHERE pterm.policyid  =pp.policyid  
  AND pterm.termnumber IS NOT NULL  
  ) )  
OR ( pp.termnumber=  
  (SELECT MAX(termnumber)  
  FROM pcuser.pc_policyperiod pterm  
  WHERE pterm.policyid=pp.policyid  
  )  
AND ( pp.mostrecentmodel=1  
OR NOT EXISTS  
  (SELECT id  
  FROM pcuser.pc_policyperiod pterm  
  WHERE pterm.policyid     =pp.policyid  
  AND pterm.termnumber     =pp.termnumber  
  AND pterm.mostrecentmodel=1  
  ) ) ) )   
   
  order by g.name
  ;
