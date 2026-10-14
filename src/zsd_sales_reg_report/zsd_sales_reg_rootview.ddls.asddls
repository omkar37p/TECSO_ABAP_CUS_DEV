@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity Sales register Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_Sales_Reg_Rootview

  as select from    I_BillingDocument              as bdo
    inner join      I_BillingDocumentItem          as bdi           on bdi.BillingDocument = bdo.BillingDocument
  //left outer join I_BillingDocumentPartner as            bdp  on bdp.BillingDocument = bdo.BillingDocument
    left outer join I_SalesOrder                   as so            on so.SalesOrder = bdi.SalesDocument
    left outer join I_DeliveryDocument             as dl            on dl.DeliveryDocument = bdi.ReferenceSDDocument
    left outer join I_BillingDocumentItemPrcgElmnt as bdp           on  bdp.BillingDocument     = bdi.BillingDocument
                                                                    and bdp.BillingDocumentItem = bdi.BillingDocumentItem
                                                                    and bdp.ConditionType       = 'JOSG'
    left outer join I_BillingDocumentItemPrcgElmnt as bdp1          on  bdp1.BillingDocument     = bdi.BillingDocument
                                                                    and bdp1.BillingDocumentItem = bdi.BillingDocumentItem
                                                                    and bdp1.ConditionType       = 'JOCG'
    left outer join I_BillingDocumentItemPrcgElmnt as bdp2          on  bdp2.BillingDocument     = bdi.BillingDocument
                                                                    and bdp2.BillingDocumentItem = bdi.BillingDocumentItem
                                                                    and bdp2.ConditionType       = 'JOIG'
  //// left outer join I_BillingDocumentItemPrcgElmnt     as NET      on  NET.BillingDocument     = bdi.BillingDocument
  ////                                                               and NET.BillingDocumentItem = bdi.BillingDocumentItem
  ////                                                               and NET.ConditionType       = 'ZPRO'

    left outer join I_BillingDocumentPartner       as bp            on  bp.BillingDocument = bdo.BillingDocument
                                                                    and bp.PartnerFunction = 'AG'
    left outer join I_BillingDocItemPartner        as bpi           on  bpi.BillingDocument     = bdi.BillingDocument
                                                                    and bpi.BillingDocumentItem = bdi.BillingDocumentItem

    left outer join I_Customer                     as cus           on cus.Customer = so.SoldToParty
    left outer join I_Address_2                    as adr           on adr.AddressID = bp.AddressID
    left outer join I_Address_2                    as adr1          on adr1.AddressID = bpi.AddressID

    left outer join I_BusinessPartner              as bpr           on bpr.BusinessPartner = bp.Customer
  //left outer join I_BusinessPartner                   as bpr1        on bpr1.BusinessPartner = bpi.Customer
    left outer join I_IN_ElectronicDocTransptRegn  as edt           on edt.ElectronicDocSourceKey = bdo.BillingDocument
  //////left outer join I_BillingDocumentItemCube(P_ExchangeRateType: 'M', P_DisplayCurrency: 'INR' ) as BDoc     on  BDoc.BillingDocument     = bdi.BillingDocument
  //////                                                                                                        // and  BDoc.BillingDocumentItem = bdi.BillingDocumentItem
    left outer join ZSD_JE_ITEM                    as gla           on  gla.AccountingDocument    = bdo.AccountingDocument
                                                                    and gla.ReferenceDocument     = bdo.BillingDocument
                                                                    and gla.ReferenceDocumentItem = bdi.BillingDocumentItem

  ////right outer join ZSD_JE_ITEM                 as gla      on gla.ReferenceDocument    = bdo.BillingDocument
  ////                                                               and gla.item = bdi.BillingDocumentItem
  ////                                                             // and gla.ReferenceDocumentItem = left outerjoin'00left outerleft outer0001'== '000010'
  ////                                                              and gla.AccountingDocument = bdo.AccountingDocument
  ////                                                            //  and gla.Ledger                = '0L'
  ////                                                          //    and gla.SourceLedger          = '0L'
  ////                                                          //    and gla.GLAccountType         = 'P'
  ////                                                            //  and gla.BusinessTransactionType = 'SD00'
  ////                                                             // and gla.LedgerGLLineItem      = '000004'
  ////                                                              and gla.LedgerGLLineItem      = '000002'
  ////                                                           //  and gla.BillingDocumentType = 'F2'
  ////                                                            // and gla.AccountingDocumentType = 'RV'
  ////
  ////                                                           //  and gla.CompanyCode           = bdo.CompanyCode
  ////                                                           //  and gla.FiscalYear            = bdo.FiscalYear

  ////////left outer join I_AccountingDocumentJournal( P_Language: 'e' )   as gla    on gla.AccountingDocument = bdo.AccountingDocument
  ////////                                                                          and gla.ReferenceDocument = bdi.BillingDocument
  ////////                                                                          and gla.ReferenceDocumentItem = bdi.BillingDocumentItem
  ////////                                                                          and gla.Ledger                = '0L'
  ////////                                                                          and gla.SourceLedger          = '0L'
  ////////                                                                          and gla.GLAccountType         = 'P'
  ////////                                                                          // and gla.AccountingDocumentType = 'RV'

  //////  left outer join I_JournalEntryItem                     as gla      on  gla.ReferenceDocument     = BDoc.BillingDocument
  //////                                                                     and gla.AccountingDocument    = BDoc.AccountingDocument
  //////                                                                //   and gla.CompanyCode           = BDoc.CompanyCode
  //////                                                                //   and gla.FiscalYear            = BDoc.FiscalYear
  //////                                                                   and gla.Ledger                = '0L'
  //////                                                                   and gla.SourceLedger          = '0L'
  //////    //                                                                                                           and gla.FunctionalArea        = 'YB10 '
  //////    //                                                                                                           and gla.JournalEntryItemCategory = '30000'
  //////                                                                    and gla.GLAccountType         = 'P'
  //////                                                                    and gla.LedgerGLLineItem      = '000002'
  //////
  //////    //                                                                                                          and gla.FinancialAccountType = 'S'
  //////    //
  //////
  //////                                                                  //  and gla.ReferenceDocumentItem = BDoc.BillingDocumentItem

    left outer join I_GLAccountText                as Glx           on  Glx.GLAccount = gla.GLAccount
                                                                    and Glx.Language  = 'E'
  //left outer join  I_WBSELEMENT           as wbs        on wbs.WBSElementInternalID = bdi.WBSElementInternalID
    left outer join I_IN_PlantBusinessPlaceDetail  as businessplace on  bdi.Plant       = businessplace.Plant
                                                                    and bdi.CompanyCode = businessplace.CompanyCode
    left outer join I_IN_BusinessPlaceTaxDetail    as bpt           on bpt.BusinessPlace = businessplace.BusinessPlace

