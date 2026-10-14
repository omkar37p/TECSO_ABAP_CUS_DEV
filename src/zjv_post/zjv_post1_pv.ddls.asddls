@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection  view for child'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZJV_POST1_PV
   as projection on ZJV_POST1_RVIEW
{
    key Uuid,
    key Zmonth,
    key Zyears,
    key Slno,
    Glcode,
    Debit,
    Credit,
    Costcentre,
    Journalentrytype,
    Ledgergroup,
    Journalentrydate,
    Postingdate,
    Fiscalperiod,
    Documentheadertext,
    Transactioncurrency,
    Currencytranslationdate,
    Referencedocumentnumber,
    Taxfulfillmentdate,
    @Semantics.amount.currencyCode : 'Transactioncurrency'
    Calculatetaxautomatically,
    Companyname,
    Costcentrename,
    Lastchangedby,
    Lastchangedat,
    Locallastchanged,
    /* Associations */
    _Header : redirected to parent ZJV_POST_PV
}
