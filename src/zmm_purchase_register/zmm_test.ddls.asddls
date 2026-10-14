@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_TEST
  as select from    I_JournalEntry            as JE
    left outer join      I_JournalEntryItem        as JEI   on  JEI.AccountingDocument = JE.AccountingDocument
                                                       and JEI.FiscalYear         = JE.FiscalYear
                                                       and JEI.CompanyCode        = JE.CompanyCode
                                               //        and JEI.OffsettingAccountType = 'K'
                                                //       and JEI.OffsettingAccountType = 'M'
                                                       and JEI.Ledger             = '0L'
                                                      // and JEI.LedgerGLLineItem   = '000002'
////////    left outer join I_JournalEntryItem        as JEI2  on  JEI2.AccountingDocument   = JE.AccountingDocument      //added for utr
////////                                                       and JEI2.FiscalYear           = JE.FiscalYear
////////                                                       and JEI2.CompanyCode          = JE.CompanyCode
////////                                                       and JEI2.Ledger               = '0L'
////////                                                       and JEI2.FinancialAccountType = 'K'
////////    left outer join I_JournalEntry            as JE2   on  JE2.AccountingDocument     = JEI2.ClearingJournalEntry //added for utr
////////                                                       and JE2.FiscalYear             = JEI2.ClearingJournalEntryFiscalYear
////////                                                       and JE2.CompanyCode            = JEI2.CompanyCode
////////                                                       and JE2.AccountingDocumentType = 'KZ'
////////    
////////    left outer join I_Supplier                as SUP   on SUP.Supplier = JEI.Supplier
////////    left outer join I_OperationalAcctgDocItem as OADI  on  OADI.AccountingDocument     = JEI.AccountingDocument
////////                                                       and OADI.AccountingDocumentItem = JEI.AccountingDocumentItem
////////                                                       and OADI.FiscalYear             = JEI.FiscalYear
////////                                                       and OADI.CompanyCode            = JEI.CompanyCode
////////  //  and OADI.DebitCreditCode = 'S'
////////  //                                                       and OADI.ProfitCenter       <> ' '
////////  //                                                       and OADI.TaxCode            <> ' '
////////    left outer join I_OperationalAcctgDocItem as CGST  on  CGST.AccountingDocument           = OADI.AccountingDocument
////////                                                       and CGST.FiscalYear                   = OADI.FiscalYear
////////                                                       and CGST.TaxItemGroup                 = OADI.TaxItemGroup
////////                                                       and CGST.AccountingDocumentItemType   = 'T'
////////                                                       and CGST.TransactionTypeDetermination = 'JIC'
////////    left outer join I_OperationalAcctgDocItem as IGST  on  IGST.AccountingDocument           = OADI.AccountingDocument
////////                                                       and IGST.FiscalYear                   = OADI.FiscalYear
////////                                                       and IGST.TaxItemGroup                 = OADI.TaxItemGroup
////////                                                       and IGST.AccountingDocumentItemType   = 'T'
////////                                                       and IGST.TransactionTypeDetermination = 'JII'
////////    left outer join I_OperationalAcctgDocItem as IGST1 on  IGST1.AccountingDocument           = OADI.AccountingDocument
////////                                                       and IGST1.FiscalYear                   = OADI.FiscalYear
////////                                                       and IGST1.TaxItemGroup                 = OADI.TaxItemGroup
////////                                                       and IGST1.AccountingDocumentItemType   = 'T'
////////                                                       and IGST1.TransactionTypeDetermination = 'JIM'
  //  //test one
  //      left outer join I_OperationalAcctgDocItem as ACO   on  ACO.InvoiceReference     = OADI.AccountingDocument
  //                                                         and ACO.InvoiceItemReference = OADI.TaxItemGroup
  //                                                         and ACO.FiscalYear           = OADI.FiscalYear
  //                                                         and ACO.CompanyCode          = OADI.CompanyCode

