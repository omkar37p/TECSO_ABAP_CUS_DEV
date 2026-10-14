@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Root Entity View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PurchaseRegister_RE
  as select distinct from I_PurchaseOrderAPI01           as PO
    left outer join       I_PurchaseOrderItemAPI01       as POI  on POI.PurchaseOrder = PO.PurchaseOrder
    left outer join       I_ProductText                  as PT   on  PT.Product  = POI.Material
                                                                 and PT.Language = 'E'
    left outer join       I_MaterialDocumentItem_2       as MDI  on  MDI.PurchaseOrder     = POI.PurchaseOrder
                                                                 and MDI.PurchaseOrderItem = POI.PurchaseOrderItem
    left outer join       I_Supplier                     as SUP  on SUP.Supplier = PO.Supplier
  //    left outer join ZMM_GRP_1                      as OADI on OADI.Reference3IDByBusinessPartner = MDI.MaterialDocument
  //                                                           and  OADI.Supplier               = PO.Supplier
  //                                                           and OADI.PurchasingDocument     = MDI.PurchaseOrder
  //                                                           and OADI.PurchasingDocumentItem = MDI.PurchaseOrderItem

    left outer join       ZMM_GRP_1                      as OADI on  OADI.PurchasingDocument     = POI.PurchaseOrder
                                                                 and OADI.PurchasingDocumentItem = POI.PurchaseOrderItem
  //and OADI.Reference3IDByBusinessPartner = MDI.MaterialDocument

    left outer join       I_JournalEntryItem             as JEI  on  MDI.MaterialDocument     = JEI.ReferenceDocument
                                                                 and MDI.MaterialDocumentItem = substring(
      JEI.ReferenceDocumentItem, 3, 4
    )
                                                                 and JEI.Ledger               = '0L'
                                                                 and JEI.LedgerGLLineItem     = '000002'

    inner join            I_JournalEntryItem             as JEII on  JEII.PurchasingDocument     =  POI.PurchaseOrder
                                                                 and JEII.PurchasingDocumentItem =  POI.PurchaseOrderItem
    //   and MDI.MaterialDocumentItem = substring(JEI.ReferenceDocumentItem, 3, 4)
                                                                 and JEII.Ledger                 =  '0L'
    //      and JEI.LedgerGLLineItem     = '000002'
                                                                 and JEII.OffsettingAccountType  =  'S'
                                                                 and JEII.IsOpenItemManaged      <> 'X' //and JE.DocumentReferenceID is not initial

  //    left outer join      I_AccountingDocumentJournal(P_Language: 'E') as ADJ  on  JEI.AccountingDocument     = ADJ.InvoiceReference
  //                                                                              //and JEI.ClearingAccountingDocument = ADJ.ClearingAccountingDocument
  //                                                                               and JEI.Supplier               = ADJ.Supplier
  //                                                                               and ADJ.Ledger                 = '0L'
  //                                                                               and ADJ.AccountingDocumentType = 'KZ'

    left outer join       I_PurchasingDocumentTypeText   as PDT  on  PDT.PurchasingDocumentType     = PO.PurchaseOrderType
                                                                 and PDT.PurchasingDocumentCategory = POI.PurchaseOrderCategory
                                                                 and PDT.Language                   = 'E'
    left outer join       I_PurOrdItmPricingElementAPI01 as PIPE on  PIPE.PurchaseOrder     = POI.PurchaseOrder
                                                                 and PIPE.PurchaseOrderItem = POI.PurchaseOrderItem
                                                                 and PIPE.ConditionType     = 'ZDSV'
    left outer join       I_GLAccountText                as GAT  on GAT.GLAccount = OADI.GLAccount
    left outer join       I_StorageLocationStdVH         as SL   on  SL.Plant           = POI.Plant
                                                                 and SL.StorageLocation = POI.StorageLocation

