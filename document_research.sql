alter session set current_schema=pcuser;


--Original query used for xHome150 metrics
select DocumentCode_CG, pp.policynumber, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where DocumentCode_CG like '%QHOME150%'

and to_char(d.createtime, 'yyyymmdd') > '20170515' 
and to_char(d.createtime, 'yyyymmdd') < '20170614' ;
--and to_char(d.createtime, 'yyyymmdd') > '20170414' 
--and to_char(d.createtime, 'yyyymmdd') < '20170514' ;
;


-- Get document codes that are registered mail
select distinct dpd.documentcode_cg from pcx_docproddocumentcodes_cg dpd
where dpd.registeredmail_cg > 0;
--and dpd.productcode_cg = 'Farm_CG';

-- Get count of documents generated
select documentcode_cg, count(documentcode_cg) from PCUSER.pcx_docproddocument_cg dpd
group by documentcode_cg
order by count(documentcode_cg) desc; 

-- Get count of any documents generated registered mail
select documentcode_cg, count(documentcode_cg) from PCUSER.pcx_docproddocument_cg dpd
where dpd.registeredmail_cg = 1
group by documentcode_cg
order by count(documentcode_cg) desc;

-- Get count of farm 'current' registered letters
select distinct docCode, docCount from (
  select documentcode_cg as docCode, count(documentcode_cg) as docCount from PCUSER.pcx_docproddocument_cg 
  group by documentcode_cg
  )
join pcx_docproddocumentcodes_cg dpdc on dpdc.documentcode_cg = docCode
where dpdc.registeredmail_cg > 0
--and dpdc.productcode_cg = 'Farm_CG'
order by docCount desc
; 

-- From Gord -- filter out doc codes
select distinct doc.documentcode_cg, doc.documenttype_cg, doc.registeredmail_cg, doc1.registeredmail_cg from PCUSER.pcx_docproddocumentcodes_cg doc
inner join PCUSER.pcx_docproddocumentcodes_cg doc1 on doc1.documentcode_cg = doc.documentcode_cg
where doc.registeredmail_cg = 1 and doc1.registeredmail_cg = 0
and doc.productcode_cg <> 'Retired'
and doc1.productcode_cg <> 'Retired'
--and doc1.transactiontype_cg = doc.transactiontype_cg
--and doc.reason = doc1.reason
---and doc.subtransaction_cg = doc1.subtransaction_cg
; 


-- Get specific documents based on doccode, etc
select * from pcx_docproddocument_cg dpd
where 1=1
and dpd.documentcode_cg = 'FCANC406'
and dpd.registeredmail_cg = 1
and to_char(dpd.createtime, 'yyyymmdd') > '20160101' 
and to_char(dpd.createtime, 'yyyymmdd') < '20171231' ;
order by dpd.documenteffectivedate_cg desc
;



-- Get documents based on DocumentCode
-- for specific date rage
-- order by document create time
select DocumentCode_CG as doc_code, pp.policynumber, pr.policyperiod, pp.jobid, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_form f on d.form = f.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where DocumentCode_CG like '%FCANC406%'
--where DocumentCode_CG like '%FMORT300CG%'
and to_char(d.createtime, 'yyyymmdd') > '20160101' 
and to_char(d.createtime, 'yyyymmdd') < '20180101' 
order by d.createtime desc
;

-- Get documents based on DocumentCode
-- for specific date rage
-- order by document create time
select distinct PolicyNumber, count(PolicyNumber) as pCount from (
  select DocumentCode_CG as doc_code, pp.policynumber as PolicyNumber, pr.policyperiod, pp.jobid, job.subtype, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
  from pcx_DocProdDocument_CG d
  join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
  join pc_form f on d.form = f.id
  join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
  join pc_job job on pp.jobid = job.id
  --where DocumentCode_CG like '%FCANC406%'
  where DocumentCode_CG like '%FMORT100CG%'
  and job.subtype = 6 --reinstatement
  and to_char(d.createtime, 'yyyymmdd') > '20100717' 
  and to_char(d.createtime, 'yyyymmdd') < '20180101' 
  order by d.createtime desc
)
group by PolicyNumber
order by pCount desc
;

