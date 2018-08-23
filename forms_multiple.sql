select pp.PolicyNumber, j.JobNumber, f.FormPatternCode, count(distinct f.FixedId)
from pc_Form f
join pc_PolicyPeriod pp on f.BranchID = pp.ID
join pc_Policy p on pp.PolicyID = p.ID and p.ProductCode = 'Farm_CG'
join pc_Job j on pp.JobID = j.ID
where 1=1
and pp.Retired = 0
and f.FormNumber = 'FM4'
group by pp.PolicyNumber, j.JobNumber, f.FormPatternCode
having count(distinct f.FixedId) > 1
; 