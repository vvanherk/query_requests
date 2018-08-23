select rcg.id, rcgg.name from pcx_rule_cg rcg
join pctl_rulecoverage_cg rcgg
on rcg.rulecoverage_cg = rcgg.id
order by rcg.createtime desc;

select rcg.id, rcg.bridnumber_cg from pcx_rule_cg rcg
order by rcg.bridnumber_cg desc;
where rcg.publicid = 'cg:4403';

select * from pcx_rule_cg;

select * from pcx_filechecksum_cg;

select * 
from PCX_FILECHECKSUM_CG
where 1=1
and name like 'Rule%.csv'; 

select * from pcx_rule_activity_cg;
where publicid like '%4553';
select * from pcx_rule_cg;


select * from pcst_rule_activity_cg;
select * from pcst_rule_cg;

select * from pctl_rulecommenttype_cg;
select * from pctl_rulecoverage_cg;
select * from pctl_rulelevel_cg;
select * from pctl_ruleline_cg;
select * from pctl_ruleprefix_cg;
select * from pctl_rulelevel_cg;
select * from pctl_ruleprefix_cg;
select * from pctl_rulesettype;
select * from pctl_rulestatus_cg;
select * from pctl_ruletype_cg;








SELECT TABLE_NAME 
FROM DBA_TABLES
WHERE TABLE_TYPE = 'BASE TABLE'  ;