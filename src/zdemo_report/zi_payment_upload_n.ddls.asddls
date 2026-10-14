@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Upload'
@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.compositionRoot: true
//@ObjectModel.transactionalProcessingEnabled: true
//@ObjectModel.attachment.enabled: true
define root view entity ZI_PAYMENT_UPLOAD_N as select from zpaym_upl_hdr as hdr

//  association [0..*] to ZI_PAYMENT_FILE as _File
//    on $projection.PaymentUUID = _File.PaymentUuid
composition [0..*] of ZI_PAYMENT_FILE as _File

  association [0..1] to ZI_PAYMENT_UPLOAD_REF as _Ref
    on  $projection.CompanyCode = _Ref.CompanyCode
    and $projection.GLAccount   = _Ref.GLAccount
{
  key hdr.payment_uuid   as PaymentUUID,

      hdr.company_code   as CompanyCode,
      hdr.gl_account     as GLAccount,

      _Ref.CompanyCodeName,
      _Ref.Currency,
      _Ref.GLAccountName,

      hdr.created_by,
      hdr.created_at,
      hdr.last_changed_by,
      hdr.last_changed_at,

      _File
}
