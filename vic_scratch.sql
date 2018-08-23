

select * from
pcx_docproddocumentcodes_cg dpd
where dpd.reason LIKE '%FADDINT113%';

-- join policy to policy period
select pp.policynumber, pp.policyid, pp.conversionstatus_cg, pp.periodid, pp.policytermid, pp.termnumber, pp.updatetime, pp.uwapproval_cg, p.accountid, 
      s.name, p.
from pcuser.pc_policyperiod pp
inner join PCUSER.pc_policy p on p.id = pp.policyid
-- list policyperiostatus joins on policy period status
inner join pcuser.pctl_policyperiodstatus s on s.id = pp.status
where pp.policynumber = '1053927226';

--4050016681
--where pp.policynumber = '1053927226';
select *
from pcuser.pc_policyperiod pp
inner join PCUSER.pc_policy p on p.id = pp.policyid
where pp.policynumber = '1007105130';

select * from PCUSER.pc_policy p 
where p.id = 82944;

select * from PCUSER.pctl_evaluationsoftware_cg;

select * from PCUSER.pc_losshistentry lh
where lh.building_cg is not null
and lh.policyid = ;

---building data
select * from PCUSER.pc_building pb
where pb.description_cg like '%fer%';

select * from pcuser.pc_building b
where b.description_cg is not null;

select * from pcuser.pc_building b
where b.description is not null;


select p.id
from pcuser.pc_policy p;

select * from pcuser.pc_building b
where b.bvsadjustmentpercentage_cg <>0;

--select productcode, count(*) from pcuser.pc_policy group by productcode

select subtype from pcuser.pc_building;

select * from PCUSER.pctl_building;

-- some bvs stuff
select count (*) from (
select * from PCUSER.pc_building b
inner join PCUSER.pctl_evaluationsoftware_cg et on et.id = b.evaluationsource_cg
where ET.TYPECODE= 'BVS'
) x;


select distinct pp.uwcompany from pcuser.pc_policyperiod pp;

select distinct edf.offeringcode
from pc_policyperiod pp
join pc_effectivedatedfields edf on pp.id = edf.branchid ;

select * from PCUSER.PCTL_DWELLINGTYPE_CG;


select edf.offeringcode, edf.branchid from pc_effectivedatedfields edf;


select * from pcuser.pc_policyperiod pp
where pp.off


select * from pctl_evaluationsoftware_cg;

select * from PCUSER.pc_uwcompany;

select distinct p.productcode from pcuser.pc_policy p;

select productcode, count(*) from pcuser.pc_policy group by productcode;


select * from PCUSER.pc_job;
select * from PCUSER.pctl_job;


from pcuser.pc_policyperiod pp
where pp.policynumber > '4050005000';

select 
* 
from PCUSER.pc_policy p
;


--, j.jobnumber, p.productcode, pp.modeldate
--from pcuser.pc_policyperiod pp

--inner join pcuser.pc_policy p on p.id = pp.policyid
--inner join pcuser.pc_job j on j.id = pp.jobid
--where pp.
--where p.productcode = 'Farm_CG'
--and pp.modeldate > sysdate - 7
where rownum < 11
;

--select * from PCUSER.pc_building
--where rownum < 11;