{
  key  PO.PurchaseOrder,
  key  POI.PurchaseOrderItem,
  key  OADI.AccountingDocument                                  as AccountingDocNo,
  key  MDI.MaterialDocument                                     as GRN,
  key  MDI.MaterialDocumentItem                                 as MaterialDocItem,
  key  MDI.MaterialDocumentYear                                 as MatDocYear,

  key  PO.CompanyCode                                           as Companycode,
  key  MDI.MaterialDocumentYear                                 as GRNYear,
       // OADI.AccountingDocument as OADIAccDoc,
       //  JEI.AccountingDocument                    as AccountingDocNo,
       JEI.AccountingDocumentItem,
       JEI.LedgerGLLineItem,
       //OADI.WBSElement                as WBSElement,
       cast( JEII.WBSElementInternalID as abap.char(24) )       as WBSELEMENT,
       //OADI
       GAT.GLAccount                                            as GLCode,
       OADI.OriginalReferenceDocument                           as SupplierInvoiceNo,
       OADI.DocumentReferenceID1                                as referencenumber,
       //SUP.Supplier  as supinv1,
       OADI.PostingDate                                         as GRNDate,
       //OADI.GRPostingdate                         as Postingdate,
       PO.PurchaseOrderDate                                     as Postingdate,
       OADI.Invoicedate,
       OADI.DocumentReferenceID,
       OADI.GLAccount,
       PO.Supplier                                              as VendorCode,
       SUP.SupplierName                                         as VendorName,
       // OADI.Region                                as VendorStateCode,
       SUP.Region                                               as VendorStateCode,
       SUP.TaxNumber3                                           as VendorGSTIN,
       SUP.Country                                              as VendorCountry,
       SUP.BusinessPartnerPanNumber                             as VendorPAN,
       OADI.Invoicedate                                         as InvDate,
       OADI.Deliverydate                                        as DeliveryDate,
       OADI.TransactionCurrency                                 as PriceUnit,

       PO.PurchaseOrderType                                     as PurchaseType,
       PO.PurchaseOrderDate                                     as PODate,
       PO.PurchasingGroup                                       as POGroup,
       POI.BR_NCM                                               as Hsnno,
       POI.Material                                             as Material,
       POI.PurchaseOrderItemText                                as MaterialDesc,
       POI.MaterialType                                         as MaterialType,
       POI.MaterialGroup                                        as MaterialGroup,
       POI.DocumentCurrency                                     as Currency,
       POI.PurchaseRequisition                                  as PORequisition,
       POI.RequisitionerName                                    as RequisitionerName,
       @Semantics.amount.currencyCode: 'PriceUnit'
       cast( POI.NetPriceAmount as abap.dec( 21, 2 ) )          as Rate,
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       cast( POI.OrderQuantity as abap.dec( 12, 2 ) )           as ORDQuantity,
       POI.Plant                                                as Plant,
       POI.TaxCode                                              as TaxCode,
       POI.BaseUnit                                             as BaseUnit,
       POI.AccountAssignmentCategory                            as AAcat,
       PDT.PurchasingDocumentType                               as POType,
       //MDI.StorageLocation            as StorageLocation,
       SL.StorageLocationName                                   as StorageLocation,
       // POI.StorageLocation              as StorageLocation,
       MDI.GoodsMovementType                                    as MovementType,
       MDI.MaterialBaseUnit                                     as EntryUnit,
       @Semantics.quantity.unitOfMeasure: 'EntryUnit'
       case when MDI.DebitCreditCode = 'H' or OADI.DebitCreditCode = 'H'
       then cast( MDI.QuantityInBaseUnit * -1 as abap.dec( 12, 2 ) ) else
       cast( MDI.QuantityInBaseUnit as abap.dec( 12, 2 ) )  end as GRNQuantity,
       OADI.BaseUnit                                            as Base,
       @Semantics.quantity.unitOfMeasure: 'Base'
       case when MDI.DebitCreditCode = 'H' or OADI.DebitCreditCode = 'H'
       then OADI.Quantity * -1 else
       OADI.Quantity       end                                  as InvoiceQuantity,
       OADI.DebitCreditCode                                     as DCCode,
       @Semantics.amount.currencyCode: 'PriceUnit'
       OADI.AmountInTransactionCurrency                         as TaxableValue,
       @Semantics.amount.currencyCode: 'PriceUnit'
       OADI.TCGST                                               as CGSTAmount,
       @Semantics.amount.currencyCode: 'PriceUnit'
       OADI.TCGST                                               as SGSTAmount,
       @Semantics.amount.currencyCode: 'PriceUnit'
       OADI.TIGST                                               as IGSTAmount,
       @Semantics.amount.currencyCode: 'PriceUnit'
       case when
       OADI.TransactionTypeDetermination = 'JIC' or OADI.TransactionTypeDetermination = 'JIS'
       then OADI.TCGST + OADI.TCGST+OADI.AmountInTransactionCurrency
       when OADI.TransactionTypeDeterminationI = 'JII'
       then OADI.TIGST + OADI.AmountInTransactionCurrency
       else OADI.AmountInTransactionCurrency  end               as GrossAmount,
       PIPE.ConditionRateValue                                  as DiscountValue,
       GAT.GLAccount                                            as GCode,
       GAT.GLAccountName                                        as GLName,
       OADI.DocumentReferenceID                                 as UTR,
       OADI.AccountingDocumentType
       //  Jentry.DocumentReferenceID as utr1
       // OADI.WBSElement                        as WBSElement
       // cast( GALI.WBSElement  as abap.char( 24 ) )as WBSElement
}
//where
//  ADJ.AccountingDocumentType = 'KZ'


