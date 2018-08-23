select * from pcx_drone_cg;

--delete from pcx_drone_cg;

select * from PCX_DRONE_CGANSWER da
order by da.UPDATETIME desc
;

--delete from PCX_DRONE_CGANSWER;

--- for dev - drone answers and drone records deleted

     [java] 2 reference(s) found from pcx_CommSchedule_CG.Subtype to orphaned typecodes from CommSchedule_CG. You need to restore the values to the typelist or update the values in pcx_CommSchedule_CG.Subtype before upgrading.  A query to find these references is: SELECT t.ID, t.Subtype, tl.TYPECODE FROM pcx_CommSchedule_CG t, pctl_commschedule_cg tl WHERE t.Subtype = tl.ID AND tl.TYPECODE = 'Drone_CG']

SELECT t.ID, t.Subtype, tl.TYPECODE FROM pcx_CommSchedule_CG t, pctl_commschedule_cg tl WHERE t.Subtype = tl.ID AND tl.TYPECODE = 'Drone_CG';

SELECT * FROM pcx_CommSchedule_CG cs; 
where 1=1
and cs.subtype = '10010';

delete FROM pcx_CommSchedule_CG cs 
where 1=1
and cs.subtype = '10010';


SELECT t.ID, t.Subtype, tl.TYPECODE FROM pcx_CommSchedule_CG t, pctl_commschedule_cg tl WHERE t.Subtype = tl.ID AND tl.TYPECODE = 'Drone_CG';


SELECT * FROM pctl_commschedule_cg tl WHERE tl.TYPECODE = 'Drone_CG';

select * from PCX_DOCPRODPRINTCODE_CG dpp
where 1=1
and dpp.COVERAGEPATTERNCODE like '%Drone%'
;


select * from PC_QUESTIONSETLOOKUP qs
where 1=1; 
and qs.QUESTIONSETCODE like '%DroneQuestionSet%';

^^ add delete to above - maybe - nooooooo - double check things


select * from PC_QUESTIONLOOKUP ql
where 1=1
and ql.QUESTIONCODE like '%FPD%';


select * from PCX_GEOCODEPERILZONEFARM_CG pz
where 1=1
--and pz.ITEMTYPE_CG = 10023
order by pz.AVAILABLEDATE_CG desc ;

select * from pctl_coverable_cg; -- drone 10023


select * from pctl_ratingzone_cg;

select * from pcx_ratingzone_cg;

select * from PCX_GEOCODEPERILZONEFARM_CG gz
where 1=1
order by gz.ITEMTYPE_CG desc
;



select * from PCX_FARMSCHEDULEANSWER_CG fsa
order by fsa.UPDATETIME desc
;


select * from pcx_CPropCommScheduleCov_CG where PatternCode = 'covCPDrone';








