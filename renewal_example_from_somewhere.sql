select 
pp.policynumber, 
j.jobnumber, 
ppst.typecode as status, 
p.productcode, 
PP.MULTIPOLICYINTERFACESUCCESS_CG, 
j2.jobnumber, 
cb.creditband_cg, 
cb.creditscorecalled_cg as pp1creditbandcalled, 
cb2.creditband_cg as pp2creditband, 
cb2.creditscorecalled_cg as pp2creditbandcalled 
from pcuser.pc_policyperiod pp  
join pcuser.pc_job j on j.id = pp.jobid 
join pcuser.pc_policy p on pp.policyid = p.id 
join pcuser.pctl_job jt on jt.id = j.subtype 
join PCUSER.pctl_policyperiodstatus ppst on ppst.id = pp.status 
join PCUSER.pcx_creditscoreband_cg cb on cb.branchid = pp.id 
join pcuser.pc_policyperiod pp2 on pp2.id = pp.basedonid 
join PCUSER.pcx_creditscoreband_cg cb2 on cb2.branchid = pp2.id 
join pcuser.pc_job j2 on pp2.jobid = j2.id 
where  
      jt.typecode = 'Renewal' 
  
  and pp.basedonid is not null 
  and pp.branchnumber = 1 
  and pp.createtime >= '2016-04-04'