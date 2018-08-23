

select * from pc_formpattern fp
where fp.internalgroupcode like '%MORTGAGEE%';

select DocumentCode_CG, pp.policynumber, pol.productcode, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
join pc_policy pol on pol.id = pp.policyid
where DocumentCode_CG like '%HOME132%'
;

select distinct doc.docCode from (
select DocumentCode_CG as docCode, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where  (f.formpatterncode like 'MortgageeNotCancelJob' 
--or f.formpatterncode like '%MortgageeNotRescind%'
--or f.formpatterncode like '%MortgageeNotCancel%'
)
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 
)
doc
order by docCode
;



select distinct form.fPattern from (
select DocumentCode_CG, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
--where DocumentCode_CG like '%FCANC405%'
where DocumentCode_CG like '%FMORT200%'
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 

)
form
;


select DocumentCode_CG, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
--where DocumentCode_CG like '%FCANC405%'
where DocumentCode_CG like '%HOME132%'
and f.formpatterncode like '%Home132%'
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 

;
