@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GRN Value SubReport3'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZGRN_VALUE_3Report
  as select from I_MaterialDocumentItem_2 as GRN

{
  key GRN.PurchaseOrder,
      GRN.CompanyCodeCurrency           as CURR,
      @Semantics.amount.currencyCode: 'CURR'
      sum(GRN.TotalGoodsMvtAmtInCCCrcy) as GRNVALUE
}
where
      GRN.GoodsMovementType        = '101'
  and GRN.GoodsMovementIsCancelled is initial
group by
  GRN.PurchaseOrder,
  GRN.CompanyCodeCurrency
