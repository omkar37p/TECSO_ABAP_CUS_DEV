@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Value SubReport2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPO_VALUE_2Report
  as select from I_PurchaseOrderItemAPI01 as PO

{
  key PO.PurchaseOrder,
  key PO.PurchaseRequisition,
      PO.DocumentCurrency as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum(PO.NetAmount)   as POAMOUNT
}
where
  PO.PurchasingDocumentDeletionCode is initial
group by
  PO.PurchaseOrder,
  PO.PurchaseRequisition,
  PO.DocumentCurrency
