@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tax Miro Inv 9'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZINV_TAXMIRO9
  as select from I_SuplrInvcItemPurOrdRefAPI01 as TaxInv
{
  key TaxInv.SupplierInvoice,
  key TaxInv.FiscalYear,
      TaxInv.PurchaseOrder
}
group by
  TaxInv.SupplierInvoice,
  TaxInv.FiscalYear,
  TaxInv.PurchaseOrder
