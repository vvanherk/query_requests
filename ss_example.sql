select 
pp.policynumber, j.jobnumber, a.accountnumber, s.name "status", p.productcode, 

bt.name as "BldgType", et.name as "Source", TO_CHAR(b.replacementevaldate_cg, 'YYYY-MM-DD HH24:MI:SS,FF3') as "ReplacementEvalDate"

from pcuser.pc_building b
-- entities
inner join pcuser.pc_policyperiod pp on pp.id = b.branchid
inner join pcuser.pc_job j on j.id = pp.jobid
inner join pcuser.pc_policy p on p.id = pp.policyid
inner join pcuser.pc_account a on a.id = p.accountid
-- typelists
inner join pcuser.pctl_building bt on bt.id = b.subtype
inner join PCUSER.pctl_evaluationsoftware_cg et on et.id = b.evaluationsource_cg
inner join pcuser.pctl_policyperiodstatus s on s.id = pp.status
--inner join pcuser.pc_un

where 
bt.name = 'FarmStructure_CG'

and rownum < 100
and pp.uwcompany = 2
and pp.policynumber not like 'Invalid%'
and et.name = 'BVS'
and b.replacementevaldate_cg < sysdate - 180
and p.productcode = 'Farm_CG'
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


select productcode, count(*) from pcuser.pc_policy group by productcode


select * from PCUSER.pc_uwcompany;
