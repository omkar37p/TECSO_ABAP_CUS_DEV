@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View asset details api'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity ZASSET_DETAILS_API_PV
  provider contract transactional_query
  as projection on ZASSET_DETAILS_API
{
  key AssetNo,
  key CompanyCode,
  //key JE,
      AssetType,
      LifecycleStatus,
      WBSElement,
      AssetName
}
