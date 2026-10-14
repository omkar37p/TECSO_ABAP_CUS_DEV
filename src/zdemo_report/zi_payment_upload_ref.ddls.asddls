@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Upload Reference Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PAYMENT_UPLOAD_REF
  as select from    I_CompanyCode            as cc

    left outer join I_GLAccountInCompanyCode as gl  on gl.CompanyCode = cc.CompanyCode

    inner join      I_GLAccount              as gla on gl.GLAccount = gla.GLAccount

    left outer join I_GLAccountText          as glt on  gla.GLAccount       = glt.GLAccount
                                                    and gla.ChartOfAccounts = glt.ChartOfAccounts
                                                    and glt.Language        = $session.system_language
{
  key   cc.CompanyCode,
  key   gl.GLAccount,
        cc.CompanyCodeName,
        cc.Currency,
        glt.GLAccountLongName as GLAccountName
}
