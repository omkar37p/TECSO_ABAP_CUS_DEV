@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Root Entity View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPR_GRNINVOICE_REPORT
  as select from    ZPO_VALUE_2Report      as PO
    left outer join ZPR_VALUE_1Report      as PR       on PR.PurchaseRequisition = PO.PurchaseRequisition
    left outer join ZGRN_VALUE_3Report     as GRN      on GRN.PurchaseOrder = PO.PurchaseOrder
    left outer join ZInvoice_VALUE_4Report as INVS     on  INVS.PurchaseOrder   = PO.PurchaseOrder
                                                       and INVS.DebitCreditCode = 'S'
    left outer join ZInvoice_VALUE_4Report as INVH     on  INVH.PurchaseOrder   = PO.PurchaseOrder
                                                       and INVH.DebitCreditCode = 'H'
    left outer join ZPO_FIINVVALUE_6       as FI       on FI.PurchasingDocument = PO.PurchaseOrder
    left outer join ZINV_CLEARING7         as FICLRDOC on FICLRDOC.PurchasingDocument = PO.PurchaseOrder
    left outer join ZWBS_ELEMENT8          as wb       on wb.PurchaseOrder = PO.PurchaseOrder
    left outer join ZINV_TAXMIRO10         as INVT     on INVT.PurchaseOrder = PO.PurchaseOrder
    left outer join ZINV_PAYMENT11         as PAYMT    on PAYMT.PurchasingDocument = PO.PurchaseOrder
{
  key PO.PurchaseOrder,
  key PO.PurchaseRequisition,
      PO.CURR,
      @Semantics.amount.currencyCode: 'curr'
      PR.PRAMOUNT,
      @Semantics.amount.currencyCode: 'curr'
      PO.POAMOUNT,
      @Semantics.amount.currencyCode: 'curr'
      GRN.GRNVALUE,
      @Semantics.amount.currencyCode: 'curr'
      coalesce(cast(INVS.INVAMOUNT as abap.dec( 21 , 2 )) , 0 ) - coalesce(cast(INVH.INVAMOUNT as abap.dec( 21 , 2 )), 0) + coalesce(cast(INVT.INVTAXAMOUNT as abap.dec( 21 , 2 )), 0)         as INVAMT,
      @Semantics.amount.currencyCode: 'curr'
      FI.FIDOCAMNT,

      //      @Semantics.amount.currencyCode: 'curr'
      //      FICLRDOC.CLEARINGAMOUNT,
      //      @Semantics.amount.currencyCode: 'CURR'
      //      PAYMT.PAYMENTAMOUNT,
      //      @Semantics.amount.currencyCode: 'curr'
      //      coalesce(cast(FI.FIDOCAMNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )), 0)                                                                as BALANCECLEARINGAMT,
      //      @Semantics.amount.currencyCode: 'curr'
      //      coalesce(cast(FI.FIDOCAMNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(PAYMT.PAYMENTAMOUNT as abap.dec( 21 , 2 )), 0) + coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )), 0) as BALANCEPAYMENTAMT,

      @Semantics.amount.currencyCode: 'curr'
      case when coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(PAYMT.PAYMENTAMOUNT as abap.dec( 21 , 2 )), 0) = cast( FI.FIDOCAMNT * -1 as abap.dec( 21 , 2 ))
                then coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(PAYMT.PAYMENTAMOUNT as abap.dec( 21 , 2 )), 0)
      else null end                                                                                                                                                                            as CLEARINGAMOUNT,
      @Semantics.amount.currencyCode: 'CURR'
      coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(PAYMT.PAYMENTAMOUNT as abap.dec( 21 , 2 )), 0)                                                         as PAYMENTAMOUNT,
      @Semantics.amount.currencyCode: 'curr'
      coalesce(cast(FI.FIDOCAMNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(PAYMT.PAYMENTAMOUNT as abap.dec( 21 , 2 )), 0) + coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )), 0) as BALANCECLEARINGAMT,
      @Semantics.amount.currencyCode: 'curr'
      coalesce(cast(FI.FIDOCAMNT as abap.dec( 21 , 2 )) , 0) + coalesce(cast(PAYMT.PAYMENTAMOUNT as abap.dec( 21 , 2 )), 0) + coalesce(cast(FICLRDOC.CLEARINGAMOUNT as abap.dec( 21 , 2 )), 0) as BALANCEPAYMENTAMT,
      wb.ProjectElement                                                                                                                                                                        as WBSELEMENT
}
