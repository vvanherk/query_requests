select  /*+ INDEX(b PK_BUILDING) */
distinct a.accountnumber, pp.policynumber, pc.code as "PRODUCERCODE",
        TO_CHAR(pp.periodstart, 'YYYY-MM-DD HH24:MI:SS,FF3') as "PERIODSTARTDATE",
        TO_CHAR(pp.periodend, 'YYYY-MM-DD HH24:MI:SS,FF3') as "PERIODENDDATE",             
        edf.offeringcode, s.name as "STATUS", p.productcode, 
        bt.name as "BLDGTYPE", bty.typecode as "STRUCTURETYPE", b.buildingnum, b.id,
        pl.addressline1internal, pl.cityinternal, 
        st.name as "PROVINCE", 
        pl.postalcodeinternal, 
        et.name as "EVALSOURCE", b.replacementcost_cg,
        TO_CHAR(b.replacementevaldate_cg, 'YYYY-MM-DD HH24:MI:SS,FF3') as "EVALUATIONDATE",
        ct1.covtermvalue_cg as "Building_Limit",
        ct2.covtermvalue_cg as "Building_Settlement_Code" 
--        ct.covtermcode_cg, ct.covtermvalue_cg

from pcuser.pc_building b

-- entities to join
-- policy period id joins on building branchid
inner join pcuser.pc_policyperiod pp on pp.id = b.branchid

-- job id joins on policy period jobid
inner join pcuser.pc_job j on j.id = pp.jobid

-- policy id joins on policyperiod policyid
inner join pcuser.pc_policy p on p.id = pp.policyid

--account id joins on policy accountid
inner join pcuser.pc_account a on a.id = p.accountid

-- policy id joins on policyperiod policyid
inner join PCUSER.pc_producercode pc on pp.ProducerCodeOfRecordID = pc.id

-- join on location and state for province
inner join pcuser.pc_policylocation pl on pp.id = pl.branchid and pl.fixedid = b.policylocation
inner join pcuser.pctl_state st on st.id = pl.stateinternal

--branchid of effdate joins in policy period id (for offering type)
inner join pcuser.pc_effectivedatedfields edf on edf.branchid = pp.id 

-- typelists to join
-- list type of building  -  building id join on building subtype
inner join pcuser.pctl_building bt on bt.id = b.subtype

-- list buildingtype id on b.buildingtype_cg
inner join PCUSER.pctl_buildingtype_cg bty on bty.id = b.buildingtype_cg

-- list evaluationsoftware_cg joins on building evaluaitonsource_cg
inner join PCUSER.pctl_evaluationsoftware_cg et on et.id = b.evaluationsource_cg

-- list policyperiostatus joins on policy period status
inner join pcuser.pctl_policyperiodstatus s on s.id = pp.status

--
inner join PCUSER.pcx_fpropbuilding_cg fpb on fpb.branchid = pp.id

--
inner join PCUSER.pcx_fpropbuildingcov_cg fpbc on fpbc.fpropbuilding_cg = fpb.fixedid and fpbc.branchid = pp.id

--
--inner join pcuser.pcx_calccovterm_CG ct on pp.ID = ct.BranchID and CT.FPROPBUILDINGCOV_CG = fpbc.FixedId
--  and ct.CovTermCode_CG in ('FPBuildingLimit','FPBuildingSettlement')
  

inner join pcuser.pcx_calccovterm_CG ct1 on pp.ID = ct1.BranchID and CT1.FPROPBUILDINGCOV_CG = fpbc.FixedId
  and ct1.CovTermCode_CG = 'FPBuildingLimit'

inner join pcuser.pcx_calccovterm_CG ct2 on pp.ID = ct2.BranchID and CT2.FPROPBUILDINGCOV_CG = fpbc.FixedId
  and ct2.CovTermCode_CG = 'FPBuildingSettlement' 

        
--(select ct.covtermcode_cg as termcode from pcuser.pcx_calccovterm_CG ct
--where CT.BRANCHID = pp.ID ) ctt
--and CT.FPROPBUILDINGCOV_CG = fpbc.FixedId
--  and ct.CovTermCode_CG in ('FPBuildingLimit','FPBuildingSettlement')
--  ) ctt


-- clauses
where 
-- building type needs to be FarmStructure_CG
bt.name = 'FarmStructure_CG'
-- temp resrtrict row count
--and rownum < 10
-- policy period company is CGIC
and pp.uwcompany = 2
-- policy period not cancelled
and pp.cancellationdate IS NULL
-- policyperiod number not invalid
and pp.policynumber not like 'Invalid%'
-- evaluationsource name is BVS
and et.typecode = 'BVS'
-- policy product code is FARM_CG
and p.productcode = 'Farm_CG'
--
--and (edf.offeringcode = 'FarmGuard_CG' or edf.offeringcode = 'HobbyFarm_CG')
-- policy period most recent model > 0
and pp.mostrecentmodel > 0
--
--and b.replacementevaldate_cg > '2016-05-01'

-- ===================================================================================================================
-- Find latest bound periods
-- ===================================================================================================================
AND((pp.termnumber IS NULL AND NOT EXISTS
    (SELECT id
    FROM pcuser.pc_policyperiod pterm
    WHERE pterm.policyid  =pp.policyid
    AND pterm.termnumber IS NOT NULL
    ) ) OR ( pp.termnumber=
    (SELECT MAX(termnumber)
    FROM pcuser.pc_policyperiod pterm
    WHERE pterm.policyid      =pp.policyid
    ) AND ( pp.mostrecentmodel=1 OR NOT EXISTS
      (SELECT id
      FROM pcuser.pc_policyperiod pterm
      WHERE pterm.policyid     =pp.policyid
      AND pterm.termnumber     =pp.termnumber
      AND Pterm.Mostrecentmodel=1
      ) ) ) ) 
;