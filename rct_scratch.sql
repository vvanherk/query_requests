select 
to_char(pp.createTime, 'yyyy') as theDate, pb.riskoption_cg, 
count(1)
from pc_PolicyPeriod pp
  INNER JOIN PCUSER.PCTL_POLICYPERIODSTATUS pps ON pps.id = pp.status   
  INNER JOIN pcuser.pc_job j ON j.id = pp.jobid   
  INNER JOIN pcuser.pc_policy pol ON pol.id = pp.policyid   
  INNER JOIN pcuser.pctl_job jt ON jt.id = j.subtype    
  INNER JOIN PCUSER.pc_account a ON a.id = pol.accountid   
  INNER JOIN pcuser.pc_producercode proc on proc.id = pp.producercodeofrecordid  
  inner JOIN PCUSER.pc_uwcompany uwcompany on uwcompany.id = pp.uwcompany   
  inner join pcuser.pc_building  pb on pb.branchid = pp.id  
  inner join pcuser.pctl_evaluationsoftware_cg pg  on pb.evaluationsource_cg = pg.id  
  inner join pctl_riskoption_cg ro on ro.id = pb.riskoption_cg

where  
  pb.evaluationsource_cg is not null 
  and pb.evaluationsource_cg =pg.id and pg.typecode='RCT'  
  and pb.replacementcost_cg is not null  
  and  jt.name in ( 'Renewal')   
  and pp.CreateTime > to_date('2012-12-31','yyyy-mm-dd')
group by to_char(pp.createTime, 'yyyy'), pb.riskoption_cg
order by theDate, pb.riskoption_cg
; 
and PB.RISKOPTION_CG='10004'

select * from pcst_riskoptiontype_cg;
select * from pctl_riskoption_cg;

  
alter session set current_schema=pcuser;

select pb.riskoption_cg, count(*), count(1) from pcuser.pc_building  pb
inner join pctl_riskoption_cg ro on ro.id = pb.riskoption_cg
where pb.evaluationsource_cg is not null
and ro.description = 'Seasonal' 

group by pb.riskoption_cg 
;

select count(*) from pcuser.pc_building  pb

SELECT  unique  
  uwcompany.parentname                                AS COMPANY,   
 pp.policynumber                                     AS POLICY_NUMBER,   
  a.accountnumber                                     AS ACCOUNT_NUMBER,  
j.jobnumber                                         AS JOB_NUMBER,   
 jt.name                                             AS JOB_TYPE,   
 PPS.name                                            AS PERIOD_STATUS,   
 TO_CHAR(PP.EDITEFFECTIVEDATE, 'yyyy-mm-dd hh24:mi') AS EDIT_EFFECTIVE_DATE,   
 TO_CHAR(j.closedate, 'yyyy-mm-dd hh24:mi') AS CLOSE_DATE,   
 pb.buildingnum  as BUILDING_NUM,  
pg.typecode                                         as  EVAULATION_TYPE,  
pb.replacementcost_cg                               AS ReplacementCost,  
TO_CHAR(pb.evaluationdate_cg, 'yyyy-mm-dd')  AS EVALIATION_DATE,  
  pp.periodend,  
  pp.termnumber, 
  pol.productcode 
    
    
FROM pcuser.pc_policyperiod pp   
  INNER JOIN PCUSER.PCTL_POLICYPERIODSTATUS pps ON pps.id = pp.status   
  INNER JOIN pcuser.pc_job j ON j.id = pp.jobid   
  INNER JOIN pcuser.pc_policy pol ON pol.id = pp.policyid   
  INNER JOIN pcuser.pctl_job jt ON jt.id = j.subtype    
  INNER JOIN PCUSER.pc_account a ON a.id = pol.accountid   
  INNER JOIN pcuser.pc_producercode proc on proc.id = pp.producercodeofrecordid  
  inner JOIN PCUSER.pc_uwcompany uwcompany on uwcompany.id = pp.uwcompany   
  inner join pcuser.pc_building  pb on pb.branchid = pp.id  
  inner join pcuser.pctl_evaluationsoftware_cg pg  on pb.evaluationsource_cg = pg.id  
    
where  
  pb.evaluationsource_cg is not null   
  and pb.evaluationsource_cg =pg.id and pg.typecode='RCT'  
  and pb.replacementcost_cg is not null  
  and  jt.name in ( 'Renewal')   
   
  and pps.typecode = 'Bound'  
  and pp.periodend > sysdate  
  and pp.termnumber = (  
    select max (pp2.termnumber) from pcuser.pc_policyperiod pp2 where pp2.policynumber = pp.policynumber    
    )  
  and 0 <>   
  (   
  SELECT  count (*)  
   
      
   FROM pcuser.pc_policyperiod pp1   
  INNER JOIN PCUSER.PCTL_POLICYPERIODSTATUS pps ON pps.id = pp1.status   
   INNER JOIN pcuser.pc_job j1 ON j1.id = pp1.jobid   
   INNER JOIN pcuser.pc_policy pol1 ON pol1.id = pp1.policyid   
   INNER JOIN pcuser.pctl_job jt1 ON jt1.id = j1.subtype    
    
   inner join pcuser.pc_building  pb1 on pb1.branchid = pp1.id  
  inner join pcuser.pctl_evaluationsoftware_cg pg1  on pb1.evaluationsource_cg = pg1.id  
    
 where  
   pb1.evaluationsource_cg is not null   
   and pb1.evaluationsource_cg =pg1.id   
   and pg1.typecode='RCT'  
  and pb1.replacementcost_cg is not null  
   and  jt1.typecode in ( 'Renewal' ,'Submission')  
  and pp1.policynumber = pp.policynumber   
  and pb1.buildingnum =pb.buildingnum   
  and pg1.typecode='RCT'  
  and pb1.replacementcost_cg = pb.replacementcost_cg   
  and j1.jobnumber<>j.jobnumber  
  ) 
