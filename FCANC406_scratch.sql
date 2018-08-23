alter session set current_schema= pcuser;


select * from pcx_docprodprintcode_cg;

select pcs.name, pcs.id from pctl_cancellationsource pcs;

-- select doc code base on code, and transaction types
select * from
pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'FCANC406%'
--where dpd.documentcode_cg LIKE 'FADDINTCANCP'
--where dpd.documentcode_cg LIKE 'FMORT100CG'
and dpd.productcode_cg != 'Retired'
--and (dpd.transactiontype_cg = 6 or dpd.transactiontype_cg = 8)  -- reinstate / rewrite
;
--order by dpd.transactiontype_cg;


select * from pctl_cancellationsource;

select * from pctl_cancellationreason_cg;

select * from pcx_cancellationreason_cg pcr
where 1=1
and pcr.;

-- select doc code base on code, and transaction types
select dpd.productcode_cg, dpd.businessmarketcontext_cg, dpd.transactiontype_cg, dpd.source_cg, dpd.reason, dpd.recipienttype_cg from
--select * from 
pcx_docproddocumentcodes_cg dpd
where dpd.documentcode_cg LIKE 'FCANC406%'
--where dpd.documentcode_cg LIKE 'FADDINTCANCP'
--where dpd.documentcode_cg LIKE 'FMORT100CG'
and dpd.productcode_cg = 'Farm_CG'
and dpd.businessmarketcontext_cg = '10001'  -- cgic
and dpd.transactiontype_cg = 2              -- cancel
--and dpd.source_cg = '10004'                 -- 
and dpd.productcode_cg != 'Retired'
--and (dpd.transactiontype_cg = 6 or dpd.transactiontype_cg = 8)  -- reinstate / rewrite
;
--order by dpd.transactiontype_cg;



-- count of each document
select documentcode_cg, count(documentcode_cg) from PCUSER.pcx_docproddocument_cg 
group by documentcode_cg
order by count(documentcode_cg) desc; 



-- cancellation source
select * from pctl_cancellationsource cs
order by cs.id;

-- cancellation reason
select * from pctl_cancellationreason_cg cr
order by cr.id;



select distinct cs.name, subtransaction_cg,  cancelreasoncode_cg
from PCUSER.pcx_docproddocumentcodes_cg dpdc
inner join PCUSER.pctl_recipienttype_cg rt on rt.id = dpdc.recipienttype_cg
inner join PCUSER.pctl_cancellationsource cs on cs.id = dpdc.source_cg
--where productcode_cg in ('Farm_CG', 'Cooperators_CG')
where productcode_cg <> 'Retired'
and dpdc.documentcode_cg in ('FCANC406')
--and cancelreasoncode_cg is not null
--and source.name like  '%nsured'
--order by productcode_cg 
order by cs.name
;

-- distinct fpatterncodes used to print specific doc
select distinct fpattern from (
select DocumentCode_CG as doc_code, pr.id as prID, pp.policynumber as policyNumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where DocumentCode_CG like '%FCANC406%'
--where DocumentCode_CG like '%FMORT300%'
and to_char(d.createtime, 'yyyymmdd') > '20100101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101'
);


select count(*) from pc_form f
where 1=1 
and f.formpatterncode like 'FCANC406%'
;


-- Get documents based on DocumentCode
-- for specific date rage
-- order by document create time
select DocumentCode_CG as doc_code, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where DocumentCode_CG like '%FCANC405%'
and to_char(d.createtime, 'yyyymmdd') > '20160101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 
order by d.createtime desc
;


