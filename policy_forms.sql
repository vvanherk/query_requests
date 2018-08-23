SELECT pp.policynumber,
  pp.retired,
  j.jobnumber,
  f.formnumber
FROM pcuser.pc_form f
INNER JOIN pcuser.pc_policyperiod pp
ON pp.id = f.branchid
INNER JOIN pcuser.pc_job j
ON j.id            = pp.jobid
WHERE f.formnumber like'%Mort%' ;