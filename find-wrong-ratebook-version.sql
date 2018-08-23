alter session set current_schema = pcuser;

-- :PeriodStartFrom := 2015-08-09
-- :PeriodStartThru := 2015-08-31
-- :CreateTime = '2015-05-03 00:00:00'
-- :UpdateTime = '2015-06-16'
select distinct '"'||JobNumber||'",' as JN from (
--select * from (
select j.JobNumber
, 'FPropCost' as cost_type
, fc.ID, fc.CreateTime
, fc.PreviousTermAmount_CG
, fc.ActualTermAmount
, pp.PeriodStart, pp.PeriodEnd
from pc_Job j
join pc_PolicyPeriod pp on j.ID = pp.JobID
join pcx_FPropCost_CG fc on pp.id = fc.branchid and fc.UpdateTime < to_date(:UpdateTime, 'yyyy-mm-dd')
where 1=1
and j.SubType = 7 -- Renewals
and pp.Status = 10008 -- Renewing
and fc.taxcategory_cg is null
and fc.ActualTermAmount <> 0
and pp.PeriodStart between to_date(:PeriodStartFrom,'yyyy-mm-dd') and to_date(:PeriodStartThru,'yyyy-mm-dd')
union all
select j.JobNumber
, 'FLiabCost' as cost_type
, fc.ID, fc.CreateTime
, fc.PreviousTermAmount_CG
, fc.ActualTermAmount
, pp.PeriodStart, pp.PeriodEnd
from pc_Job j
join pc_PolicyPeriod pp on j.ID = pp.JobID
join pcx_FLiabCost_CG fc on pp.id = fc.branchid and fc.UpdateTime < to_date(:UpdateTime, 'yyyy-mm-dd')
where 1=1
and j.SubType = 7 -- Renewals
and pp.Status = 10008 -- Renewing
and fc.taxcategory_cg is null
and fc.ActualTermAmount <> 0
and pp.PeriodStart between to_date(:PeriodStartFrom,'yyyy-mm-dd') and to_date(:PeriodStartThru,'yyyy-mm-dd')
union all
select j.JobNumber
, 'PPropCost' as cost_type
, fc.ID, fc.CreateTime
, fc.PreviousTermAmount_CG
, fc.ActualTermAmount
, pp.PeriodStart, pp.PeriodEnd
from pc_Job j
join pc_PolicyPeriod pp on j.ID = pp.JobID
join pc_Policy p on pp.PolicyID = p.ID and p.ProductCode = 'Farm_CG'
join pcx_PPropCost_CG fc on pp.id = fc.branchid and fc.UpdateTime < to_date(:UpdateTime, 'yyyy-mm-dd')
where 1=1
and j.SubType = 7 -- Renewals
and pp.Status = 10008 -- Renewing
and fc.taxcategory_cg is null
and fc.ActualTermAmount <> 0
and pp.PeriodStart between to_date(:PeriodStartFrom,'yyyy-mm-dd') and to_date(:PeriodStartThru,'yyyy-mm-dd')
)
order by 1
;