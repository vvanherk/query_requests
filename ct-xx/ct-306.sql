select uwc.parentname as UWC, policynumber,jobnumber,periodend from pcuser.pc_policyperiod pp 
inner join pcuser.pc_job jb on jb.id = pp.jobid 
inner join pcuser.pctl_job jtype on jtype.id = jb.subtype 
inner join PCUSER.pc_uwcompany uwc on uwc.id = pp.uwcompany 
where jtype.name='Rewrite' and pp.modeldate is not null 
and pp.periodend < '14-05-11' 
and pp.termnumber = (select max(termnumber) from pcuser.pc_policyperiod pt where pt.policyid = pp.policyid) 
and not exists( select pc.id from pcuser.pc_policyperiod pc where pc.policyid=pp.policyid and pc.modeldate is not null   and pc.cancellationdate is not null and pc.termnumber=pp.termnumber ) 
and not exists( 
  select pr.id from pcuser.pc_policyperiod pr 
          inner join pcuser.pc_job prj on prj.id = pr.jobid where pr.policyid=pp.policyid and pr.termnumber is null and prj.subtype=7)
