-- values to select
select 
pp.policynumber, j.jobnumber, j.subtype as "JobSubtype", a.accountnumber, s.name as "status" ,p.productcode, 

bt.name as "BldgType", b.buildingnum, b.id, b.fixedid, b.description, b.description_cg, b.farmnumgranaries_cg, et.name as "Source", 

TO_CHAR(b.replacementevaldate_cg, 'YYYY-MM-DD HH24:MI:SS,FF3') as "ReplacementEvalDate"

from pcuser.pc_building b

-- entities to join
-- policy period id joins on building branchid
inner join pcuser.pc_policyperiod pp on pp.id = b.branchid

-- job id joins on policy period jobid
inner join pcuser.pc_job j on j.id = pp.jobid

-- policy id joins on policyperiod policyid
inner join pcuser.pc_policy p on p.id = pp.policyid

--account id joins on policy accountid
inner join pcuser.pc_account a on a.id = p.accountid

-- typelists tp join
-- list building type id join on building subtype
inner join pcuser.pctl_building bt on bt.id = b.subtype

-- list evaluationsoftware_cg joins on building evaluaitonsource_cg
inner join PCUSER.pctl_evaluationsoftware_cg et on et.id = b.evaluationsource_cg

-- list policyperiostatus joins on policy period status
inner join pcuser.pctl_policyperiodstatus s on s.id = pp.status

--
inner join PCUSER.pcx_ppropbuilding_cg ppb on ppb.building_cg = b.id

--
inner join PCUSER.pcx_ppropbuildingcov_cg ppbc on ppbc.ppropbuilding_cg = ppb.id

-- clauses
--where 
-- building type needs to be FarmStructure_CG
--bt.name = 'FarmStructure_CG'
-- temp resrtrict row count
where rownum < 100
-- policy period company is CGIC
--and pp.uwcompany = 2
-- policy period not cancelled
--and pp.cancellationdate IS NULL
-- policyperiod number not invalid
--and pp.policynumber not like 'Invalid%'
-- policy product code is FARM_CG
--and p.productcode = 'Farm_CG'
--
and a.accountnumber ='3424355864'  --vvh sit3
and j.jobnumber ='7814272';

--------------------------------------------------------------

select distinct PolicyNumber from (
select pp.policynumber as PolicyNumber, pp.periodend as PeriodEnd, aid.mortgagerequired, buildingnum, bldg.riskoption_cg,  prop.inflationapplies_cg 
from PCUSER.pc_policyperiod pp
inner join pc_policy p on pp.policyid = p.id
inner join PCUSER.pc_job job on pp.jobid = job.id
inner join pcuser.pcx_PPropBuilding_CG prop on pp.id = prop.branchid
inner join pcuser.pc_building bldg on bldg.id = prop.building_cg
inner join PCUSER.pc_addlinterestdetail aid on bldg.id = aid.building
where 1=1
and to_char(pp.periodend, 'yyyymmdd') > '20170821' 
and to_char(pp.periodend, 'yyyymmdd') < '20171101' 
and aid.mortgagerequired = '1'
and p.productcode = 'Farm_CG'


AND ( ( pp.termnumber      IS NULL 
  AND NOT EXISTS 
    (SELECT id 
    FROM pc_policyperiod pterm 
    WHERE pterm.policyid  =pp.policyid 
    AND pterm.termnumber IS NOT NULL 
    ) ) 
  OR ( pp.termnumber= 
    (SELECT MAX(termnumber) 
    FROM pc_policyperiod pterm 
    WHERE pterm.policyid=pp.policyid and status = '8'
    ) 
  AND ( pp.mostrecentmodel=1 
  OR NOT EXISTS 
    (SELECT id 
    FROM pc_policyperiod pterm 
    WHERE pterm.policyid =pp.policyid 
    AND pterm.termnumber    =pp.termnumber 
    AND pterm.mostrecentmodel=1 
    ) ) ) )

)
;


select pp.ID as "Branch"
, aid.ID, aid.CreateTime, aid.UpdateTime, aid.ChangeType, aid.PolicyAddlInterest
from pc_PolicyPeriod pp
join pc_Job j on pp.JobID = j.ID
join pcx_PPropBuilding_CG ppb on pp.ID = ppb.BranchID
join pc_Building b on pp.ID = b.BranchID and ppb.Building_CG = b.FixedId
join pc_AddlInterestDetail aid on pp.ID = aid.BranchID and b.FixedId = aid.Building
where 1=1
and j.JobNumber = '502964'
;


and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 


This will return latest BOUND periods

AND ( ( pp.termnumber      IS NULL 
  AND NOT EXISTS 
    (SELECT id 
    FROM pc_policyperiod pterm 
    WHERE pterm.policyid  =pp.policyid 
    AND pterm.termnumber IS NOT NULL 
    ) ) 
  OR ( pp.termnumber= 
    (SELECT MAX(termnumber) 
    FROM pc_policyperiod pterm 
    WHERE pterm.policyid=pp.policyid and status = '8'
    ) 
  AND ( pp.mostrecentmodel=1 
  OR NOT EXISTS 
    (SELECT id 
    FROM pc_policyperiod pterm 
    WHERE pterm.policyid =pp.policyid 
    AND pterm.termnumber    =pp.termnumber 
    AND pterm.mostrecentmodel=1 
    ) ) ) )




select * from PCUSER.pc_building b
inner join pcuser.pc_policyperiod pp on pp.id = b.branchid
where pp.policynumber = '4050028300';

select * from pcuser.pc_policylocation;

select * from PCUSER.pcx_cpropbuildingcov_cg pbc
where pbc.cpropbuilding_cg = 291423;

select * from pcx_cpropbuilding_cg pb
where pb.id = 129469;

select * from pc_building b 
where b.id = 233879;


select count(*) from 
(select b.id, b.heritagehome_cg
from pc_building b 
where b.heritagehome_cg =1);

select * from PCUSER.pcx_buildg_dsc_l10n pbd
 where pbd.value like 'Fe%';


