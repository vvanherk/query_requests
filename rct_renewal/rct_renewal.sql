/*
  Get count of records
   - Renewal
   - RCT
   - Date
*/

select 
to_char(pp.createTime, 'yyyy') as theDate, pb.riskoption_cg, count(1)
from pcuser.pc_PolicyPeriod pp
  inner join pcuser.PCTL_POLICYPERIODSTATUS pps ON pps.id = pp.status   
  inner join pcuser.pc_job j ON j.id = pp.jobid   
  inner join pcuser.pc_policy pol ON pol.id = pp.policyid   
  inner join pcuser.pctl_job jt ON jt.id = j.subtype    
  inner join pcuser.pc_account a ON a.id = pol.accountid   
  inner join pcuser.pc_producercode proc on proc.id = pp.producercodeofrecordid  
  inner join pcuser.pc_uwcompany uwcompany on uwcompany.id = pp.uwcompany   
  inner join pcuser.pc_building  pb on pb.branchid = pp.id  
  inner join pcuser.pctl_evaluationsoftware_cg pg  on pb.evaluationsource_cg = pg.id  
  
where  
  pb.evaluationsource_cg is not null   
  and pb.evaluationsource_cg =pg.id and pg.typecode='RCT'  
  and pb.replacementcost_cg is not null  
  and  jt.name in ( 'Renewal')   
  and pp.CreateTime > to_date('2012-12-31','yyyy-mm-dd')
group by to_char(pp.createTime, 'yyyy'), pb.riskoption_cg
order by theDate, pb.riskoption_cg
; 

/*
  Get count of records
   - Renewal
   - RCT
   - Seasonal
   - Date
*/

select 
to_char(pp.createTime, 'yyyy-mm') as theDate, pb.riskoption_cg, 
count(1)
from pc_PolicyPeriod pp
  inner join pcuser.PCTL_POLICYPERIODSTATUS pps ON pps.id = pp.status   
  inner join pcuser.pc_job j ON j.id = pp.jobid   
  inner join pcuser.pc_policy pol ON pol.id = pp.policyid   
  inner join pcuser.pctl_job jt ON jt.id = j.subtype    
  inner join pcuser.pc_account a ON a.id = pol.accountid   
  inner join pcuser.pc_producercode proc on proc.id = pp.producercodeofrecordid  
  inner join pcuser.pc_uwcompany uwcompany on uwcompany.id = pp.uwcompany   
  inner join pcuser.pc_building  pb on pb.branchid = pp.id  
  inner join pcuser.pctl_evaluationsoftware_cg pg  on pb.evaluationsource_cg = pg.id  
  inner join pcuser.pctl_riskoption_cg ro on ro.id = pb.riskoption_cg

where  
  pb.evaluationsource_cg is not null 
  and pb.evaluationsource_cg =pg.id and pg.typecode='RCT'  
  and pb.replacementcost_cg is not null  
  and  jt.name in ( 'Renewal')   
  and ro.description = 'Seasonal'
  and pp.CreateTime > to_date('2013-12-31','yyyy-mm-dd')
group by to_char(pp.createTime, 'yyyy-mm'), pb.riskoption_cg 
order by theDate
; 




















