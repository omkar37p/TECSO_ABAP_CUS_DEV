@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order  FI INVOICE'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPO_INVOICE_FI_5
  as select from    I_OperationalAcctgDocItem as FIInvoice
    left outer join I_JournalEntry            as JEH on  JEH.CompanyCode        = FIInvoice.CompanyCode
                                                     and JEH.FiscalYear         = FIInvoice.FiscalYear
                                                     and JEH.AccountingDocument = FIInvoice.AccountingDocument

{
  key FIInvoice.CompanyCode,
  key FIInvoice.FiscalYear,
  key FIInvoice.AccountingDocument,
      FIInvoice.PurchasingDocument
}
where
      FIInvoice.PurchasingDocument     is not initial
  and FIInvoice.AccountingDocumentType = 'RE'
  and JEH.IsReversal                   is initial
  and JEH.IsReversed                   is initial
group by
  FIInvoice.CompanyCode,
  FIInvoice.FiscalYear,
  FIInvoice.AccountingDocument,
  FIInvoice.PurchasingDocument
