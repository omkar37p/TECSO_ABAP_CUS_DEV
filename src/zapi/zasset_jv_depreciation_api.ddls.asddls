@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Asset For JournalEntryItem API'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
//@DataAging.noAgingRestriction: true
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE ]

define view entity ZASSET_JV_DEPRECIATION_API
  as select from I_JournalEntryItem as JEI

{
  key  JEI.CompanyCode,
  key  JEI.MasterFixedAsset,
  key  JEI.FixedAsset,
       //key  JEI.AccountingDocument,
       //key  JEI.FiscalYear                          as FY,
       JEI.CompanyCodeCurrency                as Currency,
       //JEI.AssetTransactionType,

       @Semantics.amount.currencyCode: 'Currency'
       sum( JEI.AmountInCompanyCodeCurrency ) as DepreciationAmount
       //       JEI.AccountingDocumentType             as AcDocType,
       //       JEI.AccountingDocument                 as AcDoc,
       //       JEI.FinancialTransactionType           as FTType
}
where
       JEI.Ledger                          = '0L'
  and  JEI.AssetDepreciationArea           = '01'
  and  JEI.IsReversal                      is initial
  and  JEI.IsReversed                      is initial
  and  cast( JEI.FiscalYear as abap.int4 ) = case
                                                when substring( cast( $session.system_date as abap.char(8) ), 5, 4 ) > '0331'
                                                     then cast( substring( cast( $session.system_date as abap.char(8) ), 1, 4 ) as abap.int4 ) - 1
                                                else cast( substring( cast( $session.system_date as abap.char(8) ), 1, 4 ) as abap.int4 ) - 2
                                            end
  and(
       JEI.AssetTransactionType            = '500'
    or JEI.AssetTransactionType            = '100'
  )
//and JEI.AssetTransactionType = '500' and JEI.FiscalYear = '2025' or  JEI.AssetTransactionType = '100' and JEI.FiscalYear = '2025'
group by
  JEI.CompanyCode,
  JEI.MasterFixedAsset,
  JEI.FixedAsset,
  //JEI.AccountingDocument,
  //JEI.FiscalYear,
  JEI.CompanyCodeCurrency
//JEI.AssetTransactionType
