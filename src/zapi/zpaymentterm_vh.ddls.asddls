@AbapCatalog.sqlViewName: 'ZPAYMNETS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pAYMENT TERM VIEW HELP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory:#VALUE_HELP
//@OData.publish: true
//@ObjectModel.createEnabled: true
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET]

define view ZPAYMENTTERM_VH as select from I_PaymentTerms as pay
association to I_PaymentTermsConditionsText as _paymt on _paymt.PaymentTerms = $projection.PaymentTerms
{
@Consumption.valueHelpDefinition: [{entity: { name: 'zpaymentview', 
                                                      element: 'PaymentTerms'  }}]
 key pay.PaymentTerms,
 
 _paymt
}
