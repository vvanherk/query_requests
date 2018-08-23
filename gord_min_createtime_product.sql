select  min (pp.createtime) First
from pcuser.pc_policyperiod pp
inner join pcuser.pc_policy po on po.id = pp.policyid 
where po.productcode =  'IRAuto_CG'
order by pp.createtime
; 

select po.productcode, pp.policynumber,j.jobnumber, pp.createtime, pp.periodstart
from pcuser.pc_policyperiod pp
inner join pcuser.pc_policy po on po.id = pp.policyid 
inner join pcuser.pc_job j on j.id = pp.jobid
where po.productcode =  'IRAuto_CG'
and pp.createtime = '15-04-13 07:28:35.830000000'
order by pp.createtime
; 