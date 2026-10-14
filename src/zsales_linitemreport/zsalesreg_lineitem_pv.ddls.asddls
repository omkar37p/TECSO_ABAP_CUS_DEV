    @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View sales register report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity ZSALESREG_LINEITEM_PV
  provider contract transactional_query
  as projection on ZSALESREG_LINEITEM_RV
{
  key VoucherNo,
  key CompanyCode,
      Particulars,
      Buyer,
      BuyerAddress,
      Consignee,
      ConsigneeAddress,
      ConsigneeCode,
      dt,
      VoucherType,
      SalesOrderNo,
      SalesOrderDate,
      TermsofDelivery,
      VoucherRefNo,
      DespatchDocNo,
      Destination,
      GSTINUIN,
      CustomerCode,
      InvoiceNo,
      BillingDOCCancel,
      CancelBillingDOC,
      GLAccount,
      GLName,
      Accdoc,
      amt,
      @Semantics.amount.currencyCode: 'amt'
      NetAmount,
      @Semantics.amount.currencyCode: 'amt'
      TaxAmount,
      @Semantics.amount.currencyCode: 'amt'
      TotalAmount,
      amt1,
      SGSTRate,
      @Semantics.amount.currencyCode: 'amt1'
      Josg,
      CGSTRate,
      amt2,
      @Semantics.amount.currencyCode: 'amt2'
      Jocg,
      IGSTRate,
      amt3,
      @Semantics.amount.currencyCode: 'amt3'
      Joig,
      perrate,
      BusinessPlace,
      BusinessPlacedes
}
