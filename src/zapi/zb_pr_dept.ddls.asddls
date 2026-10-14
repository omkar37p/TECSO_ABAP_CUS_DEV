@AbapCatalog.sqlViewName: 'ZPRBT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Base View exposing zpr_dept'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.representativeKey: 'Ptrm'
@Search.searchable: true
define view ZB_PR_DEPT as select from zpr_dept
{
@Search.defaultSearchElement: true
    key ptrm as Ptrm
}
