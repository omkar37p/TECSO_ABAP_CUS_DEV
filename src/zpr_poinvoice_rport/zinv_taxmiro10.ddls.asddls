@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '10 Tax Miro Inv'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZINV_TAXMIRO10
  as select from    ZINV_TAXMIRO9
    left outer join I_SupplierInvoiceTaxAPI01 as FINAL on  FINAL.SupplierInvoice = ZINV_TAXMIRO9.SupplierInvoice
                                                       and FINAL.FiscalYear      = ZINV_TAXMIRO9.FiscalYear
{
  key ZINV_TAXMIRO9.PurchaseOrder,
      FINAL.DocumentCurrency as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum (FINAL.TaxAmount)  as INVTAXAMOUNT
}
group by
  ZINV_TAXMIRO9.PurchaseOrder,
  FINAL.DocumentCurrency
