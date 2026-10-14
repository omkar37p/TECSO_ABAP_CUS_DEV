@AbapCatalog.sqlViewName: 'ZPAYMENTERMV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment term view'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.representativeKey: 'PaymentTerms'
@Search.searchable: true
define view zpaymentview as select from I_PaymentTermsConditionsText
{
@Search.defaultSearchElement: true
key PaymentTerms,
PaymentTermsConditionDesc

    
}
