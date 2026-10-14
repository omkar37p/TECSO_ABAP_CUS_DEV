@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Value SubReport4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZInvoice_VALUE_4Report
  as select from I_SuplrInvcItemPurOrdRefAPI01 as INV
{
  key INV.PurchaseOrder,
      INV.DocumentCurrency               as CURR,
      INV.DebitCreditCode,
      @Semantics.amount.currencyCode: 'CURR'
      sum(INV.SupplierInvoiceItemAmount) as INVAMOUNT
}
group by
  INV.PurchaseOrder,
  INV.DocumentCurrency,
  INV.DebitCreditCode
