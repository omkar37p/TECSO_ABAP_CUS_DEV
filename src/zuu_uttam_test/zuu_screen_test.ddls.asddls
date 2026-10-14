@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'screen development'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity Zuu_screen_test as select from zdt_sales_order as si
left outer join I_BillingDocumentItem     as  bdi  on bdi.ReferenceSDDocument = si.referencesddocument
//left outer join I_SalesOrder    as so on so.SalesOrder = si.SalesOrder      
{
   key si.salesorder,
   key si.salesorderitem,
   key bdi.BillingDocument,
   key bdi.BillingDocumentItem,
   si.billingdocumentdate,
   si.referencesddocument,
   si.salesorderdate,
   si.salesordertype,
  si.externaldocumentid,
   si.salesorganization,
   @Semantics.quantity.unitOfMeasure : 'orderquantityunit'
   si.orderquantity,
   si.orderquantityunit,
   @Semantics.amount.currencyCode : 'transactioncurrency'
  si. netamount,
  si.transactioncurrency,
   bdi.BillToParty
  
 }
