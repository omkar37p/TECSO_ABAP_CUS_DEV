@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FI Invoice Value PO'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPO_FIINVVALUE_6
  as select from    ZPO_INVOICE_FI_5          as FIDoc
    left outer join I_OperationalAcctgDocItem as OADI on  OADI.AccountingDocument   = FIDoc.AccountingDocument
                                                      and OADI.CompanyCode          = FIDoc.CompanyCode
                                                      and OADI.FiscalYear           = FIDoc.FiscalYear
                                                      and OADI.FinancialAccountType = 'K'
{
  key FIDoc.PurchasingDocument,
      OADI.CompanyCodeCurrency               as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum (OADI.AmountInCompanyCodeCurrency) as FIDOCAMNT
}
group by
  FIDoc.PurchasingDocument,
  OADI.CompanyCodeCurrency
