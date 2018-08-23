	select  PCUSER.PC_policyperiod.policynumber as PolicyNumber 
     , PCUSER.PC_job.jobnumber 
     , PCUSER.PC_policy.createtime Policycreatetime 
     , pcuser.pc_job.createtime jobcreatetime 
     , pcuser.pc_job.updatetime jobupdatetime 
     , pcuser.pc_job.RescindNotificationDate 
     , pcuser.pc_job.cancelprocessdate 
     , to_char(PCUSER.PC_policyperiod.periodstart, 'yyyy/mm/dd') as PolicyEffectiveDate 
     , to_char(PCUSER.PC_policyperiod.periodend, 'yyyy/mm/dd') as PolicyExpiryDate 
     , PCUSER.PC_policyperiod.cancellationdate as CancellationDate 
     , pcuser.pctl_job.typecode 
     , PCUSER.PCTL_policyperiodstatus.TYPECODE as PolicyStatus 
 from PCUSER.PC_policy   
inner join PCUSER.PC_job on PCUSER.PC_job.policyid = PCUSER.PC_policy.id 
INNER JOIN PCUSER.PC_policyperiod ON PCUSER.PC_job.id = PCUSER.PC_policyperiod.jobid 
inner join PCUSER.PCTL_state on PCUSER.PCTL_state.id = PCUSER.PC_policyperiod.basestate 
inner join PCUSER.PCTL_policyperiodstatus on PCUSER.PCTL_policyperiodstatus.id = PCUSER.PC_policyperiod.status 
inner join PCUSER.pctl_job on PCUSER.pctl_job.id = PCUSER.PC_job.subtype 
inner join pcuser.pctl_cancellationsource on pcuser.pctl_cancellationsource.id = PCUSER.PC_job.source 
where  
     PCUSER.pctl_job.typecode = 'Cancellation' 
and  pcuser.pctl_cancellationsource.typecode = 'billingcenter' 
and  to_char(pcuser.pc_job.createtime, 'yyyymmdd') >= '20130101'  
and  (pcuser.pc_job.RescindNotificationDate is not null 

       and  to_char(pcuser.pc_job.createtime, 'YYYYMMDDHH24') = TO_CHAR(pcuser.pc_job.RescindNotificationDate,  'YYYYMMDDHH24') 
     )
     ;
