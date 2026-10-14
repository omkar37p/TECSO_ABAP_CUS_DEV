@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SALES_ORDER
  as select from    ztab_sales_order      as sd
//    left outer join I_BillingDocumentItem as Bdi on Bdi.ReferenceSDDocument = sd.referencesddocument

{
  key sd.salesorder             as Salesorder, 
  key sd.salesorderitem         as Salesorderitem,
      sd.soldtoparty            as Soldtoparty,
      sd.salesorderdate         as Salesorderdate,
      sd.referencesddocument    as Referencesddocument,
      sd.billingdocumentdate    as Billingdocumentdate,
      sd.fiscalyear             as Fiscalyear,
      sd.salesorganization      as SalesOrganization,
      sd.distributionchannel    as DistributionChannel,
      sd.salesordertype         as Salesordertype,
      sd.salesorderitemcategory as Salesorderitemcategory,
      sd.product                as Product,
      sd.batch                  as Batch,
      sd.plant                  as Plant,
      sd.salesorderitemtext     as Salesorderitemtext,
      @Semantics.quantity.unitOfMeasure: 'orderquantityunit'
      sd.orderquantity          as Orderquantity,
      sd.orderquantityunit      as Orderquantityunit,
      @Semantics.amount.currencyCode: 'transactioncurrency'
      sd.netamount              as Netamount,
      sd.transactioncurrency    as Transactioncurrency,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat     as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat as Lastchangedat

}
