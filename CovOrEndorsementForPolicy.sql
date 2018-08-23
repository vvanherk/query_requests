select distinct pp.policynumber,job.jobnumber,ppbc.patterncode,ppbc.updatetime,pp.editeffectivedate from pcuser.pcx_PPropBuildingCov_CG ppbc
inner join pcuser.pc_PolicyPeriod pp on pp.ID = ppbc.BranchID
inner join pcuser.pc_policy po on po.id = pp.policyid 
inner join pcuser.pc_job job on pp.jobid = job.id 
where 
 po.productcode != 'Farm_CG' and
 ppbc.PatternCode ='covPersonalPropertyClaimsSettlement_h'
 and ppbc.updatetime>'15-09-15 11:59:50.357000000'; 
 
 
 from pc_PolicyPeriod pp
join pc_Policy p on pp.PolicyID = p.ID
join pc_Account acc on p.AccountID = acc.ID
join pc_PolicyLocation pl on pp.ID = pl.BranchID
join pc_Address al on pl.AccountLocation = al.ID
join pcx_PPropBuilding_CG ppb on pp.ID = ppb.BranchID
join pcx_PPropBuildingCov_CG ppbc on pp.ID = ppbc.BranchID and ppb.FixedId = ppbc.PPropBuilding_CG
join pc_Building b on pp.ID = b.BranchID and ppb.Building_CG = b.FixedId and pl.FixedId = b.PolicyLocation
where 1=1
and pp.Retired = 0
and pp.Status not in (3,9,10) -- not (Withdrawn,Not-Taken,Non-renewed)
and p.ProductCode = 'Farm_CG'
and ppbc.PatternCode in ('covCompWater_c','covExtendedWater_c') 