//Added Union All on 24.11.2025 to include Direct Posting of Vendor Invoices that is not related to any Purchase Order
union all select from I_JournalEntry            as JE
  inner join          I_JournalEntryItem        as JEI   on  JEI.CompanyCode          =  JE.CompanyCode
                                                         and JEI.AccountingDocument   =  JE.AccountingDocument
                                                         and JEI.FiscalYear           =  JE.FiscalYear
                                                         and JEI.Ledger               =  '0L'
                                                         and JEI.FinancialAccountType =  'K'
                                                         and JEI.Supplier             is not initial
                                                         and JEI.IsReversal           <> 'X'
                                                         and JEI.IsReversed           <> 'X'
  left outer join     I_JournalEntryItem        as JEI2  on  JEI2.CompanyCode           =  JE.CompanyCode
                                                         and JEI2.AccountingDocument    =  JE.AccountingDocument
                                                         and JEI2.FiscalYear            =  JE.FiscalYear
                                                         and JEI2.Ledger                =  '0L'
                                                         and JEI2.OffsettingAccountType =  'S'
                                                         and JEI2.IsOpenItemManaged     <> 'X'
  inner join          I_JournalEntryItem        as JEI3  on  JEI3.CompanyCode        = JE.CompanyCode
                                                         and JEI3.AccountingDocument = JE.AccountingDocument
                                                         and JEI3.FiscalYear         = JE.FiscalYear
                                                         and JEI3.Ledger             = '0L'
                                                         and JEI3.GLAccountType      = 'P'
  left outer join     I_OperationalAcctgDocItem as OADI  on  OADI.CompanyCode            = JEI.CompanyCode
                                                         and OADI.AccountingDocument     = JEI.AccountingDocument
                                                         and OADI.FiscalYear             = JEI.FiscalYear
                                                         and OADI.AccountingDocumentItem = JEI.AccountingDocumentItem
  left outer join     I_OperationalAcctgDocItem as OADI2 on  OADI2.CompanyCode            = JEI3.CompanyCode
                                                         and OADI2.AccountingDocument     = JEI3.AccountingDocument
                                                         and OADI2.FiscalYear             = JEI3.FiscalYear
                                                         and OADI2.AccountingDocumentItem = JEI3.AccountingDocumentItem
  left outer join     I_JournalEntry            as JE2   on  JE2.CompanyCode            = JEI.CompanyCode
                                                         and JE2.AccountingDocument     = JEI.ClearingJournalEntry
                                                         and JE2.FiscalYear             = JEI.ClearingJournalEntryFiscalYear
                                                         and JE2.AccountingDocumentType = 'KZ'
  left outer join     I_Supplier                as SUP   on SUP.Supplier = JEI.Supplier
  left outer join     I_OperationalAcctgDocItem as CGST  on  CGST.CompanyCode                  = OADI2.CompanyCode
                                                         and CGST.AccountingDocument           = OADI2.AccountingDocument
                                                         and CGST.FiscalYear                   = OADI2.FiscalYear
                                                         and CGST.TaxItemGroup                 = OADI2.TaxItemGroup
                                                         and CGST.AccountingDocumentItemType   = 'T'
                                                         and CGST.TransactionTypeDetermination = 'JIC'
  left outer join     I_OperationalAcctgDocItem as SGST  on  SGST.CompanyCode                  = OADI2.CompanyCode
                                                         and SGST.AccountingDocument           = OADI2.AccountingDocument
                                                         and SGST.FiscalYear                   = OADI2.FiscalYear
                                                         and SGST.TaxItemGroup                 = OADI2.TaxItemGroup
                                                         and SGST.AccountingDocumentItemType   = 'T'
                                                         and SGST.TransactionTypeDetermination = 'JIS'
  left outer join     I_OperationalAcctgDocItem as IGST  on  IGST.CompanyCode                  = OADI2.CompanyCode
                                                         and IGST.AccountingDocument           = OADI2.AccountingDocument
                                                         and IGST.FiscalYear                   = OADI2.FiscalYear
                                                         and IGST.TaxItemGroup                 = OADI2.TaxItemGroup
                                                         and IGST.AccountingDocumentItemType   = 'T'
                                                         and IGST.TransactionTypeDetermination = 'JII'
  left outer join     I_GLAccountText           as GAT   on  GAT.GLAccount       = JEI3.GLAccount
                                                         and GAT.ChartOfAccounts = JEI3.ChartOfAccounts
                                                         and GAT.Language        = $session.system_language
{
  key  '0000000000'                                     as PurchaseOrder,
  key  '00000'                                          as PurchaseOrderItem,
  key  JE.AccountingDocument                            as AccountingDocNo,
  key  '0000000000'                                     as GRN,
  key  '0000'                                           as MaterialDocItem,
  key  '0000'                                           as MatDocYear,
  key  JE.CompanyCode                                   as Companycode,
  key  '0000'                                           as GRNYear,
       JEI3.AccountingDocumentItem,
       JEI3.LedgerGLLineItem,
       cast(JEI2.WBSElementInternalID as abap.char(24)) as WBSELEMENT,
       JEI3.GLAccount                                   as GLCode,
       substring(OADI.OriginalReferenceDocument,1,10)   as SupplierInvoiceNo,
       JE.DocumentReferenceID                           as referencenumber,
       JE.PostingDate                                   as GRNDate,
       JE.PostingDate                                   as Postingdate,
       JE.DocumentDate                                  as Invoicedate,
       JE2.DocumentReferenceID,
       JEI.GLAccount,
       JEI.Supplier                                     as VendorCode,
       SUP.SupplierName                                 as VendorName,
       SUP.Region                                       as VendorStateCode,
       SUP.TaxNumber3                                   as VendorGSTIN,
       SUP.Country                                      as VendorCountry,
       SUP.BusinessPartnerPanNumber                     as VendorPAN,
       JE.DocumentDate                                  as InvDate,
       JE.DocumentDate                                  as DeliveryDate,
       OADI.TransactionCurrency                         as PriceUnit,
       ''                                               as PurchaseType,
       '00000000'                                       as PODate,
       ''                                               as POGroup,
       ''                                               as Hsnno,
       ''                                               as Material,
       ''                                               as MaterialDesc,
       ''                                               as MaterialType,
       ''                                               as MaterialGroup,
       JE.TransactionCurrency                           as Currency,
       ''                                               as PORequisition,
       ''                                               as RequisitionerName,
       cast('0.00' as abap.dec(21,2))                   as Rate,
       cast( JEI3.Quantity as abap.dec( 12, 2 ) )       as ORDQuantity,
       JEI3.Plant                                       as Plant,
       JEI3.TaxCode                                     as TaxCode,
       JEI3.BaseUnit                                    as BaseUnit,
       ''                                               as AAcat,
       ''                                               as POType,
       ''                                               as StorageLocation,
       ''                                               as MovementType,
       JEI3.BaseUnit                                    as EntryUnit,
       cast( JEI3.Quantity as abap.dec( 12, 2 ) )       as GRNQuantity,
       JEI3.BaseUnit                                    as Base,
       JEI3.Quantity                                    as InvoiceQuantity,
       JEI.DebitCreditCode                              as DCCode,
       JEI3.AmountInTransactionCurrency                 as TaxableValue,
       CGST.AmountInTransactionCurrency                 as CGSTAmount,
       SGST.AmountInTransactionCurrency                 as SGSTAmount,
       IGST.AmountInTransactionCurrency                 as IGSTAmount,
       JEI.AmountInTransactionCurrency                  as GrossAmount,
       cast('0.00' as abap.dec(24,9))                   as DiscountValue,
       GAT.GLAccount                                    as GCode,
       GAT.GLAccountName                                as GLName,
       JE2.DocumentReferenceID                          as UTR,
       JE.AccountingDocumentType
}
where
     JE.AccountingDocumentType = 'KR'
  or JE.AccountingDocumentType = 'KG'
  or JE.AccountingDocumentType = 'KA'
