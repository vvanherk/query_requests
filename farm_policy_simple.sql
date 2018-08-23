

select pp.policynumber, j.jobnumber, p.productcode, pp.modeldate
from pcuser.pc_policyperiod pp

inner join pcuser.pc_policy p on p.id = pp.policyid
inner join pcuser.pc_job j on j.id = pp.jobid
where p.productcode = 'Farm_CG'
and pp.modeldate > sysdate - 7
and rownum < 11
;

select distinct productcode from pcuser.pc_policy;

