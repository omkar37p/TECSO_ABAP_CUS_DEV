@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INVOICE PAYMENT REPORT 11'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZINV_PAYMENT11
  as select from    ZPO_INVOICE_FI_5          as FIDoc
    left outer join I_OperationalAcctgDocItem as OADI  on  OADI.AccountingDocument   = FIDoc.AccountingDocument
                                                       and OADI.CompanyCode          = FIDoc.CompanyCode
                                                       and OADI.FiscalYear           = FIDoc.FiscalYear
                                                       and OADI.FinancialAccountType = 'K'
    left outer join I_OperationalAcctgDocItem as OADI2 on  OADI2.CompanyCode                = OADI.CompanyCode
                                                       and OADI2.InvoiceReferenceFiscalYear = OADI.FiscalYear
                                                       and OADI2.InvoiceReference           = OADI.AccountingDocument
                                                       and OADI2.InvoiceItemReference       = OADI.AccountingDocumentItem
    left outer join I_JournalEntry            as JEH   on  JEH.AccountingDocument = OADI2.AccountingDocument
                                                       and JEH.FiscalYear         = OADI2.FiscalYear
                                                       and JEH.CompanyCode        = OADI2.CompanyCode
{
  key FIDoc.PurchasingDocument,
      OADI2.CompanyCodeCurrency               as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum (OADI2.AmountInCompanyCodeCurrency) as PAYMENTAMOUNT
}
where
      OADI2.AccountingDocumentType = 'KZ'
  and JEH.IsReversal               is initial
  and JEH.IsReversed               is initial
group by
  FIDoc.PurchasingDocument,
  OADI2.CompanyCodeCurrency
