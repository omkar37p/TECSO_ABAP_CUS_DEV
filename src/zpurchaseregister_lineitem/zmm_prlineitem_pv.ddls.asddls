@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View For Purchase Register LineItem'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PRLINEITEM_PV
  provider contract transactional_query
  as projection on ZMM_PRLINEITEM_RV
{
  key PurchaseOrder,
  key AccountingDocNo,
  key MatDocYear,
  key Companycode,
  key GRNYear,
      // WBSELEMENT,
  key SupplierInvoiceNo,
  key referencenumber,
  key Postingdate,
  key InvDate,
  key DeliveryDate,
  key PriceUnit,
  key DocumentReferenceID,
  key GLAccount,
  key VendorCode,
  key VendorName,
  key VendorStateCode,
  key VendorGSTIN,
  key VendorCountry,
  key VendorPAN,
  key PurchaseType,
  key PODate,
  key POGroup,
  key Currency,
  key Plant,
  key TaxCode,
  key BaseUnit,
  key AAcat,
  key POType,
  key StorageLocation,
  key GCode,
  key GLName,
  key UTR,
  key AccountingDocumentType,
      //      @Semantics.amount.currencyCode: 'PriceUnit'
      //      Rate,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      ORDQuantity,

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
      DiscountValue
}
