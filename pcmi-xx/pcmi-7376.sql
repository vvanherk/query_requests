select pp.policynumber, j.jobnumber, p.productcode, pp.editeffectivedate, pp.periodend,  pp.basestate,  pp.policytermid
from pcuser.pc_policyperiod pp

inner join pcuser.pc_policy p on p.id = pp.policyid
inner join pcuser.pc_job j on j.id = pp.jobid
where p.productcode = 'Farm_CG'
and pp.modeldate > sysdate - 7
and rownum < 11
;


----------------------------

select * from pcuser.pctl_state;

select * from pcuser.pc_policyperiod
where rownum < 11;

select * from pcuser.pc_building
where rownum < 11;
