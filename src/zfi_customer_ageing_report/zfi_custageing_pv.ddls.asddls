 @AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for ZFI_CUSTAGEING'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZFI_CUSTAGEING_PV as projection on ZFI_CUSTAGEING_RV
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    key Customer,
    CustomerName,
    PostingDate,
    CURR,
    @Semantics.amount.currencyCode: 'Curr'
    AmountInTransactionCurrency,
    Arrear,
    @Semantics.amount.currencyCode: 'Curr'
    @EndUserText.label: 'Over Due 90'
    overdue0_90,
    @Semantics.amount.currencyCode: 'Curr'
    overdue91_120,
    @Semantics.amount.currencyCode: 'Curr'
    overdue121_150,
    @Semantics.amount.currencyCode: 'Curr'
    overdue151_180, 
    @Semantics.amount.currencyCode: 'Curr'
    overdue181_365,
    @Semantics.amount.currencyCode: 'Curr'
    overdue366_720,
    @Semantics.amount.currencyCode: 'Curr'
    overdue721,
    OverdueStatus
}
