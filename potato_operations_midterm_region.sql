alter session set current_schema=pcuser;



select pp.policynumber, pp.producercodeofrecordid, pdc.code, pdc.description, pdc.branchid,   pg.regnname, j.jobnumber, pp.editeffectivedate from pc_policyperiod pp 
inner join pc_job j on j.id = pp.jobid
inner join pc_producercode pdc on pdc.id = pp.producercodeofrecordid
inner join pcrv_producergroupsflat pg on pg.producercodeid = pp.producercodeofrecordid
where 1=1
and pp.policynumber like '%2404%'
order by pp.policynumber desc
;



-- Potato operations guidwire midterm rating scenario
select  distinct pa.accountnumber, 
  case co.subtype when 2 then co.firstname || ' ' || co.lastname 
  else co.name end as account_name,
  pdc.code as producercode, pgf.regnname as region, pp.policynumber,
  to_char(pp.periodstart, 'yyyy-mm-dd') as periodstart,
  to_char(pp.periodend, 'yyyy-mm-dd') as periodend
from pcx_operation_cg po, pc_policyperiod pp, pc_policy p, pc_job pj, 
  pc_account pa, pc_accountcontact ac, pc_contact co, pc_accountcontactrole acr, 
  pc_producercode pdc, pcrv_producergroupsflat pgf
where ibcsplitcode='0121d00' and pp.id=po.branchid
and pp.periodstart > to_date('20170918000000','YYYYMMDDHH24MISS') 
and pp.periodend > to_date('20180115235959','YYYYMMDDHH24MISS') 
and p.id=pp.policyid and p.productcode ='Farm_CG' and pp.mostrecentmodel=1
and pj.id=pp.jobid and pj.subtype<>2 
and p.accountid=pa.id and ac.account=pa.id and ac.contact=co.id
and  acr.subtype=2 and acr.accountcontact=ac.id and acr.retired=0
and pp.producercodeofrecordid = pgf.producercodeid
and pdc.id = pp.producercodeofrecordid
and pp.cancellationdate is null

order by producercode, periodend
;


-- Potato operations policies 
select  distinct pa.accountnumber, 
  case co.subtype when 2 then co.firstname || ' ' || co.lastname 
  else co.name end as account_name,
  pdc.code as producercode, pgf.regnname as region, pp.policynumber,
  to_char(pp.periodstart, 'yyyy-mm-dd') as periodstart,
  to_char(pp.periodend, 'yyyy-mm-dd') as periodend
from pcx_operation_cg po, pc_policyperiod pp, pc_policy p, pc_job pj, 
  pc_account pa, pc_accountcontact ac, pc_contact co, pc_accountcontactrole acr, 
  pc_producercode pdc, pcrv_producergroupsflat pgf
where ibcsplitcode='0121d00' and pp.id=po.branchid
and pp.periodend > to_date('20171208235959','YYYYMMDDHH24MISS') 
and p.id=pp.policyid and p.productcode ='Farm_CG' 
and pp.mostrecentmodel=1
and pj.id=pp.jobid and pj.subtype<>2 
and p.accountid=pa.id and ac.account=pa.id and ac.contact=co.id
and  acr.subtype=2 and acr.accountcontact=ac.id and acr.retired=0
and pp.producercodeofrecordid = pgf.producercodeid
and pdc.id = pp.producercodeofrecordid
and pp.cancellationdate is null

-- ===================================================================================================================
-- Find latest bound periods
-- ===================================================================================================================
AND((pp.termnumber IS NULL AND NOT EXISTS
    (SELECT id
    FROM pcuser.pc_policyperiod pterm
    WHERE pterm.policyid  =pp.policyid
    AND pterm.termnumber IS NOT NULL
    ) ) OR ( pp.termnumber=
    (SELECT MAX(termnumber)
    FROM pcuser.pc_policyperiod pterm
    WHERE pterm.policyid      =pp.policyid
    ) AND ( pp.mostrecentmodel=1 OR NOT EXISTS
      (SELECT id
      FROM pcuser.pc_policyperiod pterm
      WHERE pterm.policyid     =pp.policyid
      AND pterm.termnumber     =pp.termnumber
      AND Pterm.Mostrecentmodel=1
      ) ) ) ) 

order by region, producercode, periodend
;


