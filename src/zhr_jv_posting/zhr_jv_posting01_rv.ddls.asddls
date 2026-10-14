@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view of Child HR  JV Posting'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZHR_JV_POSTING01_RV as select from zdb_jv_posting01
association to parent ZHR_JV_POSTING_RV as _Header on $projection.Uuid = _Header.Uuid
{
    key uuid as Uuid,
    key company as Company,
    glcode as Glcode,
    debit as Debit,
    credit as Credit,
    costcentre as Costcentre,
    journalentrytype as Journalentrytype,
    ledgergroup as Ledgergroup,
    journalentrydate as Journalentrydate,
    postingdate as Postingdate,
    fiscalperiod as Fiscalperiod,
    documentheadertext as Documentheadertext,
    transactioncurrency as Transactioncurrency,
    currencytranslationdate as Currencytranslationdate,
    referencedocumentnumber as Referencedocumentnumber,
    taxfulfillmentdate as Taxfulfillmentdate,
     @Semantics.amount.currencyCode : 'Transactioncurrency'
    calculatetaxautomatically as Calculatetaxautomatically,
    companyname as Companyname,
    costcentrename as Costcentrename,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    locallastchanged as Locallastchanged,
    _Header
}
