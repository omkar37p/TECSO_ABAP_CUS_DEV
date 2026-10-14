@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity for GSTR3B'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZFI_CUSTAGEING_RV as select from I_OperationalAcctgDocItem as OAI
inner join I_Customer as CUS on CUS.Customer = OAI.Customer
left outer join I_JournalEntryItem as JEI on JEI.AccountingDocument = OAI.AccountingDocument
and JEI.CompanyCode = OAI.CompanyCode
and JEI.FiscalYear = OAI.FiscalYear
and JEI.AccountingDocumentItem = OAI.AccountingDocumentItem
and JEI.Ledger = '0L'
{
key OAI.CompanyCode,
key OAI.FiscalYear,
key OAI.AccountingDocument,
key OAI.Customer,
    CUS.CustomerName,
    OAI.PostingDate,
    OAI.TransactionCurrency   as   CURR ,
    @Semantics.amount.currencyCode: 'CURR'
    OAI.AmountInTransactionCurrency,
    dats_days_between( OAI.PostingDate, $session.system_date) as Arrear,
    @Semantics.amount.currencyCode: 'Curr'
    case when dats_days_between( OAI.PostingDate, $session.system_date ) between 0 and 90 then OAI.AmountInTransactionCurrency end as overdue0_90,
    @Semantics.amount.currencyCode: 'CURR'
    case when dats_days_between( OAI.PostingDate,$session.system_date ) between 91 and 120 then OAI.AmountInTransactionCurrency end as overdue91_120,
    @Semantics.amount.currencyCode: 'CURR'
    case when dats_days_between( OAI.PostingDate , $session.system_date ) between 121 and 150 then OAI.AmountInTransactionCurrency end as overdue121_150,
    @Semantics.amount.currencyCode: 'curr'
    case when dats_days_between (OAI.PostingDate,$session.system_date) between 151 and 180 then OAI.AmountInTransactionCurrency end as overdue151_180,
    @Semantics.amount.currencyCode: 'curr'
    case when dats_days_between(OAI.PostingDate,$session.system_date) between 181 and 365 then OAI.AmountInTransactionCurrency end as overdue181_365,
    @Semantics.amount.currencyCode: 'CURR'
    case when dats_days_between(OAI.PostingDate,$session.system_date) between 366 and 720 then OAI.AmountInTransactionCurrency end as overdue366_720,
    @Semantics.amount.currencyCode: 'curr'
    case when dats_days_between(OAI.PostingDate,$session.system_date) > 720 then OAI.AmountInTransactionCurrency end as overdue721,
    case when dats_days_between( OAI.PostingDate, $session.system_date ) > 0 
     then 'Overdue' 
     else 'Not Due' 
end as OverdueStatus
}
 where OAI.FinancialAccountType = 'D'
 and  JEI.IsReversed is initial
 and JEI.IsReversal is initial
 and JEI.ClearingJournalEntry is initial