{
  key bdo.BillingDocument                                                                        as VoucherNo,
  key bdi.BillingDocumentItem                                                                    as BillingDocumentItem,
  key bdi.CompanyCode                                                                            as CompanyCode,
  key bdo.BillingDocumentDate                                                                    as dt,
      bpr.BusinessPartnerFullName                                                                as Particulars,
      bpr.BusinessPartnerFullName                                                                as Buyer,

      adr.PostalCode,
      adr.HouseNumber,
      adr.CityName,
      cast( adr.Street as abap.char( 80 ) )                                                      as Street,
      adr.StreetPrefixName1,
      adr.StreetPrefixName2,
      adr.StreetSuffixName1,
      adr.StreetSuffixName2,

      concat(concat(adr.StreetName, concat(', ', adr.PostalCode)),concat(', ', adr.CityName))    as BuyerAddress,


      adr1.OrganizationName1                                                                     as Consignee,

      concat(concat(adr1.StreetName, concat(', ', adr1.PostalCode)),concat(', ', adr1.CityName)) as ConsigneeAddress,

      //adr.AddressObjectType                       as ConsigneeAddress,
      bpi.ReferenceBusinessPartner                                                               as ConsigneeCode,
      bdo.BillingDocumentType                                                                    as VoucherType,
      // so.PurchaseOrderByCustomer                  as VoucherRefNo,
      so.SalesOrder                                                                              as SalesOrderNo,
      so.SalesOrderDate                                                                          as SalesOrderDate,
      bdo.CustomerPaymentTerms                                                                   as TermsofPayment,
      bdo.IncotermsClassification                                                                as TermsofDelivery,
      dl.DeliveryDocument                                                                        as Deliveryno,
      dl.DeliveryDate                                                                            as DeliveryDate,
      so.PurchaseOrderByCustomer                                                                 as VoucherRefNo,
      bdi.ReferenceSDDocument                                                                    as DespatchDocNo,
      adr.Region                                                                                 as Destination,
      cus.TaxNumber3                                                                             as GSTINUIN,
      bdo.SoldToParty                                                                            as CustomerCode,
      bdo.DocumentReferenceID                                                                    as InvoiceNo,
      edt.IN_EDocVehicleNumber                                                                   as VehicleNo,
      bdo.BillingDocumentIsCancelled                                                             as BillingDOCCancel,
      bdo.CancelledBillingDocument                                                               as CancelBillingDOC,
      //  gla.AccountingDocument                      as acccc,
      gla.GLAccount                                                                              as GLAccount,
      Glx.GLAccountName                                                                          as GLName,
      gla.AccountingDocumentType                                                                 as Accdoc,
      bdi.Product                                                                                as MaterialNumber,
      // bdi.WBSElement                              as WBSElement,
      cast( bdi.WBSElementInternalID as abap.char( 24 ) )                                        as WBSElement1,
      bdi.BillingQuantityUnit                                                                    as qty,
      @Semantics.quantity.unitOfMeasure: 'qty'
      case
      when bdi.BillingQuantityInBaseUnit is not initial
      then cast( get_numeric_value( bdi.BillingQuantityInBaseUnit ) as abap.dec(12,2) )
      //  then cast( bdi.BillingQuantityInBaseUnit as abap.dec( 8, 3 ) )
      else null end                                                                              as Quantity,
      bdi.TransactionCurrency                                                                    as amt,
      @Semantics.amount.currencyCode: 'amt'
      cast( bdi.NetAmount as abap.dec( 21, 2 ) )                                                 as NetAmount,
      @Semantics.amount.currencyCode: 'amt'
      cast( bdi.TaxAmount as abap.dec( 21, 2 ) )                                                 as TaxAmount,
      @Semantics.amount.currencyCode: 'amt'
      cast( bdi.NetAmount + bdi.TaxAmount as abap.dec( 21, 2 ) )                                 as TotalAmount,

      bdp.TransactionCurrency                                                                    as amt1,
      bdp.ConditionRateValue                                                                     as SGSTRate,
      @Semantics.amount.currencyCode: 'amt1'
      bdp.ConditionAmount                                                                        as Josg,
      bdp1.ConditionRateValue                                                                    as CGSTRate,
      //  case
      //   when bdp1.ConditionRateValue   is not null
      //   then cast (get_numeric_value(bdp1.ConditionRateValue)as abap.dec( 24,2 ))
      //   end                                       as CGSTRate,
      bdp1.TransactionCurrency                                                                   as amt2,
      @Semantics.amount.currencyCode: 'amt2'
      bdp1.ConditionAmount                                                                       as Jocg,
      //// case
      ////   when bdp2.ConditionRateValue is not null
      ////   then cast( get_numeric_value(bdp2.ConditionRateValue) as abap.dec(24,2) )
      ////end as IGSTRate,
      bdp2.ConditionRateValue                                                                    as IGSTRate,
      bdp2.TransactionCurrency                                                                   as amt3,
      @Semantics.amount.currencyCode: 'amt3'
      bdp2.ConditionAmount                                                                       as Joig,

      ////   @Semantics.amount.currencyCode: 'amt'
      ////   case
      ////   when get_numeric_value(NET.ConditionBaseQuantity) = 0 then 0
      ////     else cast(
      ////       (
      ////         get_numeric_value(NET.ConditionAmount) /
      ////         get_numeric_value(NET.ConditionBaseQuantity)
      ////       ) as abap.dec(24,2)
      ////       )
      ////      end                                     as perrate

      @Semantics.amount.currencyCode: 'amt'
      case
      when get_numeric_value(bdi.BillingQuantityInBaseUnit) = 0 then 0
        else cast(
          (
            get_numeric_value(bdi.NetAmount) /
            get_numeric_value(bdi.BillingQuantityInBaseUnit)
          ) as abap.dec(24,2)
          )
         end                                                                                     as perrate,
      bpt.BusinessPlaceDescription                                                               as BusinessPlacedes,
      businessplace.BusinessPlace                                                                as BusinessPlace




}



