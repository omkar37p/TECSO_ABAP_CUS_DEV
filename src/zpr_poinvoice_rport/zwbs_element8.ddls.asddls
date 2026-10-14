@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WBS ELEMENT 8 define view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZWBS_ELEMENT8
  as select from    I_PurOrdAccountAssignmentAPI01 as wb
    left outer join I_EnterpriseProjectElement     as wbs on wbs.WBSElementInternalID = wb.WBSElementInternalID_2
{
  key wb.PurchaseOrder,
      wb.WBSElementInternalID_2,
      wbs.ProjectElement
}
where
  wb.WBSElementInternalID_2 is not initial
group by
  wb.PurchaseOrder,
  wb.WBSElementInternalID_2,
  wbs.ProjectElement
