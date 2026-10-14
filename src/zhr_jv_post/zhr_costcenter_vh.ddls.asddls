@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cost Center Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel: { dataCategory: #VALUE_HELP }
@Search.searchable: true
define view entity ZHR_COSTCENTER_VH as select from I_CostCenterStdVH
{
@Search.defaultSearchElement: true
key ControllingArea,
@Search.defaultSearchElement: true
key CostCenter,
@Search.defaultSearchElement: true
key ValidityEndDate,
ValidityStartDate,
/* Associations */
_ControllingArea,
_Text.CostCenterName as Costcentrename    
}
