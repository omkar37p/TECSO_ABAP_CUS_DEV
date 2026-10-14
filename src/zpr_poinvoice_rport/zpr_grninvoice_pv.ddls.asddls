@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PV for ZPR_GRNINVOICE_Report'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPR_GRNINVOICE_PV as select from ZPR_GRNINVOICE_REPORT
{
   key PurchaseOrder,
   key PurchaseRequisition,
   CURR,
   @Semantics.amount.currencyCode: 'CURR'
   PRAMOUNT,
   @Semantics.amount.currencyCode: 'CURR'
   POAMOUNT,
   @Semantics.amount.currencyCode: 'CURR'
   GRNVALUE,
   @Semantics.amount.currencyCode: 'CURR'
   INVAMT,
   @Semantics.amount.currencyCode: 'CURR'
   FIDOCAMNT,
   @Semantics.amount.currencyCode: 'CURR'
   CLEARINGAMOUNT,
   @Semantics.amount.currencyCode: 'CURR'
   PAYMENTAMOUNT,
   @Semantics.amount.currencyCode: 'curr'
   BALANCECLEARINGAMT,
   @Semantics.amount.currencyCode: 'curr'
   BALANCEPAYMENTAMT,
   WBSELEMENT
}
