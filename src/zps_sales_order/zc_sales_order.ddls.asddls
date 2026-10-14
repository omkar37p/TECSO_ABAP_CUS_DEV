@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SALES_ORDER
  provider contract transactional_query
  as projection on ZI_SALES_ORDER
{
  key Salesorder,
  key Salesorderitem,
      Soldtoparty,
      Salesorderdate,
      Referencesddocument,
      Billingdocumentdate,
      Fiscalyear,
      SalesOrganization,
      DistributionChannel,
      Salesordertype,
      Salesorderitemcategory,
      Product,
      Batch,
      Plant,
      Salesorderitemtext,
      @Semantics.quantity.unitOfMeasure: 'Orderquantityunit'
      Orderquantity,
      Orderquantityunit,
      @Semantics.amount.currencyCode: 'Transactioncurrency'
      Netamount,
      Transactioncurrency,
      @UI.hidden: true
      @Semantics.user.createdBy: true
      Createdby,
      @UI.hidden: true
      @Semantics.systemDateTime.createdAt: true
      Createdat,
      @UI.hidden: true
      @Semantics.user.lastChangedBy: true
      Lastchangedby,
      @UI.hidden: true
      @Semantics.systemDateTime.lastChangedAt: true
      Lastchangedat
}
