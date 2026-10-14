@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ASSET DETAILS API'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZASSET_DETAILS_API
  as select from    I_FixedAsset          as MAIN
    left outer join I_FixedAssetAssgmt    as WBS on  WBS.MasterFixedAsset  = MAIN.MasterFixedAsset
                                                 and WBS.CompanyCode       = MAIN.CompanyCode
                                                 and WBS.FixedAsset        = MAIN.FixedAsset
                                                 and WBS.ValidityEndDate   >= $session.system_date
                                                 and WBS.ValidityStartDate <= $session.system_date
    left outer join ZASSET_JV_DETAILS_API as APC on  APC.MasterFixedAsset = MAIN.MasterFixedAsset
                                                 and APC.CompanyCode      = MAIN.CompanyCode
                                                 and APC.FixedAsset       = MAIN.FixedAsset
                                                 and APC.Currency         = 'INR'
   left outer join ZASSET_JV_DEPRECIATION_API as DEPR on DEPR.MasterFixedAsset = MAIN.MasterFixedAsset
                                                 and DEPR.CompanyCode     = MAIN.CompanyCode
                                                 and DEPR.FixedAsset      = MAIN.FixedAsset
                                                 and DEPR.Currency        = 'INR'                                              
{
  key MAIN.FixedAssetExternalID  as AssetNo,
  key MAIN.CompanyCode           as CompanyCode,
 // key DEPR.AccountingDocument    as JE,
      MAIN.AssetClass            as AssetType,
      MAIN.AssetLifecycleStatus  as LifecycleStatus,
      WBS.WBSElementInternalID_2 as WBSElement,
      MAIN.FixedAssetDescription as AssetName,
      APC.Currency               as Currency,
      @Semantics.amount.currencyCode: 'Currency'
      APC.TotalAmount            as CapitalisedCost,
      @Semantics.amount.currencyCode: 'Currency'
      DEPR.DepreciationAmount    as DepriciationAmount
      //APC.AcDocType              as AccDocType,
      //APC.AcDoc,
      //APC.FTType
}
where
      MAIN.AssetClass           = 'ZA01'
  and MAIN.AssetLifecycleStatus = '4'