-- investigate FMORT100 issue with rewrite/reinstate
select PolicyNumber, jType, pCount from (
select distinct PolicyNumber, jobType as jType, count(PolicyNumber) as pCount from (
  select DocumentCode_CG as doc_code, pp.policynumber as PolicyNumber, pr.policyperiod, pp.jobid, job.subtype as jobType, f.formpatterncode as fPattern, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
  from pcx_DocProdDocument_CG d
  join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
  join pc_form f on d.form = f.id
  join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
  join pc_job job on pp.jobid = job.id
  where 1=1
  and DocumentCode_CG like '%FMORT100CG%'
-- and DocumentCode_CG like '%FCANC406%'
  and (job.subtype = 6 or job.subtype = 8) -- reinstatement / rewrite
-- and job.subtype = 8 --rewrte
  and to_char(d.createtime, 'yyyymmdd') > '20170717' 
  and to_char(d.createtime, 'yyyymmdd') < '20180101'
  order by d.createtime desc
)
group by PolicyNumber, jobType
order by jobType desc
)
where pCount > 1
;



  
  -- Get count of farm 'current' registered letters
select distinct docCode, docCount from (
  select documentcode_cg as docCode, count(documentcode_cg) as docCount from PCUSER.pcx_docproddocument_cg 
  group by documentcode_cg
  )
join pcx_docproddocumentcodes_cg dpdc on dpdc.documentcode_cg = docCode
where dpdc.registeredmail_cg > 0
--and dpdc.productcode_cg = 'Farm_CG'
order by docCount desc
; 
 


select * from pc_job;


-- Check for inconsistencies in docproddoccode table for registereed mail indicator
select distinct doc.documentcode_cg, doc.documenttype_cg, doc.registeredmail_cg, doc1.registeredmail_cg from PCUSER.pcx_docproddocumentcodes_cg doc
inner join PCUSER.pcx_docproddocumentcodes_cg doc1 on doc1.documentcode_cg = doc.documentcode_cg
where doc.registeredmail_cg = 1 and doc1.registeredmail_cg = 0
and doc.productcode_cg <> 'Retired'
and doc1.transactiontype_cg = doc.transactiontype_cg
--and doc.reason = doc1.reason
--and doc.subtransaction_cg = doc1.subtransaction_cg
; 

select * from pc_job j
where j.registeredmail_cg > 0;

select * from pcx_docproddocumentcodes_cg dpdc
where 1=1
and dpdc.documentcode_cg like  'CANC406'
;

-- Get distinct cancellation doc codes
-- from any Job rescinded with QHOME150
select distinct docCode from (
select DocumentCode_CG as docCode, pp.policynumber, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where pp.id in (
  select pp.id
    from pcx_DocProdDocument_CG d
    join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
    join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
    where DocumentCode_CG like '%QHOME150%'
    and to_char(d.createtime, 'yyyymmdd') > '20150101' 
    and to_char(d.createtime, 'yyyymmdd') < '20160101' 
  )
  );
  
  

-- Get documents based on DocumentCode
-- for specific date rage
-- order by policy number
select DocumentCode_CG, pp.policynumber, pp.jobid, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
    where DocumentCode_CG like 'FMORT100%'
    and to_char(d.createtime, 'yyyymmdd') > '20150101' 
    and to_char(d.createtime, 'yyyymmdd') < '20160101' 
order by pp.policynumber
;


select * from pc_job j
where j.jobnumber = '2123469';


select * from pcx_docproddocument_cg dpd
join pcx_docprodprintrequest_cg pr on dpd.docprintrequest_cg = pr.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
join pc_job j on pp.jobid = j.id
where j.jobnumber = '2123469';


select * from pcx_docproddocument_cg dpd
;


