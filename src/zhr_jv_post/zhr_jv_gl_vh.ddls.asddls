@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help for GL account&journal'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
@ObjectModel : { dataCategory: #VALUE_HELP }

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZHR_JV_GL_VH as select from I_GLAccount
{
// @Search.defaultSearchElement: true
 //key CompanyCode,
@Search.defaultSearchElement: true
 key GLAccount     as  GLACC,
//key case
  //  when length(GLAccount) = 10 then GLAccount
   // when length(GLAccount) = 9 then concat('0', GLAccount)
   // when length(GLAccount) = 8 then concat('00', GLAccount)
   // when length(GLAccount) = 7 then concat('000', GLAccount)
    //when length(GLAccount) = 6 then concat('0000',GLAccount)
   // when length(GLAccount) = 5 then concat('00000', GLAccount)
   // when length(GLAccount) = 4 then concat('000000', GLAccount)
    //when length(GLAccount) = 3 then concat('0000000', GLAccount)
   // when length(GLAccount) = 2 then concat('00000000', GLAccount)
   // when length(GLAccount) = 1 then concat('000000000', GLAccount)
   // else GLAccount
  //end as GLAccount,
 @Search.defaultSearchElement: true
  GLAccountType as GLACT
}
