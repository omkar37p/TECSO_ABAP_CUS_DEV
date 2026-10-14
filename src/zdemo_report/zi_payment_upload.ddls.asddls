@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Upload'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PAYMENT_UPLOAD
  as select from zpay_upload as up

  association [1..1] to I_CompanyCode as _Company
    on _Company.CompanyCode = up.company_code

  association [1..1] to I_GLAccountInCompanyCode as _GL
    on _GL.CompanyCode = up.company_code
   and _GL.GLAccount   = up.gl_account

  association [0..1] to I_GLAccountText as _GLText
    on _GLText.GLAccount = up.gl_account
{
  key up.upload_id,

      up.company_code,
      up.gl_account,

      _Company.CompanyCodeName,
      _Company.Currency,

      _GLText.GLAccountLongName as GLAccountName,

      up.file_name,
      up.mime_type,
      up.file_content
}
