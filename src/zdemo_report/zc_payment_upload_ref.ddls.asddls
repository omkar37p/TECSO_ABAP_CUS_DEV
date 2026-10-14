@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Upload Reference'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_PAYMENT_UPLOAD_REF
  as select from ZI_PAYMENT_UPLOAD_REF
{
  key CompanyCode,
  key GLAccount,
      CompanyCodeName,
      Currency,
      GLAccountName
}
