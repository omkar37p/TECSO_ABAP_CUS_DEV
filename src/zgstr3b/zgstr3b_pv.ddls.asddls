@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view of GSTR3B'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZGSTR3B_PV 
provider contract transactional_query
  as projection on ZGSTR3B_ROOT

{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    key SourceLedger,
    key LedgerGLLineItem,
    key Ledger,
    DocumentReferenceID,
    DocumentDate,
    AccountingDocumentType,
    ProfitCenter,
    TransactionTypeDetermination,
    FiscalPeriod,
    GLAccount,
    BusinessPlace,
    buyergstin,
    Supplier,
    suppliergstin,
    suppliername,
    invoicestatus,
    supplytype,
    invoiceno,
    invoicedate,
    TaxCode,
    invoicetype,
    notenumber,
    hsn_sac,
    uom,
    itemdescription,
    GST_Rate,
    itceligibility,
    eligibilitycategory,
    reversecharge,
    importtype,
    gstr2returnperiod,
    b3auto_fillperiod,
    PostingDate,
    CCURR,
    TaxItemGroup,
    @Semantics.amount.currencyCode: 'Ccurr' 
    TaxableValue,
    @Semantics.amount.currencyCode: 'Ccurr' 
    IGSTAmount,
    @Semantics.amount.currencyCode: 'Ccurr' 
    CGSTAmount,
    @Semantics.amount.currencyCode: 'Ccurr' 
    SGSTAmount,
    @Semantics.amount.currencyCode: 'Ccurr' 
    cessamount,
    ReversalReferenceDocument,
    InvoiceValue
}
