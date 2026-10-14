
@AbapCatalog.sqlViewName: 'ZSDGLA_E'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GL Account'
define view ZSD_JE_ITEM as select from I_AccountingDocumentJournal( P_Language: 'e' ) as bdip

{
key bdip.SourceLedger,
key bdip.CompanyCode,
key bdip.AccountingDocument,
key bdip.Ledger,
key bdip.FiscalYear,
//key bdip.LedgerGLLineItem,

bdip.ReferenceDocument,
bdip.ReferenceDocumentItem,
bdip.DocumentDate,
sum(bdip.CreditAmountInBalanceTransCrcy)      as amount,
//sum(bdip.ConditionAmount) as ConditionAmount ,

bdip.AccountingDocumentType,
bdip.GLAccountType,
bdip.GLAccount,
bdip.GLAccountName
}

//where (Ledger = '0L',SourceLedger = '0L',AccountingDocumentType = 'RV',GLAccountType = 'P')
where Ledger = '0L'
  and SourceLedger = '0L'
  and AccountingDocumentType = 'RV'
  and GLAccountType = 'P'
  and TaxCode <> ''
//  and LedgerGLLineItem<> '000007'
//  and LedgerGLLineItem<> '000006'
//  and LedgerGLLineItem<> '000005'
//  
  group by SourceLedger,CompanyCode,AccountingDocument,Ledger,FiscalYear,ReferenceDocument,ReferenceDocumentItem,DocumentDate,AccountingDocumentType,
           GLAccountType,GLAccount,GLAccountName
//where ConditionType = 'ZSP1'
//group by BillingDocument,ConditionType


////    key CompanyCode,
////    key FiscalYear,
////    key AccountingDocument,
////    key SourceLedger,
////    key Ledger,
////    key LedgerGLLineItem,
////       ReferenceDocument,
////       ReferenceDocumentItem, 
////        DocumentDate,
////        AccountingDocumentType,
////        GLAccount,
////        GLAccountType,
////        
//// 
////  case 
////  when jeh.ReferenceDocumentItem = '000001' then '000010'
////  when jeh.ReferenceDocumentItem = '000002' then '000020'
////  when jeh.ReferenceDocumentItem = '000003' then '000030'
////  when jeh.ReferenceDocumentItem = '000004' then '000040'
////  
////   when jeh.ReferenceDocumentItem = '000010' then '000010'
////  when jeh.ReferenceDocumentItem = '000020' then '000020'
////  when jeh.ReferenceDocumentItem = '000030' then '000030'
////  when jeh.ReferenceDocumentItem = '000040' then '000040'
////  else '000000'
////end as item
////
////
////// your_table_name jeh;
////
////////        gla-ReferenceDocumentItem = '000001'.  " Assigning a value
////////IF gla-ReferenceDocumentItem = '000010'.
////////  " your conditional logic here
////////ENDIF.
////        
////            
////}
////where (jeh.Ledger         = '0L'
////                and jeh.SourceLedger          = '0L'
////                    and jeh.GLAccountType         = 'P')
////
//////GLAccount like '00004%' >
