@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo'
@Metadata.ignorePropagatedAnnotations: true
//define root view entity zdemo
//  as select from    I_PurchaseOrderAPI01     as PO
//    left outer join I_PurchaseOrderItemAPI01 as POI on POI.PurchaseOrder = PO.PurchaseOrder
//    left outer join I_ProductText            as PT  on  PT.Product  = POI.Material
//                                                    and PT.Language = 'E'
//    left outer join I_JournalEntryItem       as JEI on  JEI.Ledger           = '0L'
//                                                    and JEI.LedgerGLLineItem = '000002'
////                                                    and JEI.PurchasingDocument = POI.PurchaseOrder
////                                                    and JEI.PurchasingDocumentItem = POI.PurchaseOrderItem
//
//{
//  key  PO.PurchaseOrder,
//  key  POI.PurchaseOrderItem,
//  key JEI.AccountingDocument
//
//}
define root view entity zdemo
  as select distinct from I_PurchaseOrderAPI01                         as PO
    left outer join       I_PurchaseOrderItemAPI01                     as POI  on POI.PurchaseOrder = PO.PurchaseOrder
    left outer join       I_ProductText                                as PT   on  PT.Product  = POI.Material
                                                                               and PT.Language = 'E'
    left outer join       I_MaterialDocumentItem_2                     as MDI  on  MDI.PurchaseOrder     = POI.PurchaseOrder
                                                                               and MDI.PurchaseOrderItem = POI.PurchaseOrderItem
    left outer join I_Supplier                as SUP   on SUP.Supplier = PO.Supplier
  //    left outer join ZMM_GRP_1                      as OADI on OADI.Reference3IDByBusinessPartner = MDI.MaterialDocument
  //                                                           and  OADI.Supplier               = PO.Supplier
  //                                                           and OADI.PurchasingDocument     = MDI.PurchaseOrder
  //                                                           and OADI.PurchasingDocumentItem = MDI.PurchaseOrderItem

//    left outer join       ZMM_TEST                                     as OADI on  OADI.PurchasingDocument     = POI.PurchaseOrder
//                                                                               and OADI.PurchasingDocumentItem = POI.PurchaseOrderItem
//                                                                            //and OADI.Reference3IDByBusinessPartner = MDI.MaterialDocument

   left outer join       I_JournalEntryItem                           as JEI  on      MDI.MaterialDocument = JEI.ReferenceDocument
                                                                               and MDI.MaterialDocumentItem = substring(JEI.ReferenceDocumentItem, 3, 4)
                                                                               and JEI.Ledger               = '0L'
                                                                               and JEI.LedgerGLLineItem     = '000002'

//    left outer join      I_AccountingDocumentJournal(P_Language: 'E') as ADJ  on  JEI.AccountingDocument     = ADJ.InvoiceReference
//                                                                              //and JEI.ClearingAccountingDocument = ADJ.ClearingAccountingDocument
//                                                                               and JEI.Supplier               = ADJ.Supplier
//                                                                               and ADJ.Ledger                 = '0L'
//                                                                               and ADJ.AccountingDocumentType = 'KZ'

    left outer join       I_PurchasingDocumentTypeText                 as PDT  on  PDT.PurchasingDocumentType     = PO.PurchaseOrderType
                                                                               and PDT.PurchasingDocumentCategory = POI.PurchaseOrderCategory
                                                                               and PDT.Language                   = 'E'
    left outer join       I_PurOrdItmPricingElementAPI01               as PIPE on  PIPE.PurchaseOrder     = POI.PurchaseOrder
                                                                               and PIPE.PurchaseOrderItem = POI.PurchaseOrderItem
                                                                               and PIPE.ConditionType     = 'ZDSV'
//    left outer join       I_GLAccountText                              as GAT  on GAT.GLAccount = OADI.GLAccount
    left outer join       I_StorageLocationStdVH                       as SL   on  SL.Plant           = POI.Plant
                                                                               and SL.StorageLocation = POI.StorageLocation

