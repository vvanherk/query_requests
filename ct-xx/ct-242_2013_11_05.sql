"SELECT pp.policynumber, 
  j.jobnumber, 
  s.name, 
  C.CODE, 
  TO_CHAR(pp.periodstart,'YYYY-MM-DD') AS ""Term Start"", 
  TO_CHAR(pp.periodend,'YYYY-MM-DD')   AS ""Term End"", 
  TO_CHAR(j.createtime , 'yyyy-mm-dd hh24:mi')        AS ""JOB CREATE TIME"" 
FROM pcuser.pc_job j 
INNER JOIN pcuser.pc_policyperiod pp 
ON pp.jobid = j.id 
INNER JOIN PCUSER.PC_PRODUCERCODE c 
ON c.id = PP.PRODUCERCODEOFRECORDID 
INNER JOIN PCUSER.PCTL_POLICYPERIODSTATUS s 
ON s.id           = pp.status 
WHERE j.subtype   = 2 
AND pp.status              IN (10003, 10004, 1, 6, 10001, 10006, 7, 10002, 10007, 10008, 10010) 
AND pp.createtime < sysdate - 30  
and J.SOURCE = 10001"
