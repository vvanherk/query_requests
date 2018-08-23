select subtransaction_cg, cancelreasoncode_cg,
reasondescription_cg, source.name as source, context.name as BusinessContext, rec.name as recipient, 
additionalinteresttype, doc.documenttype_cg, doc.documentcode_cg 
from PCUSER.pcx_docproddocumentcodes_cg doc
inner join PCUSER.pctl_recipienttype_cg rec on rec.id = doc.recipienttype_cg
inner join pcuser.pctl_businessmarketcontext_cg context on context.id = doc.businessmarketcontext_cg
inner join PCUSER.pctl_cancellationsource source on source.id = doc.source_cg
--where productcode_cg in ('Farm_CG', 'Cooperators_CG')
where productcode_cg = 'Retired'
and documentcode_cg in ('CANC405', 'FCANC405')
--and cancelreasoncode_cg is not null
--and source.name like  '%nsured'
order by productcode_cg
; 