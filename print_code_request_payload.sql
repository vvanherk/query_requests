SELECT 
  DP.DOCPRODREQUESTID, 
  dp.documenttype_cg, 
  dp.documentcode_cg,
  dps.name print_status,
  PP.POLICYNUMBER,
  substr(dp.payload, ( instr(dp.payload,'<JobNumber') + 11 ), instr(dp.payload,'</JobNumber') - ( instr(dp.payload,'<JobNumber') + 11 ) ) work_order,
  substr(dp.payload, ( instr(dp.payload,'<ProductCode') + 13 ), instr(dp.payload,'</ProductCode') - ( instr(dp.payload,'<ProductCode') + 13 ) ) product,
  substr(substr(dp.payload, InStr(dp.payload, '<Job type=') + 11, 20), 1, (InStr(substr(dp.payload, InStr(dp.payload, '<Job type=') + 11, 20), '"') - 1)) txn_type,
  substr(dp.payload, ( instr(dp.payload,'<RegisteredMail_CG>') + 19 ), instr(dp.payload,'</RegisteredMail_CG>') - ( instr(dp.payload,'<RegisteredMail_CG>') + 19 ) ) reg_mail,
  substr(dp.payload, ( instr(dp.payload,'<PrintRedirectionType_CG>') + 25 ), instr(dp.payload,'</PrintRedirectionType_CG') - ( instr(dp.payload,'<PrintRedirectionType_CG>') + 25 ) ) PrintRedirectionType,
  to_date(substr(substr(dp.payload, ( instr(dp.payload,'<PeriodStart>') + 13 ), instr(dp.payload,'</PeriodStart>') - ( instr(dp.payload,'<PeriodStart>') + 13 ) ),1, 10),'yyyy-mm-dd') period_start,
  substr(dp.payload, ( instr(dp.payload,'<IsConversionPolicy_CG>') + 23 ), instr(dp.payload,'</IsConversionPolicy_CG>') - ( instr(dp.payload,'<IsConversionPolicy_CG>') + 23 ) ) is_converted,

-- Print language
  substr(dp.payload, ( instr(dp.payload,'<PrintLanguage_CG>') + 18 ), instr(dp.payload,'</PrintLanguage_CG>') - ( instr(dp.payload,'<PrintLanguage_CG>') + 18 ) ) print_lang,

--Client Name
  dp.PRINTPROVINCE_CG,
  to_char(dp.createtime,'yyyy-mm-dd hh24:mi:ssff3') create_time,
--  dp.payload
  dp.printstatus_cg

FROM 
pcuser.pc_policyperiod pp,
pcuser.pc_policy pol,
pcuser.pcx_DocProdPrintRequest_CG req,
pcuser.pcx_docproddocument_cg dp,
pcuser.pctl_docprodprintstatus_cg dps
where
    pol.id = pp.policyid
and req.policyperiod=pp.id
and dp.docprintrequest_cg = req.ID
and dps.id(+) = dp.printstatus_cg 
and dp.documenttype_cg != 'QUOTE'
and dp.createtime >= to_date('2017-01-01','yyyy-mm-dd')

--Search by document Code 
and dp.documentcode_cg like 'Q%' --,'CANC701', 'QCANC700', 'QCANC701', 'FCANC700', 'FCANC701', 'CANC700A')--
--and dp.documentcode_cg like 'CANC209%' --,'CANC701', 'QCANC700', 'QCANC701', 'FCANC700', 'FCANC701', 'CANC700A')--
--and dp.documentcode_cg in ('QCANC201R')
/*and dp.documentcode_cg in ('CANC201F','CANC201R','CANC201RB','CANC201RIB','CANC201RRI','CANC202F','CANC204F','CANC204R','CANC204RRI','CANC207',
                          'CANC207RB','CANC208','CANC304_CANC300','CANC305_CANC300','CANC617','CANC618A','CANCTEMP','CQABI','CQABIC','CQMR1',
                          'CQMR1C','HOME202R','HOME204F','HOME204R','HOME602R','HOME603F','HOME603R','HOME607R','HOME609F','HOME609R','QCANC201R'
                          'QHOME202R','QHOME204R','QHOME602R','QHOME603R','QCANC102R','QCANC103','QCANC123')*/



order by dp.createtime desc  
;
