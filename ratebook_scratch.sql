alter session set current_schema = pcuser;


select * from PCX_FLIABCOST_CG;

select pp.policynumber, pp.periodstart, pp.updatetime, book.bookdesc, book.bookedition,covcodekey_cg,pp.branchname from 
pcuser.pc_policyperiod pp
inner join pcuser.pcx_FLiabCost_CG cost on pp.id = cost.branchid
inner join pcuser.pc_ratebook book on cost.ratebook = book.id
where bookedition like 'R43%'
and pp.policynumber = '1153622561'
and policyline = 'FLiabLine_CG'
order by covcodekey_cg,book.bookedition
