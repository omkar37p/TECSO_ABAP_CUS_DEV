@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Upload'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_PAYMENT_UPLOAD
  provider contract transactional_query
  as projection on ZI_PAYMENT_UPLOAD
{
 key upload_id,

      company_code,
      gl_account,

      CompanyCodeName,
      Currency,
      GLAccountName,

      file_name,
      mime_type,
      file_content
}
