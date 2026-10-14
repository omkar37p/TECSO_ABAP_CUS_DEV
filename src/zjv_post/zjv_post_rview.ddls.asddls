@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view of parent'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZJV_POST_RVIEW
  as select from zdt_jv_post
  composition [0..*] of ZJV_POST1_RVIEW as _Item
{
  key uuid                    as Uuid,
  key zmonth                  as Zmonth,
  key zyears                  as Zyears,
        jvname                as Jvname,
      companycode             as Companycode,
      companycodename         as Companycodename,
      designationname         as Designationname,
      gradename               as Gradename,
      departmentname          as Departmentname, 
      subdepartmentname       as Subdepartmentname,
      levelname               as Levelname,
      regionname              as Regionname,
      branchname              as Branchname,
      subbranchname           as Subbranchname,
      employeetypename        as Employeetypename,
      employeestatusname      as Employeestatusname,
      businessunitname        as Businessunitname,
      employeeotherstatusname as Employeeotherstatusname,
      formattype              as Formattype,
      checkbox                as Checkbox,
      lastchangedby           as Lastchangedby,
      lastchangedat           as Lastchangedat,
      locallastchanged        as Locallastchanged,
      createdby               as Createdby,
      createdate              as Createdate,
      _Item
}
