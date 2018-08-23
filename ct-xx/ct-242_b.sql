/*
alter session set current_schema=pcuser;
*/

select  pp.policynumber as Policy, pcj.jobnumber as Job, pctlj.typecode as Status, p.productcode as Product, pp.producercodeofrecordid as ProducerCode,
        to_char(pp.periodstart, 'yyyy/mm/dd') as StartDate, to_char(pp.periodend, 'yyyy/mm/dd') as EndDate, to_char(pcj.createtime, 'yyyy/mm/dd') as CreateDate 

from pc_policy p  

inner join pc_job pcj on pcj.policyid = p.id 
inner join pc_policyperiod pp ON pcj.id = pp.jobid 
inner join pctl_state on pctl_state.id = pp.basestate 
inner join pctl_policyperiodstatus pps on pps.id = pp.status 
inner join pctl_job pctlj on pctlj.id = pcj.subtype 
inner join pctl_cancellationsource on pctl_cancellationsource.id = pcj.source 

where pctlj.typecode = 'Cancellation' 
  and p.productcode = 'Cooperators_CG'
  and  pctl_cancellationsource.typecode = 'billingcenter' 
  and  to_char(pcj.createtime, 'yyyymmdd') >= '20130101'  
  and  (pcj.RescindNotificationDate is not null and to_char(pcj.createtime, 'YYYYMMDDHH24') = TO_CHAR(pcj.RescindNotificationDate,  'YYYYMMDDHH24'))
  order by CreateDate
;