{
  key JE.CompanyCode,
  key JEI.AccountingDocument,
  key JE.FiscalYear,
      JEI.Supplier                                       as supp,
////////      //  key OADI.TaxItemGroup,
////////      
////////      JE2.DocumentReferenceID,  
////////      
////////      //      JE.DocumentReferenceID,
////////      JE.AccountingDocument                              as jeaccdoc,
////////      JE.DocumentDate                                    as Invoicedate,
////////      JE.DocumentDate                                    as Deliverydate,
////////      JE.PostingDate                                     as GRPostingdate,
////////      JEI.FiscalYearPeriod,
////////      JEI.GLAccount                                      as GLAccount,
////////      JEI.LedgerGLLineItem,
////////      cast( JEI.WBSElement as abap.char(24) )            as WBSELEMENT,
      JEI.PurchasingDocument,
      JEI.PurchasingDocumentItem
////////      JEI.AccountingDocumentItem,
////////      //        ADJ.DocumentReferenceID as Docrefereneceid,
////////      OADI.Product,
////////      OADI.TaxCode,
////////      OADI.IN_HSNOrSACCode,
////////      OADI.CompanyCodeCurrency,
////////      OADI.TransactionCurrency,
////////      OADI.PostingDate,
////////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
////////      CGST.AmountInCompanyCodeCurrency                   as CCGST,
////////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
////////      CGST.AmountInTransactionCurrency                   as TCGST,
////////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
////////      IGST.AmountInCompanyCodeCurrency                   as CIGST,
////////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
////////      IGST.AmountInTransactionCurrency                   as TIGST,
////////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
////////      IGST1.AmountInCompanyCodeCurrency                  as CIGST1,
////////      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
////////      IGST1.AmountInTransactionCurrency                  as TIGST1,
////////      CGST.TransactionTypeDetermination                  as TransactionTypeDetermination,
////////      IGST.TransactionTypeDetermination                  as TransactionTypeDeterminationI,
////////      IGST1.TransactionTypeDetermination                 as TransactionTypeDetermination1,
////////      SUP.TaxNumber3,
////////      SUP.Supplier,
////////      SUP.SupplierName,
////////      SUP.Region,
////////      SUP.Country,
////////      SUP.BusinessPartnerPanNumber,
////////      substring(OADI.Reference3IDByBusinessPartner,5,10) as Reference3IDByBusinessPartner,
////////      substring(OADI.OriginalReferenceDocument,1,10)     as OriginalReferenceDocument,
////////      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
////////      OADI.Quantity,
////////      OADI.BaseUnit,
////////      OADI.DebitCreditCode,
////////      //      // OADI.Supplier,
////////      @Semantics.amount.currencyCode: 'TransactionCurrency'
////////     // sum(OADI.AmountInTransactionCurrency)             
////////       OADI.AmountInTransactionCurrency as AmountInTransactionCurrency
////////      //      ACO.AccountingDocument                             as testAccno,
////////      //      ACO.AccountingDocumentItem                         as testAccnoit,
////////      //      ACO.CompanyCode                                    as testcomcode,
////////      //      ACO.FiscalYear                                     as testFiscalYear,
////////      //      ACO.InvoiceReference,
////////      //      ACO.InvoiceItemReference
////////


}
where JEI.OffsettingAccountType = 'K' or JEI.OffsettingAccountType = 'M'
//  JE.DocumentReferenceID is not initial
//  ( JE.DocumentReferenceID is not initial or JE2.DocumentReferenceID is not initial )
group by
  JE.CompanyCode,
  JEI.AccountingDocument,
  JE.FiscalYear,
  JEI.Supplier,
////////  JEI2.ClearingDate,
////////  //  OADI.TaxItemGroup,
////////  JE.DocumentReferenceID,
////////  JE2.DocumentReferenceID,
////////  JE.AccountingDocument,
////////  JE.DocumentDate,
////////  JE.DocumentDate,
////////  JE.PostingDate,
////////  JEI.FiscalYearPeriod,
////////  JEI.GLAccount,
////////  //GALI.WBSElement,
////////  JEI.WBSElement,
  JEI.PurchasingDocument,
  JEI.PurchasingDocumentItem
////////  JEI.AccountingDocumentItem,
////////  //    ADJ.DocumentReferenceID,
////////  JEI.LedgerGLLineItem,
////////  OADI.Product,
////////  OADI.TaxCode,
////////  OADI.IN_HSNOrSACCode,
////////  OADI.CompanyCodeCurrency,
////////  OADI.TransactionCurrency,
////////  OADI.PostingDate,
////////  CGST.AmountInCompanyCodeCurrency,
////////  CGST.AmountInTransactionCurrency,
////////  IGST.AmountInCompanyCodeCurrency,
////////  IGST.AmountInTransactionCurrency,
////////  IGST1.AmountInCompanyCodeCurrency,
////////  IGST1.AmountInTransactionCurrency,
////////  CGST.TransactionTypeDetermination,
////////  IGST.TransactionTypeDetermination,
////////  IGST1.TransactionTypeDetermination,
////////  SUP.TaxNumber3,
////////  SUP.Supplier,
////////  SUP.SupplierName,
////////  SUP.Region,
////////  SUP.Country,
////////  SUP.BusinessPartnerPanNumber,
////////  OADI.Reference3IDByBusinessPartner,
////////  OADI.OriginalReferenceDocument,
////////  OADI.Quantity,
////////  OADI.BaseUnit,
////////  OADI.DebitCreditCode,
////////  OADI.AmountInTransactionCurrency
