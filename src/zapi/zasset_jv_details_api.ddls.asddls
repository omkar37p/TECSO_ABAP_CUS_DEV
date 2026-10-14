//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Asset For JournalEntryItem API'
//@Metadata.ignorePropagatedAnnotations: true

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Asset For JournalEntryItem API'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
//@DataAging.noAgingRestriction: true
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE ]

define view entity ZASSET_JV_DETAILS_API
  as select from I_JournalEntryItem as JEI

{
  key  JEI.CompanyCode,
  key  JEI.MasterFixedAsset,
  key  JEI.FixedAsset,
       JEI.CompanyCodeCurrency                as Currency,
       @Semantics.amount.currencyCode: 'Currency'
       sum( JEI.AmountInCompanyCodeCurrency ) as TotalAmount
//       JEI.AccountingDocumentType             as AcDocType,
//       JEI.AccountingDocument                 as AcDoc,
//       JEI.FinancialTransactionType           as FTType
}
where JEI.Ledger = '0L' and JEI.AssetDepreciationArea = '01' and JEI.IsReversal is initial and JEI.IsReversed is initial
      and ( ( JEI.AccountingDocumentType = 'AA' and ( ( JEI.PostingKey = '70' and ( JEI.FinancialTransactionType = '920' or JEI.FinancialTransactionType = '900' or JEI.FinancialTransactionType = '925' ) )    
                                                   or ( JEI.PostingKey = '75' and JEI.OffsettingAccountType = 'S' and ( JEI.FinancialTransactionType = '920' or JEI.FinancialTransactionType = '930' ) ) ) )
         or ( JEI.AccountingDocumentType = 'SA' and JEI.FinancialTransactionType = '950' ) )
group by
  JEI.CompanyCode,
  JEI.MasterFixedAsset,
  JEI.FixedAsset,
  JEI.CompanyCodeCurrency
//  JEI.AccountingDocumentType,
//  JEI.AccountingDocument,
//  JEI.FinancialTransactionType
