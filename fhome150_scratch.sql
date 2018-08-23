

select * from pc_form pf
where pf.formpatterncode like '%FADD%'
;

select dpd.productcode_cg, dpd.businessmarketcontext_cg, dpd.transactiontype_cg, dpd.cancelreasoncode_cg, dpd.reason,  dpd.recipienttype_cg, dpd.additionalinteresttype_cg, dpd.subtransaction_cg from
;
select distinct dpd.documentcode_cg from pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'QCANC%'
order by dpd.documentcode_cg;

------
select * from pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE '%FMORT300%'
and dpd.productcode_cg != 'Retired'
order by dpd.transactiontype_cg asc ;

-- transaction types
select * from pctl_job;


select * from pcx_docproddocumentcodes_cg dpd
where dpd.publicid = 'FARM:2030' or dpd.publicid = 'FARM:176'
order by dpd.publicid desc ;

select * from pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg like 'QCANC201R'
or dpd.documentcode_cg like 'cccccccQCANC%';

select * from pcx_docproddocumentcodes_cg dpd
where dpd.publicid = 'FARM:2030' or dpd.publicid = 'FARM:3150' or dpd.publicid = 'FARM:176'
order by dpd.publicid desc ;


select * from pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'HOME132%'
and dpd.publicid like '%%'
order by dpd.transactiontype_cg;

--and dpd.additionalinteresttype_cg = 'Mortgagee'
--or dpd.publicid = 'FARM:176';
--or dpd.documentcode_cg like '%FMORT100CG%' ;

select * from
pcx_docproddocumentcodes_cg dpd
where dpd.reason LIKE '%taken%';

select * from
pcx_docproddocumentcodes_cg dpd
where dpd.productcode_cg = 'Farm_CG'
and dpd.subtransaction_cg LIKE '%Rescinded%';

select * from
pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'QCANC701%'
and dpd.productcode_cg != 'Retired';

select * from
pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'HOME132%'
and dpd.productcode_cg != 'Retired';

select * from
pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'QPREM%';
and dpd.productcode_cg != 'Retired'
and dpd.subtransaction_cg is null;

select * from pcx_cancellationreason_cg;
select * from pcx_cancellationsubreason_cg;

select * from pctl_cancellationreason_cg;
select * from pctl_cancellationsource;
select * from pctl_cancellationsource;

select * from pctl_reasoncode rc
where rc.typecode like '%902%';

select * from pctl_reasoncode rc
where rc.description like '%908%';




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

select * from PCUSER.PCTL_DWELLINGTYPE_CG;

select * from pctl_evaluationsoftware_cg;

select * from PCUSER.pc_uwcompany;

select distinct p.productcode from pcuser.pc_policy p;

select productcode, count(*) from pcuser.pc_policy group by productcode;

select * from PCUSER.pc_job;
select * from PCUSER.pctl_job;




