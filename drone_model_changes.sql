select * from PCX_DRONE_CG;

select * from PC_TABLEREGISTRY
 where 1=1 
 and TABLENAME like '%fpropdrone%';
 
-- delete table registry drone entries no longer required 
delete from PC_TABLEREGISTRY
 where 1=1 
 and TABLENAME like '%fpropdrone%';
 
delete from PC_TABLEREGISTRY
 where 1=1 
 and TABLENAME like '%fliabdrone%';


-- delete cov lookup  drone entries
delete from PC_COVTERMOPTLOOKUP ctol
where 1=1 
and upper(ctol.sourcefile) like '%FPDRONE%';


delete from pc_covlookup cl 
where 1=1 
and upper(cl.sourcefile) like '%FPDRONE%';


delete from pc_covtermlookup cl 
where 1=1 
and upper(cl.sourcefile) like '%FPDRONE%';


delete from PC_COVTERMOPTLOOKUP ctol
where 1=1 
and upper(ctol.sourcefile) like '%FLDRONE%';


delete from pc_covlookup cl 
where 1=1 
and upper(cl.sourcefile) like '%FLDRONE%';


delete from pc_covtermlookup cl 
where 1=1 
and upper(cl.sourcefile) like '%FLDRONE%';

