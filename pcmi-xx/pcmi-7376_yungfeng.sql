select 
distinct pp.policynumber as PolicyNumber, 
job.jobnumber as "JobNumber",
po.productcode as "Product", 
ro.name as "RiskType",
sta.name as Province,
bldg.buildingnum,
TO_CHAR(pp.periodend, 'YYYY/MM/DD') AS "PeriodEnd"


from pcuser.pc_policyperiod pp 
inner join pcuser.pc_policy po on po.id = pp.policyid 
inner join PCUSER.pc_building bldg on bldg.branchid = pp.id
inner join PCUSER.pctl_riskoption_cg ro on bldg.riskoption_cg = ro.id 
inner join pcuser.pc_job job on pp.jobid = job.id 
inner join pcuser.PCTL_JOB tljob on tljob.id = job.subtype

inner join pcuser.pctl_state sta on sta.id = pp.basestate
inner join pcuser.pctl_dwellingcovlevel_cg cl on bldg.dwellingcovlevel_cg=cl.id
inner join pcuser.pcx_PPropBuilding_CG pbldg on pbldg.building_cg = bldg.fixedid
inner join  pcuser.pcx_PPropBuildingCov_CG ppc on ppc.ppropbuilding_cg = pbldg.id
and cl.typecode in ('FarmTenantsClassic', 'FarmTenantsPrestige')
and ppc.patterncode like 'covExtendedWater%'
and pp.status <> 3 
and po.productcode = 'Farm_CG'

and pp.policynumber not like 'Invalid%' 
and tljob.name <> 'Cancellation'

and pp.periodend > sysdate
AND
  
  ( 
  (pp.termnumber IS NULL
AND NOT EXISTS
  (SELECT id
  FROM pcuser.pc_policyperiod pterm
  WHERE pterm.policyid  =pp.policyid
  AND pterm.termnumber IS NOT NULL
  ))
OR
  (pp.termnumber=
  (SELECT MAX(termnumber)
  FROM pcuser.pc_policyperiod pterm
  WHERE pterm.policyid=pp.policyid
  )
AND
  
  (pp.mostrecentmodel=1
  
OR NOT EXISTS
  (SELECT id
  FROM pcuser.pc_policyperiod pterm
  WHERE pterm.policyid     =pp.policyid
  AND pterm.termnumber     =pp.termnumber
  AND pterm.mostrecentmodel=1
  )) ) )
  
order by policynumber;
