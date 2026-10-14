@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for gl code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
//@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZHR_JV_GL_VH_cds as select from zhr_jv_gl_tb
{
 key cast('600003' as abap.char(10))as Glcode,
 cast ('fixed salary (monthly gross)'as abap.char(50))as Glname
  //  key glcode as Glcode,
    //glname as Glname,
    //lastchangedby as Lastchangedby,
    //lastchangedat as Lastchangedat,
    //locallastchanged as Locallastchanged
}union all
select from zhr_jv_gl_tb{
  key cast('600006' as abap.char(10))as Glcode,
 cast ('fixed salary (monthly)'as abap.char(50))as Glname
};
