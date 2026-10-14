@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'child view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZJV_POST1_RVIEW
  as select from zdt_jv_post1
  association to parent ZJV_POST_RVIEW as _Header on $projection.Uuid = _Header.Uuid and $projection.Zmonth = _Header.Zmonth and
 $projection.Zyears = _Header.Zyears
{
  key uuid                      as Uuid,
  key zmonth                    as Zmonth,
  key zyears                    as Zyears,
  key slno                      as Slno,
      glcode                    as Glcode,
      debit                     as Debit,
      credit                    as Credit,
      costcentre                as Costcentre,
      journalentrytype          as Journalentrytype,
      ledgergroup               as Ledgergroup,
      journalentrydate          as Journalentrydate,
      postingdate               as Postingdate,
      fiscalperiod              as Fiscalperiod,
      documentheadertext        as Documentheadertext,
      transactioncurrency       as Transactioncurrency,
      currencytranslationdate   as Currencytranslationdate,
      referencedocumentnumber   as Referencedocumentnumber,
      taxfulfillmentdate        as Taxfulfillmentdate,
      @Semantics.amount.currencyCode : 'Transactioncurrency'
      calculatetaxautomatically as Calculatetaxautomatically,
      companyname               as Companyname,
      costcentrename            as Costcentrename,
      lastchangedby             as Lastchangedby,
      lastchangedat             as Lastchangedat,
      locallastchanged          as Locallastchanged,
      _Header
}
