@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clearing Invoice 7 Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZINV_CLEARING7
  as select from    ZPO_INVOICE_FI_5          as FIDoc
    left outer join I_OperationalAcctgDocItem as OADI  on  OADI.AccountingDocument   = FIDoc.AccountingDocument
                                                       and OADI.CompanyCode          = FIDoc.CompanyCode
                                                       and OADI.FiscalYear           = FIDoc.FiscalYear
                                                       and OADI.FinancialAccountType = 'K'
    left outer join I_OperationalAcctgDocItem as OADI2 on  OADI2.CompanyCode        = OADI.CompanyCode
                                                       and OADI2.FiscalYear         = OADI.ClearingJournalEntryFiscalYear
                                                       and OADI2.AccountingDocument = OADI.ClearingJournalEntry
                                                       and OADI2.ClearingItem       = OADI.ClearingItem
    left outer join I_JournalEntry            as JEH   on  JEH.AccountingDocument = OADI2.AccountingDocument
                                                       and JEH.FiscalYear         = OADI2.FiscalYear
                                                       and JEH.CompanyCode        = OADI2.CompanyCode
{
  key FIDoc.PurchasingDocument,
      OADI2.CompanyCodeCurrency               as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum (OADI2.AmountInCompanyCodeCurrency) as CLEARINGAMOUNT
}
where
      OADI.ClearingJournalEntry is not initial
  and JEH.IsReversal            is initial
  and JEH.IsReversed            is initial
group by
  FIDoc.PurchasingDocument,
  OADI2.CompanyCodeCurrency
