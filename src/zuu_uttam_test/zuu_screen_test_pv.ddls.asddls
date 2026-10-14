@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pv screen development'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity Zuu_screen_test_pv
  provider contract transactional_query
  as projection on Zuu_screen_test

{
  key salesorder,
  key salesorderitem,
   key BillingDocument,
   key BillingDocumentItem,
      billingdocumentdate,
      referencesddocument,
      salesorderdate,
      salesordertype,
      externaldocumentid,
      salesorganization,
      @Semantics.quantity.unitOfMeasure : 'orderquantityunit'
      orderquantity,
      orderquantityunit,
      @Semantics.amount.currencyCode : 'transactioncurrency'
      netamount,
      transactioncurrency,
       BillToParty
}
