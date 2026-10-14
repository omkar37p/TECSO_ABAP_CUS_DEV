@AbapCatalog.sqlViewName: 'ZSDFES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for Payemt term'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory:#VALUE_HELP

define view ZC_PR_DEPT_VH as select from zpr_dept
{
 @Consumption.valueHelpDefinition: [{entity: { name: 'ZB_PR_DEPT', 
                                                      element: 'Ptrm'  }}]
    key ptrm as Ptrm
}
