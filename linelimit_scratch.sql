select * from pcx_linelimit_cg
;

select * from pctl_ricoveragegrouptype;

select * from pcx_linelimit_cg ll
where ll.productcode_cg like 'Farm%'
order by ll.publicid;
where ll.linelimit_cg = 10000000
;

delete from pcx_linelimit_cg ll
where ll.productcode_cg like 'Farm%'
and ll.publicid = 'cgoll:1013';

select * from pcx_linelimitreduction_cg llr
order by llr.publicid;


select * from pctl_ricoveragegrouptype;

select distinct ll.linelimit_cg, o.ibcsplitcode, l10n.value
from pcx_LineLimit_CG ll
join pcx_Operation_CG o on LL.IBCSPLITCODE_CG = O.IBCSPLITCODE
join pcx_opr_dsc_l10n l10n on o.ID = l10n.owner and l10n.language = 10001
where 1=1
and ll.ProductCode_CG = 'Farm_CG'
and o.ibcsplitcode = '0150z00';

select op.id, op.ibcsplitcode from pcx_operation_cg op;

select * from pcx_operation_cg op
where 1=1
and op.ibcsplitcode = '0150z00';
;