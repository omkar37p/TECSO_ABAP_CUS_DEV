@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PurchaseRegister_PV 
provider contract transactional_query as projection on ZMM_PurchaseRegister_RE
{
    key PurchaseOrder,
    key PurchaseOrderItem,
    key AccountingDocNo,
   key  GRN,
   key  MaterialDocItem,
   key  MatDocYear,
     
  key   Companycode,
   key  GRNYear,
   WBSELEMENT,
    SupplierInvoiceNo,
    referencenumber,
    GRNDate,
    Postingdate, 
    InvDate,
    DeliveryDate,
    PriceUnit,
    DocumentReferenceID,
    GLAccount,
    VendorCode,
    VendorName,
    VendorStateCode,
    VendorGSTIN,
    VendorCountry,
    VendorPAN,
    PurchaseType,
    PODate,
    POGroup,
    Hsnno,
    Material,
    MaterialDesc,
    MaterialType,
    MaterialGroup,
    Currency,
    PORequisition,
    RequisitionerName,
    @Semantics.amount.currencyCode: 'PriceUnit'
    Rate,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    ORDQuantity,
    Plant,
    TaxCode,
    BaseUnit,
    AAcat,
    POType,
    StorageLocation,
    MovementType,
    EntryUnit,
    @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    GRNQuantity, 
    Base,
    @Semantics.quantity.unitOfMeasure: 'Base'
    InvoiceQuantity,
    DCCode,
    @Semantics.amount.currencyCode: 'PriceUnit'
    TaxableValue,
    @Semantics.amount.currencyCode: 'PriceUnit'
    CGSTAmount,
    @Semantics.amount.currencyCode: 'PriceUnit'
    SGSTAmount,
    @Semantics.amount.currencyCode: 'PriceUnit'
    IGSTAmount,
    @Semantics.amount.currencyCode: 'PriceUnit'
    GrossAmount,
    DiscountValue,
    GCode,
    GLName,
    UTR,
    AccountingDocumentType
    //UTR
   // WBSElement
    
   // WBSElement
    
}
