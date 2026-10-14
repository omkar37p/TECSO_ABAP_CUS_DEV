@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Month'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
@ObjectModel : { dataCategory: #VALUE_HELP }
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZHR_MONTH_VH as select from I_YearMonth
{
@Search.defaultSearchElement: true
    key CalendarMonth,
    @Search.defaultSearchElement: true
    CalendarYear
}