//Added Union All on 26.11.2025 to include Direct Posting of Customer Invoices that is not related to any Sales Order
union all select from I_JournalEntry            as JE
  inner join          I_JournalEntryItem        as JEI   on  JEI.CompanyCode          =  JE.CompanyCode
                                                         and JEI.AccountingDocument   =  JE.AccountingDocument
                                                         and JEI.FiscalYear           =  JE.FiscalYear
                                                         and JEI.Ledger               =  '0L'
                                                         and JEI.FinancialAccountType =  'D'
                                                         and JEI.Customer             is not initial
                                                         and JEI.IsReversal           <> 'X'
                                                         and JEI.IsReversed           <> 'X'
  left outer join     I_JournalEntryItem        as JEI2  on  JEI2.CompanyCode        = JE.CompanyCode
                                                         and JEI2.AccountingDocument = JE.AccountingDocument
                                                         and JEI2.FiscalYear         = JE.FiscalYear
                                                         and JEI2.Ledger             = '0L'
                                                         and JEI2.GLAccountType      = 'P'
  left outer join     I_BusinessPartner         as BP    on BP.BusinessPartner = JEI.Customer
  left outer join     I_Customer                as CUS   on CUS.Customer = JEI.Customer
  left outer join     I_Address_2               as ADRS  on ADRS.AddressID = CUS.AddressID
  left outer join     I_GLAccountText           as GLT   on  GLT.GLAccount       = JEI2.GLAccount
                                                         and GLT.ChartOfAccounts = JEI2.ChartOfAccounts
                                                         and GLT.Language        = 'E'
  left outer join     I_OperationalAcctgDocItem as OADI  on  OADI.CompanyCode            = JEI.CompanyCode
                                                         and OADI.AccountingDocument     = JEI.AccountingDocument
                                                         and OADI.FiscalYear             = JEI.FiscalYear
                                                         and OADI.AccountingDocumentItem = JEI.AccountingDocumentItem
  left outer join     I_OperationalAcctgDocItem as OADI2 on  OADI2.CompanyCode            = JEI2.CompanyCode
                                                         and OADI2.AccountingDocument     = JEI2.AccountingDocument
                                                         and OADI2.FiscalYear             = JEI2.FiscalYear
                                                         and OADI2.AccountingDocumentItem = JEI2.AccountingDocumentItem
  left outer join     I_OperationalAcctgDocItem as CGST  on  CGST.CompanyCode                  = OADI2.CompanyCode
                                                         and CGST.AccountingDocument           = OADI2.AccountingDocument
                                                         and CGST.FiscalYear                   = OADI2.FiscalYear
                                                         and CGST.TaxItemGroup                 = OADI2.TaxItemGroup
                                                         and CGST.AccountingDocumentItemType   = 'T'
                                                         and CGST.TransactionTypeDetermination = 'JOC'
  left outer join     I_OperationalAcctgDocItem as SGST  on  SGST.CompanyCode                  = OADI2.CompanyCode
                                                         and SGST.AccountingDocument           = OADI2.AccountingDocument
                                                         and SGST.FiscalYear                   = OADI2.FiscalYear
                                                         and SGST.TaxItemGroup                 = OADI2.TaxItemGroup
                                                         and SGST.AccountingDocumentItemType   = 'T'
                                                         and SGST.TransactionTypeDetermination = 'JOS'
  left outer join     I_OperationalAcctgDocItem as IGST  on  IGST.CompanyCode                  = OADI2.CompanyCode
                                                         and IGST.AccountingDocument           = OADI2.AccountingDocument
                                                         and IGST.FiscalYear                   = OADI2.FiscalYear
                                                         and IGST.TaxItemGroup                 = OADI2.TaxItemGroup
                                                         and IGST.AccountingDocumentItemType   = 'T'
                                                         and IGST.TransactionTypeDetermination = 'JOI'
{
      //  key '0000000000'                                                                                                         as VoucherNo,
      //  key '000000'                                                                                                             as BillingDocumentItem,
  key JEI2.AccountingDocument                                                                                        as VoucherNo,
  key cast ( JEI2.AccountingDocumentItem as abap.char( 6 ) )                                                         as BillingDocumentItem,
  key JEI2.CompanyCode                                                                                               as CompanyCode,
  key JE.PostingDate                                                                                                 as dt,
      BP.BusinessPartnerFullName                                                                                     as Particulars,
      BP.BusinessPartnerFullName                                                                                     as Buyer,
      ADRS.PostalCode                                                                                                as Postalcode,
      ADRS.HouseNumber                                                                                               as HouseNumber,
      ADRS.CityName                                                                                                  as CityName,
      ADRS.StreetName                                                                                                as Street,
      ADRS.StreetPrefixName1                                                                                         as StreetPrefixName1,
      ADRS.StreetPrefixName2                                                                                         as StreetPrefixName2,
      ADRS.StreetSuffixName1                                                                                         as StreetSuffixName1,
      ADRS.StreetSuffixName2                                                                                         as StreetSuffixName2,
      concat(concat(ADRS.StreetName, concat(', ', ADRS.PostalCode)),concat(', ', ADRS.CityName))                     as BuyerAddress,
      ''                                                                                                             as Consignee,
      concat(concat('', concat(', ', '')),concat(', ', ''))                                                          as ConsigneeAddress,
      '000000000'                                                                                                    as ConsigneeCode,
      ''                                                                                                             as VoucherType,
      ''                                                                                                             as SalesOrderNo,
      '00000000'                                                                                                     as SalesOrderDate,
      OADI.PaymentTerms                                                                                              as TermsofPayment,
      ''                                                                                                             as TermsofDelivery,
      '000000000'                                                                                                    as Deliveryno,
      '00000000'                                                                                                     as DeliveryDate,
      ''                                                                                                             as VoucherRefNo,
      '000000000'                                                                                                    as DespatchDocNo,
      ADRS.Region                                                                                                    as Destination,
      CUS.TaxNumber3                                                                                                 as GSTINUIN,
      CUS.Customer                                                                                                   as CustomerCode,
      ''                                                                                                             as InvoiceNo,
      ''                                                                                                             as VehicleNo,
      ''                                                                                                             as BillingDOCCancel,
      '0000000000'                                                                                                   as CancelBillingDOC,
      JEI2.GLAccount                                                                                                 as GLAccount,
      GLT.GLAccountName                                                                                              as GLName,
      JE.AccountingDocumentType                                                                                      as Accdoc,
      JEI2.Product                                                                                                   as MaterialNumber,
      cast ( ' '  as abap.char( 24 )   )                                                                             as WBSElement1,
      JEI2.BaseUnit                                                                                                  as qty,
      cast( JEI2.Quantity as abap.dec( 12, 2 ) )                                                                     as Quantity,
      JEI2.TransactionCurrency                                                                                       as amt,
      cast( JEI2.AmountInTransactionCurrency  as abap.dec( 21, 2 ) )                                                 as NetAmount,
      case when IGST.AmountInTransactionCurrency is not initial then cast( IGST.AmountInTransactionCurrency as abap.dec( 21, 2 ) )
           else cast( CGST.AmountInTransactionCurrency + SGST.AmountInTransactionCurrency as abap.dec( 21, 2 ) ) end as TaxAmount,
      cast( coalesce( cast( JEI2.AmountInTransactionCurrency as abap.dec( 21, 2 ) ), 0 ) +
            coalesce( cast( IGST.AmountInTransactionCurrency as abap.dec( 21, 2 ) ), 0 ) +
            coalesce( cast( CGST.AmountInTransactionCurrency as abap.dec( 21, 2 ) ), 0 ) +
            coalesce( cast( SGST.AmountInTransactionCurrency as abap.dec( 21, 2 ) ), 0 ) as abap.dec( 21, 2 ) )      as TotalAmount,

      JEI2.TransactionCurrency                                                                                       as amt1,
      cast ('0.00' as abap.dec( 24,9 ) )                                                                             as SGSTRate,
      cast ('0.00' as abap.curr( 15,2 ) )                                                                            as Josg,
      cast ('0.00' as abap.dec( 24,9 ) )                                                                             as CGSTRate,
      JEI.TransactionCurrency                                                                                        as amt2,
      cast ('0.00' as abap.curr( 15,2 ) )                                                                            as Jocg,
      cast ('0.00' as abap.dec( 24,9 ) )                                                                             as IGSTRate,
      JEI.TransactionCurrency                                                                                        as amt3,
      cast ('0.00' as abap.curr( 15,2 ) )                                                                            as Joig,
      case
      when get_numeric_value(JEI2.Quantity) = 0 then 0
        else cast(
          (
             get_numeric_value(JEI2.AmountInTransactionCurrency) /
            get_numeric_value(JEI2.Quantity)
          ) as abap.dec(24,2)
          )
         end                                                                                                         as perrate,
      ''                                                                                                             as BusinessPlacedes,
      ''                                                                                                             as BusinessPlace
}
where
     JE.AccountingDocumentType = 'DR'
  or JE.AccountingDocumentType = 'DG'
  or JE.AccountingDocumentType = 'DA'
