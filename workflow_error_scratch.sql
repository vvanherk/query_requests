select p.id
from pcuser.pc_policyperiod pp
inner join PCUSER.pc_policy p on p.id = pp.policyid
where pp.policynumber = '1005280937';


select * from PCUSER.pc_policy p 
where p.pol;


select * from PCUSER.pc_policy p 
where p.id = 82944;

select * from PCUSER.pc_losshistentry lh
where lh.policyid = 842352;

select * from PCUSER.pctl_applyto_cg;

select count(*) from PCUSER.pc_losshistentry lh
where lh.applytotype_cg = 10001
and lh.building_cg is null;

select count(*) from PCUSER.pc_losshistentry lh
where lh.applytotype_cg = 10001
and lh.building_cg is not null;




--and lh.building_cg is not null



