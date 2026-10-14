@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection viwe of parent'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZJV_POST_PV provider contract transactional_query as projection on ZJV_POST_RVIEW
{
    key Uuid,
    key Zmonth,
    key Zyears, 
    Jvname,
    Companycode,
    Companycodename,
    Designationname,
    Gradename,
    Departmentname,
    Subdepartmentname,
    Levelname,
    Regionname,
    Branchname,
    Subbranchname,
    Employeetypename,
    Employeestatusname,
    Businessunitname,
    Employeeotherstatusname,
    Formattype,
    Checkbox,
    Lastchangedby,
    Lastchangedat,
    Locallastchanged,
    Createdby,
    Createdate,
    /* Associations */
    _Item : redirected to composition child ZJV_POST1_PV
}
