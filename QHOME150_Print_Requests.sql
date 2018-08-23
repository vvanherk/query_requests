alter session set current_schema=pcuser;


select DocumentCode_CG, pp.policynumber, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where DocumentCode_CG like '%QHOME150%'
;
--and to_char(d.createtime, 'yyyymmdd') > '20170515' 
--and to_char(d.createtime, 'yyyymmdd') < '20170614' ;

--and to_char(d.createtime, 'yyyymmdd') > '20170414' 
--and to_char(d.createtime, 'yyyymmdd') < '20170514' ;

select DocumentCode_CG, pp.policynumber, pol.productcode, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
join pc_policy pol on pol.id = pp.policyid
where DocumentCode_CG like '%HOME132%'
;


--and pp.periodend > sysdate; 

select DocumentCode_CG, pp.policynumber, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where pp.id in (
  select pp.basedonid
    from pcx_DocProdDocument_CG d
    join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
    join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
    where DocumentCode_CG like '%HOME150%'
--    and to_char(d.createtime, 'yyyymmdd') > '20100101' 
--    and to_char(d.createtime, 'yyyymmdd') < '20160101' 
  )
;


// Get distinct cancellation doc codes
// from any Job rescinded with QHOME150
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
    and to_char(d.createtime, 'yyyymmdd') > '20100101' 
    and to_char(d.createtime, 'yyyymmdd') < '20160101' 
  )
  );
  
  


select DocumentCode_CG, pp.policynumber, pp.jobid, pp.basedonid,  pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
    where DocumentCode_CG like 'FHOME150%'
    and to_char(d.createtime, 'yyyymmdd') > '20100101' 
    and to_char(d.createtime, 'yyyymmdd') < '20160101' 
;

select * from j
pc_policyperiod pp
where PP.POLICYNUMBER = '4230000526';

select * from pc_job j
where j.jobnumber = '2123469';


select * from pcx_docproddocument_cg dpd
join pcx_docprodprintrequest_cg pr on dpd.docprintrequest_cg = pr.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
join pc_job j on pp.jobid = j.id
where j.jobnumber = '2123469';



select j.cancelreasoncode, dpd.contact from pc_job j, pcx_docproddocument_cg dpd
join pcx_docprodprintrequest_cg pr on dpd.docprintrequest_cg = pr.id
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
--join j on pp.jobid = j.id
where j.jobnumber = '2123469';


select * from pcx_docprodprintrequest_cg dpd
where dpd.policyperiod = ( 
  select pp.polcy  from 
  pc_policyperiod pp ;


select DocumentCode_CG, pp.policynumber, pr.policyperiod, pp.jobid, d.addresseecontactref, pp.periodstart, pp.periodend, d.createtime
from pcx_DocProdDocument_CG d
join pcx_DocProdPrintRequest_CG pr on d.DocPrintRequest_CG = pr.ID
join pc_PolicyPeriod pp on pr.PolicyPeriod = pp.ID
where DocumentCode_CG like '%HOME132%'
--and to_char(d.createtime, 'yyyymmdd') > '20150101' 
--and to_char(d.createtime, 'yyyymmdd') < '20160101' ;
;

