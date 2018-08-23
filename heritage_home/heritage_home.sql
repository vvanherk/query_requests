select  /*+ INDEX(b PK_BUILDING) */
        distinct a.accountnumber, pp.policynumber, 
        TO_CHAR(pp.periodstart, 'YYYY-MM-DD') as "PERIODSTARTDATE",
        TO_CHAR(pp.periodend, 'YYYY-MM-DD') as "PERIODENDDATE",             
        s.name as "STATUS", p.productcode, 
        b.buildingnum, b.id as BUILDING_ID,
        b.heritagehome_cg

from pcuser.pc_policy p

-- entities to join
-- policy id joins on policyperiod policyid
inner join PCUSER.pc_policyperiod pp on p.id = pp.policyid

-- policy period id joins on building branchid
inner join pcuser.pc_building b on pp.id = b.branchid

-- job id joins on policy period jobid
inner join pcuser.pc_job j on j.id = pp.jobid


--account id joins on policy accountid
inner join pcuser.pc_account a on a.id = p.accountid

-- list policyperiostatus joins on policy period status
inner join pcuser.pctl_policyperiodstatus s on s.id = pp.status



-- clauses
where 
-- policy period company is CGIC
pp.uwcompany = 2
-- policy period not cancelled
and pp.cancellationdate IS NULL
-- policyperiod number not invalid
and pp.policynumber not like 'Invalid%'
-- policy product code is FARM_CG
and p.productcode = 'Farm_CG'
-- policy period most recent model > 0
and pp.mostrecentmodel > 0
--
and b.heritagehome_cg =1


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