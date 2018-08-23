
select jt.TypeCode, j.JobNumber, pps.TypeCode
from pc_PolicyPeriod pp
join pctl_PolicyPeriodStatus pps on pp.Status = pps.ID
join pc_Job j on pp.JobID = j.ID
join pctl_Job jt on j.Subtype = jt.ID
join pcx_FarmSchedule_CG fs on pp.ID = fs.BranchID and fs.ItemType_CG = 10024 
where 1=1
and pp.Retired = 0
; 