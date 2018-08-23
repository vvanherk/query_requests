select op.IBCCODE from PCX_OPERATION_CG op
where 1=1
and op.IBCSPLITCODE like '%0731a50%'
;



select ur.id, ur.IBCCODE, ur.IBCSPLITCODE, ur.PUBLICID , ur.AVAILABLEDATE_CG, ur.EFFECTIVEDATE_CG, ur.RENEFFECTIVEDATE_CG, ur.EXPIRATIONDATE_CG, ur.RENEXPIRATIONDATE_CG, ur.UNAVAILABLEDATE_CG  from pcx_ursg_CG ur
--select * from pcx_ursg_CG ur
where 1=1 
and ur.PUBLICID like '%R47FARM%'
;


select ur.id, ur.IBCCODE, ur.IBCSPLITCODE, ur.PUBLICID from pcx_ursg_CG ur
--select * from pcx_ursg_CG ur
where 1=1 
--and ur.IBCSPLITCODE like '%731a60%'
and ur.RETIRED = 1
;


select ur.id, ur.IBCCODE, ur.IBCSPLITCODE, ur.PUBLICID from pcx_ursg_CG ur
--select * from pcx_ursg_CG ur
where 1=1 
and ur.IBCSPLITCODE like '%731a60%'
--and ur.PUBLICID = 'cg:3491'
;



select * from PCX_IBC_DSC_L10N ibcd
where 1=1
--and ibcd.owner  = 2801 -- DEV
and ibcd.owner  = 5501
order by ibcd.PUBLICID desc
;

select * from PCX_IBC_GRP_L10N ibcg
where 1=1
--and ibcg.owner = 2801 -- DEV
and ibcg.owner = 5501  --SIT3
order by ibcg.PUBLICID desc
;

select * from PCX_IBC_RATUNIT_L10N ibcru
where 1=1
--and ibcru.value like '%%'
order by ibcru.PUBLICID desc
;





select * from PCX_POLICYOPERATION_CG po
where 1=1
and po..IBCSPLITCODE like '%0121d00%';


select * from PCST_OPERATION_CG;

select * from PCTL_OPERATION_CG;

select * from PCX_IBC_DSC_L10N ibcd
where 1=1
and ibcd.PUBLICID like '%6688%'
;

select * from PCX_IBC_DSC_L10N ibcd
where 1=1
and ibcd.PUBLICID like '%6687%'
;

select * from PCX_IBC_GRP_L10N ibcg
where 1=1
and ibcg.PUBLICID like '%6687%'
;



