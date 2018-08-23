select * from PCX_DRONE_CG d -- not been used for  a while - using comm_schedule subtype
order by d.CREATETIME desc;


select * from PCX_DRONE_CGANSWER da -- this is currently still being used for answers
order by da.CREATETIME desc;

select * from PCX_FARMSCHEDULE_CG fs
where 1=1;
--and fs.BRANCHID

select * from PCX_COMMSCHEDULE_CG cs
where 1=1


