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
define root view entity ZSD_SalesReg_PV 
provider contract transactional_query 
as projection on ZSD_Sales_Reg_Rootview
{
    key VoucherNo,
    key BillingDocumentItem,
    key CompanyCode,
    key dt,
    Particulars,
    Buyer,
    BuyerAddress,
    Consignee,
    ConsigneeAddress,
    ConsigneeCode,
    VoucherType,
    SalesOrderNo,
    SalesOrderDate,
    TermsofPayment,
    TermsofDelivery,
    Deliveryno,
    DeliveryDate,
    VoucherRefNo,
    DespatchDocNo,
    Destination,
    GSTINUIN,
    CustomerCode,
    InvoiceNo,
    VehicleNo,
    BillingDOCCancel,
    CancelBillingDOC,
  //  acccc,
    GLAccount,
    GLName,
    Accdoc,
    
    MaterialNumber,
   // WBSElement,
    WBSElement1,
    qty,
    @Semantics.quantity.unitOfMeasure: 'qty'
    Quantity,
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
