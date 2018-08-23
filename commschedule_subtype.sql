select * from pcx_Drone_CG dr
order by dr.CREATETIME asc ;

SELECT cs.ID, cs.Subtype, cst.TYPECODE FROM pcx_CommSchedule_CG cs, pctl_commschedule_cg cst WHERE cs.Subtype = cst.ID AND cst.TYPECODE = 'Drone_CG'
order by cs.CREATETIME asc
;


SELECT * FROM pcx_CommSchedule_CG cs, pctl_commschedule_cg cst WHERE cs.Subtype = cst.ID AND cst.TYPECODE = 'Drone_CG'
;

select * from pctl_CommSchedule_CG;

select * from PCTL_FARMSCHEDULETYPE_CG;

select * from PCX_FARMSCHEDULE_CG fs
where fs.ITEMTYPE_CG = 10007; --produce

select * from pctl_coverable_cg cov
order by cov.PRIORITY asc;



UPDATE  pcx_CommSchedule_CG cs
SET  cs.SUBTYPE = '10003'
WHERE cs.ID = 20804
;

describe pcx_CommSchedule_CG;

ALTER TABLE pcx_CommSchedule_CG cs 
ADD subtype Number DEFAULT  NOT NULL

