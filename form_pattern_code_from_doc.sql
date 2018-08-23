alter session set current_schema=pcuser;

--select distinct form.fPattern from (
select DocumentCode_CG, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
--where DocumentCode_CG like '%FCANC405%'
where DocumentCode_CG like '%HOME132%'
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 
;
--)
--form;

select distinct doc.docCode from (
select DocumentCode_CG as docCode, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where  (f.formpatterncode like '%MortgageeNot%' 
--or f.formpatterncode like '%MortgageeNotRescind%'
--or f.formpatterncode like '%MortgageeNotCancel%'
)
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 
)
doc
order by docCode
;



--select distinct doc.docCode from (
select DocumentCode_CG as docCode, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where  (f.formpatterncode like '%MortgageeNot%' )
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 
--)
--doc
--order by docCode
;

select pp.jobid from pc_policyperiod pp
where pp.policynumber  = '4230000526';


--select pp.id from pc_policyperiod pp
--where pp.jobid in(
select pp.id, j.jobnumber, j.cancelreasoncode from pc_job j
join pc_policyperiod pp on j.id = pp.jobid
where pp.policynumber = '4230000526'
--)
;
-- job 2123469

select * from pcx_docprodprintrequest_cg dppr
join pc_policyperiod pp on dppr.policyperiod = pp.id
where pp.jobid = '2123469';


select * from pcx_docproddocument_cg dpd
where dpd.docprintrequest_cg = '8212';




select * from pcx_docproddocument_cg dpd
where dpd.id in (
  select dppr.id from pcx_docprodprintrequest_cg dppr
  where dppr.policyperiod = '8821'
  )
  ;
  
  select dppr.id from pcx_docprodprintrequest_cg dppr
  where dppr.policyperiod = '12401';



and pp.periodend > sysdate; 

