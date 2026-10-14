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
define view entity ZHR_JV_POST1_PV  as projection on ZHR_JV_POST1_RV
{
    key Uuid,
    key  Zmonth,
   key Zyears,
  // @ObjectModel.text.element: [ 'CompanyName' ]
    key Company,
    Glcode,
    Debit,
    Credit,
    //@ObjectModel.text.element: [ 'Costcentrename' ]
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
    @ObjectModel.text.element: [ 'companyname' ]
    Companyname,
   @ObjectModel.text.element: [ 'Costcentrename' ]
    Costcentrename,
    Lastchangedby,
    Lastchangedat,
    Locallastchanged,
    /* Associations */
    _Header : redirected to parent ZHR_JV_POST_PV
}
