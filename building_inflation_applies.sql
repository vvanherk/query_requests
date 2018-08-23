select pp.policynumber, buildingnum, bldg.riskoption_cg,  prop.inflationapplies_cg 
from PCUSER.pc_policyperiod pp
inner join PCUSER.pc_job job on pp.jobid = job.id
inner join pcuser.pcx_PPropBuilding_CG prop on pp.id = prop.branchid
inner join pcuser.pc_building bldg on bldg.id = prop.building_cg
--where pp.policynumber = '4050000000' and job.jobnumber = 705047
where pp.policynumber = '1052143491' and job.jobnumber = 1014103809 