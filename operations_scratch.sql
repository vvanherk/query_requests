alter session set current_schema=pcuser;

select ibcsplitcode, ibccodedescription from pcx_operation_cg op
where 1=1
--and op.ibccode like '%0121%'
and op.ibcsplitcode like '%0121d00'
--and op.branchid like '%7018522%'
;


select pp.policynumber, pp.producercodeofrecordid, pg.regnname, j.jobnumber, pp.editeffectivedate from pc_policyperiod pp 
inner join pc_job j on j.id = pp.jobid
inner join pcrv_producergroupsflat pg on pg.producercodeid = pp.producercodeofrecordid
where 1=1
and pp.policynumber like '%2404%'
order by pp.policynumber desc
;

select * from PCUSER.pcrv_grouptreeflat gtf
where gtf.id like '%1%';

select * from PCUSER.pcrv_producergroupsflat pgf
where pgf.producercodecode like '%71809%'; 

select * from pc_producercode pdc
 where pdc.code like '%71809%'; 

select * from pc_group pg
where pg.id = 995;

select po.p from pcx_policyoperation_cg po;

select * from pctl_ratingenginecontext_cg;


select pp.policynumber, j.jobnumber, pp.editeffectivedate,  op.ibcsplitcode from pcx_operation_cg op 
inner join pc_policyperiod pp on pp.id = op.branchid
inner join pc_job j on j.id = pp.jobid
--inner join pcrv_producergroupsflat.producercodeid on pp.producercodeofrecordid
where 1=1
--and op.ibcsplitcode like '%0121d00%'
--and pp.policynumber like '%2404%'
order by pp.policynumber desc
;



select po.branchid, po.operation_cg from pcx_policyoperation_cg po
where 1=1
and po.branchid like '%37355%'
;

select * from pcx_coverageosfi_cg  os
where os.osficode_cg = 50
and os.coveragepatterncode_cg like '%Pot%';

select * from pcx_nonrefundablecoverage_cg;

select * from pc_group;

select * from pcx_prod




-- From Shashank - tweaked by vvh
select  distinct PA.ACCOUNTNUMBER, Case co.subtype when 2 then CO.FirstName || ' ' || CO.LASTNAME 
else Co.Name end as Account_NAme,policynumber,
TO_CHAR(pp.periodstart, 'yyyy-mm-dd') as "PERIODSTART",
TO_CHAR(pp.periodend, 'yyyy-mm-dd') as "PERIODEND"
from pcx_Operation_CG PO,pc_policyperiod PP,PC_policy P,pc_job PJ,pc_account PA,pc_accountcontact AC,pc_contact CO,pc_accountcontactrole ACR 
where ibcsplitcode='0121d00' and PP.id=po.branchid
and pp.periodstart>to_date('20170918000000','YYYYMMDDHH24MISS') 
and pp.periodend>to_date('20180115235959','YYYYMMDDHH24MISS') 
and p.id=pp.policyid and PRODUCTCODE ='Farm_CG' and MostRecentModel=1
and PJ.id=pp.jobid and pj.subtype<>2 
and P.ACCOUNTID =PA.ID and AC.ACCOUNT=PA.id and ac.contact=CO.id
and  ACR.subtype=2 and ACR.ACCOUNTCONTACT=AC.id and acr.retired=0
and pp.cancellationdate is null
order by PERIODEND
;

-- ===================================================================================================================
-- Operations
-- ===================================================================================================================
SELECT pp.policynumber,
  j.jobnumber,
  tlj.name                                        AS job_type,
  pps.name                                        AS period_status,
  TO_CHAR(j.createtime , 'yyyy-mm-dd hh24:mi:ss') AS job_create_time
FROM pcuser.pcx_PolicyOperation_CG op
  --
INNER JOIN pcuser.pc_policyperiod pp
ON pp.id = op.branchid
INNER JOIN pcuser.pc_job j
ON j.id = pp.jobid
  --
INNER JOIN PCUSER.pctl_policyperiodstatus pps
ON pps.id = pp.status
  --
INNER JOIN PCUSER.pctl_job tlj
ON tlj.id = j.subtype
INNER JOIN pcuser.pctl_yesorno_cg yn
ON yn.id        = op.insothpolicy
AND yn.typecode = 'yes';
