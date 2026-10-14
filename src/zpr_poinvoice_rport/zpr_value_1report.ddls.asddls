@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requisition Value SubReport1'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPR_VALUE_1Report
  as select from I_PurchaseRequisitionItemAPI01 as PR


{
  key PR.PurchaseRequisition,
      PR.PurReqnItemCurrency as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum(PR.ItemNetAmount)  as PRAMOUNT
}
where
  PR.IsDeleted is initial
group by
  PR.PurchaseRequisition,
  PR.PurReqnItemCurrency
