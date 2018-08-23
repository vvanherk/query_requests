

select * from pc_formpattern fp
where fp.internalgroupcode like '%MORTGAGEE%';

select * from pcx_docproddocumentcodes_cg;

select * from pcx_docprodprintcode_cg dppc
where dppc.policylinecode like '%FLiab%';

select * from pcx_docprodprintcode_cg dppc;
where dppc.coveragepatterncode like '%covFLOn%';

covFLOnSiteCleanup	700	0	Farm_CG		FLiabLine_CG	17-03-06 13:16:19.810000000	0	printcode:11310	sectionAdditionalCoverages	11		6000	covFLOnSiteCleanup	Optional Liability	17-03-06 13:16:19.810000000	132	0	cgic	11covFLOnSiteCleanup	700	0	Farm_CG		FLiabLine_CG	17-03-06 13:16:19.810000000	0	printcode:11310	sectionAdditionalCoverages	11		6000	covFLOnSiteCleanup	Optional Liability	17-03-06 13:16:19.810000000	132	0	cgic	11

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
