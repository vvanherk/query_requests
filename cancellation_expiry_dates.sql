/*
alter session set current_schema=pcuser;
*/

select * from CSP.csp_property_transaction where policy_num = '4050012625' order by mbupdatetime desc
;

select * from CSP.csp_property_transaction where policy_num = '4050038079' order by mbupdatetime desc
;

select * from CSP.csp_property_transaction where policy_num = '4181500574' order by mbupdatetime desc
;

select * from CSP.csp_property_transaction where transactionpublicid like '%pch%'; 

select count(*),pp.policynumber from pcuser.pc_policyperiod pp 
inner join pcuser.pc_job jb on jb.id=pp.jobid
inner join pcuser.pctl_job jtype on jtype.id=jb.subtype
INNER JOIN pcuser.pc_policy pol ON pol.id = pp.policyid
where pp.cancellationdate is not null and pp.modeldate is not null and pp.retired = 0
and jtype.typecode = 'Cancellation'
group by pp.policynumber,pp.termnumber having count(*) >1
;

4000020359