{
  key  PO.PurchaseOrder,
  key  POI.PurchaseOrderItem,
//  key  OADI.AccountingDocument                     as AccountingDocNo,
  key  MDI.MaterialDocument                       as GRN,
  key  MDI.MaterialDocumentItem                   as MaterialDocItem,
  key  MDI.MaterialDocumentYear                   as MatDocYear,

  key  PO.CompanyCode                             as Companycode,
  key  MDI.MaterialDocumentYear                   as GRNYear,
       // OADI.AccountingDocument as OADIAccDoc,
       //  JEI.AccountingDocument                    as AccountingDocNo,
       JEI.AccountingDocumentItem,
       JEI.LedgerGLLineItem,
       //OADI.WBSElement                as WBSElement,
//       cast( OADI.WBSELEMENT as abap.char(24) )   as WBSELEMENT,
//       //OADI
//       GAT.GLAccount                              as GLCode,
//       OADI.OriginalReferenceDocument             as SupplierInvoiceNo,
       //SUP.Supplier  as supinv1,
 //      OADI.PostingDate                           as GRNDate,
       //OADI.GRPostingdate                         as Postingdate,
       PO.PurchaseOrderDate     as  Postingdate,
//       OADI.Invoicedate,
//       OADI.DocumentReferenceID,
//       OADI.GLAccount,
       PO.Supplier                                as VendorCode,
       SUP.SupplierName                          as VendorName,
      // OADI.Region                                as VendorStateCode,
      SUP.Region                 as VendorStateCode,
       SUP.TaxNumber3                            as VendorGSTIN,
       SUP.Country                               as VendorCountry,
       SUP.BusinessPartnerPanNumber              as VendorPAN,
//       OADI.Invoicedate                           as InvDate,
//       OADI.Deliverydate                          as DeliveryDate,
//       OADI.TransactionCurrency                   as PriceUnit,
       PO.PurchaseOrderType                       as PurchaseType,
       PO.PurchaseOrderDate                       as PODate,
       PO.PurchasingGroup                         as POGroup,
       POI.BR_NCM                                 as Hsnno,
       POI.Material                               as Material,
       PT.ProductName                             as MaterialDesc,
       POI.MaterialType                           as MaterialType,
       POI.MaterialGroup                          as MaterialGroup,
       POI.DocumentCurrency                       as Currency,
       POI.PurchaseRequisition                    as PORequisition,
//              @Semantics.amount.currencyCode: 'PriceUnit'
//              POI.NetPriceAmount                         as Rate,
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       POI.OrderQuantity                          as ORDQuantity,
       POI.Plant                                  as Plant,
       POI.TaxCode                                as TaxCode,
       POI.BaseUnit                               as BaseUnit,
       POI.AccountAssignmentCategory              as AAcat,
       PDT.PurchasingDocumentType                 as POType,
       //MDI.StorageLocation            as StorageLocation,
       SL.StorageLocationName                     as StorageLocation,
      // POI.StorageLocation              as StorageLocation,
       MDI.GoodsMovementType                      as MovementType,
       MDI.MaterialBaseUnit                       as EntryUnit
//       @Semantics.quantity.unitOfMeasure: 'EntryUnit'
//       case when MDI.DebitCreditCode = 'H' or OADI.DebitCreditCode = 'H'
//       then MDI.QuantityInBaseUnit * -1 else
//       MDI.QuantityInBaseUnit end                 as GRNQuantity,
//       OADI.BaseUnit                              as Base,
//       @Semantics.quantity.unitOfMeasure: 'Base'
//       case when MDI.DebitCreditCode = 'H' or OADI.DebitCreditCode = 'H'
//       then OADI.Quantity * -1 else
//       OADI.Quantity       end                    as InvoiceQuantity,
//       OADI.DebitCreditCode                       as DCCode,
//       @Semantics.amount.currencyCode: 'PriceUnit'
//       OADI.AmountInTransactionCurrency           as TaxableValue,
//       @Semantics.amount.currencyCode: 'PriceUnit'
//       OADI.TCGST                                 as CGSTAmount,
//       @Semantics.amount.currencyCode: 'PriceUnit'
//       OADI.TCGST                                 as SGSTAmount,
//       @Semantics.amount.currencyCode: 'PriceUnit'
//       OADI.TIGST                                 as IGSTAmount,
//       @Semantics.amount.currencyCode: 'PriceUnit'
//       case when
//       OADI.TransactionTypeDetermination = 'JIC' or OADI.TransactionTypeDetermination = 'JIS'
//       then OADI.TCGST + OADI.TCGST+OADI.AmountInTransactionCurrency
//       when OADI.TransactionTypeDeterminationI = 'JII'
//       then OADI.TIGST + OADI.AmountInTransactionCurrency
//       else OADI.AmountInTransactionCurrency  end as GrossAmount,
//       PIPE.ConditionRateValue                    as DiscountValue,
//       GAT.GLAccount                              as GCode,
//       GAT.GLAccountName                          as GLName,
//       OADI.DocumentReferenceID                   as UTR
       //  Jentry.DocumentReferenceID as utr1
       // OADI.WBSElement                        as WBSElement
       // cast( GALI.WBSElement  as abap.char( 24 ) )as WBSElement
}
//where
//  ADJ.AccountingDocumentType = 'KZ'
