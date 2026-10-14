@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RV for Main'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZTRIAL_RV
  as select from    I_FixedAsset                   as FAS
    left outer join ZTRIAL_JV                      as FA   on  FA.CompanyCode      = FAS.CompanyCode
                                                           and FA.FixedAsset       = FAS.FixedAsset
                                                           and FA.MasterFixedAsset = FAS.MasterFixedAsset
                                                           and FA.Currency         = 'INR'
    left outer join ZTRIAL_JV                      as AU   on  AU.CompanyCode      = FAS.CompanyCode
                                                           and AU.FixedAsset       = FAS.OriginalFixedAsset
                                                           and AU.MasterFixedAsset = FAS.OriginalMasterFixedAsset
                                                           and AU.Currency         = 'INR'
    left outer join I_FixedAsset                   as AUCE on  AUCE.CompanyCode      = FAS.CompanyCode
                                                           and AUCE.FixedAsset       = FAS.OriginalFixedAsset
                                                           and AUCE.MasterFixedAsset = FAS.OriginalMasterFixedAsset
    left outer join ZTRIAL_AUC                     as AUC  on  AUC.CompanyCode      = FAS.CompanyCode
                                                           and AUC.FixedAsset       = FAS.OriginalFixedAsset
                                                           and AUC.MasterFixedAsset = FAS.OriginalMasterFixedAsset
    left outer join I_JournalEntryItem             as WBS  on  WBS.CompanyCode          =  FAS.CompanyCode
                                                           and WBS.Ledger               =  '0L'
                                                           and WBS.AccountingDocument   =  AUC.AccountingDocument
                                                           and WBS.FiscalYear           =  AUC.FiscalYear
                                                           and WBS.WBSElementInternalID is not initial
                                                           and WBS.WBSElementInternalID <> '00000000'
    left outer join I_EntProjWrkBrkdwnStrucElmntVH as WBSE on  WBSE.WBSElementInternalID = WBS.WBSElementInternalID
                                                           and WBSE.CompanyCode          = WBS.CompanyCode
{
  key FAS.CompanyCode,
  key FAS.FixedAsset,
  key FAS.MasterFixedAsset,
  key FAS.OriginalMasterFixedAsset    as AssetUnderConstruction,
  key WBS.WBSElementInternalID,
      FAS.FixedAssetExternalID,
      AUCE.FixedAssetExternalID       as AUCExternalID,
      WBSE.ProjectElement             as WBSElementExternalID,
      WBSE.Project,
      FA.Currency                     as Curr,
      @Semantics.amount.currencyCode: 'Curr'
      FA.TotalAmount                  as FA_Amount,
      @Semantics.amount.currencyCode: 'Curr'
      AU.TotalAmount                  as AUC_Amount,
      @Semantics.amount.currencyCode: 'Curr'
      WBS.AmountInCompanyCodeCurrency as WBS_Amount
}
