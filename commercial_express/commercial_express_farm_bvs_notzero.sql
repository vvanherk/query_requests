-- values to select
select 
pp.policynumber, j.jobnumber, j.subtype as "JobSubtype", a.accountnumber, s.name as "status", p.productcode, 

bt.name as "BldgType", b.buildingnum, b.bvsadjustmentpercentage_cg, et.name as "Source"

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

-- clauses
where 
-- building type needs to be FarmStructure_CG
bt.name = 'FarmStructure_CG'
-- bv adjustment not zero
and b.bvsadjustmentpercentage_cg <>0;
-- policy period company is CGIC
and pp.uwcompany = 2
-- policy period not cancelled
and pp.cancellationdate IS NULL
-- policyperiod number not invalid
and pp.policynumber not like 'Invalid%'
-- evaluationsource name is BVS
and et.name = 'BVS'
-- building replacement eval date is <= 20160101
--and b.replacementevaldate_cg < sysdate - 150
--and b.replacementevaldate_cg <= TO_DATE('2016/01/01','yyyy/mm/dd')
-- policy product code is FARM_CG
and p.productcode = 'Farm_CG'
-- policy period most recent model > 0
and pp.mostrecentmodel > 0

-- ===================================================================================================================
-- Find latest bound periods
-- ===================================================================================================================
AND((pp.termnumber IS NULL AND NOT EXISTS
    (SELECT id
    FROM pcuser.pc_policyperiod pterm
    WHERE pterm.policyid  =pp.policyid
    AND pterm.termnumber IS NOT NULL
    ) ) OR ( pp.termnumber=
    (SELECT MAX(termnumber)
    FROM pcuser.pc_policyperiod pterm
    WHERE pterm.policyid      =pp.policyid
    ) AND ( pp.mostrecentmodel=1 OR NOT EXISTS
      (SELECT id
      FROM pcuser.pc_policyperiod pterm
      WHERE pterm.policyid     =pp.policyid
      AND pterm.termnumber     =pp.termnumber
      AND Pterm.Mostrecentmodel=1
      ) ) ) )

;




