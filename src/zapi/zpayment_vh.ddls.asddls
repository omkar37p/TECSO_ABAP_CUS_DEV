@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Term View Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.dataCategory:#VALUE_HELP



define view entity ZPAYMENT_VH as select from I_PaymentTermsConditions as _pur
{
@UI:{ lineItem: [{ position: 10 }] }
@Consumption.valueHelpDefinition: [{entity: { name: 'zpaymentview', 
                                                      element: 'PaymentTerms'  }}]
 key PaymentTerms as Paytm
 

 
}
