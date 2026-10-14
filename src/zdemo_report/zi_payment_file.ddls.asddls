@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Upload File'
//@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PAYMENT_FILE
  as select from zpaym_upl_file
   association to parent ZI_PAYMENT_UPLOAD_N as _Header
    on $projection.PaymentUuid = _Header.PaymentUUID
{
  key file_uuid    as FileUuid,
      payment_uuid as PaymentUuid,
      file_name    as FileName,
      mime_type    as MimeType,
      file_content as FileContent,
      created_by,
      created_at,
      _Header
}
