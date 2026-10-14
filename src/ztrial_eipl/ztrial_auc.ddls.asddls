@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'AUC for FA'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
//@DataAging.noAgingRestriction: true
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE ]
define view entity ZTRIAL_AUC
  as select from I_JournalEntryItem as a
    inner join   I_JournalEntryItem as b on  b.CompanyCode          =  a.CompanyCode
                                         and b.FiscalYear           =  a.FiscalYear
                                         and b.AccountingDocument   =  a.AccountingDocument
                                         and b.Ledger               =  '0L'
                                         and b.WBSElementInternalID is not initial
                                         and b.WBSElementInternalID <> '00000000'
{
  key a.CompanyCode,
  key a.AccountingDocument,
  key a.FiscalYear,
  key a.MasterFixedAsset,
  key a.FixedAsset
}
where
      a.Ledger           = '0L'
  and a.MasterFixedAsset is not initial
  and a.FixedAsset       is not initial
group by
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.MasterFixedAsset,
  a.FixedAsset
