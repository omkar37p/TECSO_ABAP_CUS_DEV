CLASS lhc_zi_sales_order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR salesorder RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR salesorder RESULT result.

    METHODS crtdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR salesorder~crtdata.

ENDCLASS.

CLASS lhc_zi_sales_order IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD crtdata.

    DATA : lt_salesorder TYPE TABLE OF ztab_sales_order,
           ls_salesorder TYPE ztab_sales_order.

    READ ENTITIES OF zi_sales_order IN LOCAL MODE
    ENTITY salesorder
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_header).
    DATA(ls_header) = lt_header[ 1 ].

    ls_salesorder-salesorder = ls_header-Salesorder.
    ls_salesorder-salesorderitem = ls_header-Salesorderitem.
    ls_salesorder-salesorderdate = ls_header-Salesorderdate.
    ls_salesorder-salesorderitemcategory = ls_header-Salesorderitemcategory.
    ls_salesorder-salesorderitemtext = ls_header-Salesorderitemtext.
    ls_salesorder-salesordertype = ls_header-Salesordertype.
    ls_salesorder-salesorganization = ls_header-SalesOrganization.
    ls_salesorder-orderquantity = ls_header-Orderquantity.
    ls_salesorder-orderquantityunit = ls_header-Orderquantityunit.
    ls_salesorder-batch = ls_header-Batch.
    ls_salesorder-billingdocumentdate = ls_header-Billingdocumentdate.
    ls_salesorder-distributionchannel = ls_header-DistributionChannel.
    ls_salesorder-fiscalyear = ls_header-Fiscalyear.
    ls_salesorder-netamount = ls_header-Netamount.
    ls_salesorder-plant = ls_header-Plant.
    ls_salesorder-product = ls_header-Product.
    ls_salesorder-referencesddocument = ls_header-Referencesddocument.
    ls_salesorder-soldtoparty = ls_header-Soldtoparty.

    select * from ztab_sales_order where salesorder is not INITIAL into table @data(lt_sales_order).

    if lt_sales_order is initial.
    ls_salesorder-salesorder = '1000000000'.
    else.
    sort lt_sales_order by salesorder DESCENDING.
    data(ls_sales_order) = lt_sales_order[ 1 ].
    ls_salesorder-salesorder = ls_sales_order-salesorder + 1.
    endif.

     APPEND ls_salesorder TO lt_salesorder.
    zbp_i_sales_order=>gt_salesorder = lt_salesorder.

*    DATA : lt_salesorder TYPE TABLE OF ztab_sales_order,
*           ls_salesorder TYPE ztab_sales_order.
*
*    SELECT * FROM i_salesorder INTO TABLE @DATA(lt_sales_order_head) .
*    SELECT * FROM i_salesorderitem INTO TABLE  @DATA(lt_sales_order_item).
*
*    LOOP AT lt_sales_order_head INTO DATA(ls_header).
*      ls_salesorder-salesorder = ls_header-salesorder.
*      ls_salesorder-salesorderdate = ls_header-salesorderdate.
*      ls_salesorder-salesordertype = ls_header-salesordertype.
*      ls_salesorder-salesorganization = ls_header-salesorganization.
*      ls_salesorder-billingdocumentdate = ls_header-billingdocumentdate.
*      ls_salesorder-distributionchannel = ls_header-distributionchannel.
*      ls_salesorder-fiscalyear = ls_header-fiscalyear.
*      ls_salesorder-referencesddocument = ls_header-referencesddocument.
*      ls_salesorder-soldtoparty = ls_header-soldtoparty.
*    ENDLOOP.
*
*    LOOP AT lt_sales_order_item INTO DATA(ls_item).
*      ls_salesorder-salesorderitem = ls_item-salesorderitem.
*      ls_salesorder-salesorderitemcategory = ls_item-salesorderitemcategory.
*      ls_salesorder-salesorderitemtext = ls_item-salesorderitemtext.
*      ls_salesorder-orderquantity = ls_item-orderquantity.
*      ls_salesorder-orderquantityunit = ls_item-orderquantityunit.
*      ls_salesorder-batch = ls_item-batch.
*      ls_salesorder-netamount = ls_item-netamount.
*      ls_salesorder-plant = ls_item-plant.
*      ls_salesorder-product = ls_item-product.
*    ENDLOOP.
*
*    APPEND ls_salesorder TO lt_salesorder.
*    zbp_i_sales_order=>gt_salesorder = lt_salesorder.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_sales_order DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_sales_order IMPLEMENTATION.

  METHOD save_modified.
   IF create-salesorder IS NOT INITIAL.
      IF zbp_i_sales_order=>gt_salesorder IS NOT INITIAL.
        DATA(lt_bdgcode) = zbp_i_sales_order=>gt_salesorder.
        MODIFY ztab_sales_order FROM TABLE @lt_bdgcode.
      ENDIF.
    ENDIF.
**********************************************************************
    IF delete-salesorder IS NOT INITIAL.
      LOOP AT delete-salesorder INTO DATA(ls_sales).
*       DELETE FROM ztab_sales_order WHERE salesorder = @ls_sales-Salesorder AND salesorderitem = @ls_sales-Salesorderitem.
        SELECT SINGLE * FROM ztab_sales_order WHERE salesorder = @ls_sales-Salesorder AND salesorderitem = @ls_sales-Salesorderitem
        INTO @DATA(ls_delrecd).
        MODIFY ztab_sales_order FROM  @ls_delrecd.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
