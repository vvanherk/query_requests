select j.JobNumber 
, ct.Subtype, ctt.Name 
, ct.CovTermCode_CG 
, ct.CovTermValue_CG 
, ct.ModelType_CG 
from pc_PolicyPeriod pp 
join pc_Job j on pp.JobID = j.ID 
join pcx_PPropBuilding_CG ppb on pp.ID = ppb.BranchID 
join pcx_PPropBuildingCov_CG ppc on pp.ID = ppc.BranchID and ppb.FixedId = ppc.PPropBuilding_CG 
  and ppc.PatternCode = 'covBuilding_c' 
join pcx_CalcCovTerm_CG ct on pp.ID = ct.BranchID and ppc.FixedId = ct.PPropBuildingCov_CG 
join pctl_CalculatedCovTerm_CG ctt on ct.Subtype = ctt.ID 
where 1=1 
and pp.Retired = 0 ;
and j.JobNumber = '7814272' 
