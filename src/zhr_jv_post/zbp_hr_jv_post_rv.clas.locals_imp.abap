CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS gatestatus FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gatestatus RESULT result.

    METHODS getheader FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~getheader.

     METHODS validatemonth FOR VALIDATE ON SAVE
      IMPORTING keys FOR _hDR~validatemonth.

    METHODS Company FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zhr_jv_post1_rv~Company.

    METHODS checkCompany FOR VALIDATE ON SAVE
      IMPORTING keys FOR zhr_jv_post1_rv~checkCompany.
    METHODS updateitem FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZHR_JV_POST1_RV~updateitem.
    METHODS Payroll FOR MODIFY
      IMPORTING keys FOR ACTION _hDR~Payroll RESULT result.
    METHODS Accdoc FOR MODIFY
      IMPORTING keys FOR ACTION _hDR~Accdoc RESULT result.


ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD gatestatus.
  ENDMETHOD.

  METHOD getheader.

    DATA : gt_hdrdata TYPE TABLE of zhr_jv_post,
           gs_hdrdata TYPE zhr_jv_post.

**********************************************************************
    READ ENTITIES OF zhr_jv_post_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_header).
     DATA(gs_header) = gt_header[ 1 ].

     if gs_header-Zmonth is not INITIAL and gs_header-Zyears is NOT INITIAL.

        MOVE-CORRESPONDING gs_header to gs_hdrdata.
        gs_hdrdata-jvname = 'Payroll JV'.
       gs_hdrdata-zmonth =  to_upper( gs_hdrdata-zmonth ).
        APPEND gs_hdrdata to gt_hdrdata.
        zbp_hr_jv_post_rv=>gt_hdr = gt_hdrdata.
    ENDIF.

***************************************************************************


  ENDMETHOD.

  METHOD validatemonth.
    READ entity IN LOCAL MODE zhr_jv_post_rv
    FIELDS ( Zmonth )
    WITH CORRESPONDING #( keys )
    RESULT DATA(gt_month).
    data(gs_mon) = gt_month[ 1 ].
    data : gs_mont type zhr_jv_post-zmonth,
           gs_year type zhr_jv_post-zyears.

    gs_mont  = to_upper( gt_month[ 1 ]-Zmonth ).
     gs_year   = to_upper( gt_month[ 1 ]-Zyears ).


        SELECT
            FROM ZHR_JV_POST
                FIELDS uuid
                WHERE zmonth = @gs_mont
                and zyears = @gs_year
                INTO TABLE @DATA(gt_mon).

                if gt_mon is not INITIAL.
                   APPEND VALUE #( %tky = gs_mon-%tky )
                        TO failed-_hdr.
                    APPEND VALUE #( %tky = gs_mon-%tky
                                    %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                    text = 'Month is already exits' && gs_mon-Zmonth )
                                    %element-zmonth = if_abap_behv=>mk-on )
                        TO reported-_hdr.
                else.
                endif.



  ENDMETHOD.


  METHOD company.
*

  ENDMETHOD.

  METHOD checkcompany.

  ENDMETHOD.

  METHOD updateitem.

    DATA : gt_update TYPE TABLE of zhr_jv_post1,
           gs_update TYPE zhr_jv_post1.

**********************************************************************
    READ ENTITIES OF zhr_jv_post_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_header)
    ENTITY _hDR by \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_item).

**********************************************************************
    LOOP at gt_item INTO DATA(gs_item).
        MOVE-CORRESPONDING gs_item to gs_update.
        APPEND gs_update to gt_update.
    ENDLOOP.
        zbp_hr_jv_post_rv=>gt_upitem = gt_update.
**********************************************************************

  ENDMETHOD.

  METHOD Payroll.
**********************************************************************
    READ ENTITIES OF zhr_jv_post_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_header).
    data(comy) = gt_header[ 1 ]-Companycode.
    data(uuid) = gt_header[ 1 ]-Uuid.
    DATA: lv_request_url      TYPE string,
          lo_http_destination TYPE REF TO if_http_destination,
          lo_http_client      TYPE REF TO if_web_http_client,
          lo_http_request     TYPE REF TO if_web_http_request,
          lo_http_response    TYPE REF TO if_web_http_response,
          lv_response         TYPE string,
          lv_payload          TYPE string.
           data: it_upitem TYPE TABLE of zhr_jv_post1,
                 wa_upitem type zhr_jv_post1.
**********************************************************************

**********************************************************************
    lv_request_url = |https://openapi.hrone.cloud/api/external/Integration/JV/Report/Download| .
**********************************************************************
    TRY.
        " Create destination and client
        lo_http_destination = cl_http_destination_provider=>create_by_url( lv_request_url ).
        lo_http_client      = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ).
        lo_http_request     = lo_http_client->get_http_request( ).

**********************************************************************

       data(lv_payload1) = '{"jvName":"Payroll JV","companyName":"","designationName":"","gradeName":"","departmentName":"","subDepartmentName":"","levelName":"","regionName":"","branchName":"","subBranchName":""'.
      data(lv12) = ',"employeeTypeName":"","employeeStatusName":"","businessUnitName":"",'.
      data(lv_payload2) =   |"employeeOtherStatusName":"","month":"{ gt_header[ 1 ]-Zmonth }","year":"{ gt_header[ 1 ]-Zyears }"|.
       lv_payload = lv_payload1 && lv12 && lv_payload2 && ',"formatType":"VIEW" } '.
**********************************************************************


        lo_http_client->get_http_request( )->set_header_fields( VALUE #( ( name = if_web_http_header=>accept value = if_web_http_header=>accept_application_json )
                                                                        ( name = if_web_http_header=>content_type value = if_web_http_header=>accept_application_json  )
                                                                       (  name = 'API-Key' value = '67efeb8f70360435702f1738c931cd37791dcfe4e6cc7ba735b4462888dc66f9' )
                                                                       ( name = 'domaincode' value = 'tecso' )
                                                                         ) ).

        lo_http_client->get_http_request(  )->set_text( i_text = lv_payload ).

**********************************************************************

        lo_http_response = lo_http_client->execute( if_web_http_client=>post ).

        DATA(ls_status1) = lo_http_response->get_status(  ).

        lv_response = lo_http_response->get_text(  ).
        REPLACE ALL OCCURRENCES OF '"Company"'                        IN lv_response WITH '"company"'.
REPLACE ALL OCCURRENCES OF '"GL Code"'                        IN lv_response WITH '"glcode"'.
REPLACE ALL OCCURRENCES OF '"Debit"'                          IN lv_response WITH '"debit"'.
REPLACE ALL OCCURRENCES OF '"Credit"'                         IN lv_response WITH '"credit"'.
REPLACE ALL OCCURRENCES OF '"Cost Centre"'                    IN lv_response WITH '"cost_centre"'.
REPLACE ALL OCCURRENCES OF '"Journal Entry Type (2)"'         IN lv_response WITH '"journal_entry_type_2"'.
REPLACE ALL OCCURRENCES OF '"Ledger Group"'                   IN lv_response WITH '"ledger_group"'.
REPLACE ALL OCCURRENCES OF '"Journal Entry Date"'             IN lv_response WITH '"journal_entry_date"'.
REPLACE ALL OCCURRENCES OF '"Posting Date"'                   IN lv_response WITH '"posting_date"'.
REPLACE ALL OCCURRENCES OF '"Fiscal Period (2)"'              IN lv_response WITH '"fiscal_period_2"'.
REPLACE ALL OCCURRENCES OF '"Document Header Text (25)"'      IN lv_response WITH '"document_header_text_25"'.
REPLACE ALL OCCURRENCES OF '"Transaction Currency (5)"'       IN lv_response WITH '"transaction_currency_5"'.
REPLACE ALL OCCURRENCES OF '"Currency Translation Date"'      IN lv_response WITH '"currency_translation_date"'.
REPLACE ALL OCCURRENCES OF '"Reference Document Number (16)"' IN lv_response WITH '"reference_document_number_16"'.
REPLACE ALL OCCURRENCES OF '"Partner Business Area (4)"'      IN lv_response WITH '"partner_business_area_4"'.
REPLACE ALL OCCURRENCES OF '"Tax Fulfillment Date"'           IN lv_response WITH '"tax_fulfillment_date"'.
REPLACE ALL OCCURRENCES OF '"Calculate Tax Automatically (1)"' IN lv_response WITH '"calculate_tax_automatically_1"'.
REPLACE ALL OCCURRENCES OF '"Company Name"'                   IN lv_response WITH '"company_name"'.
REPLACE ALL OCCURRENCES OF '"Cost Centre Name"'               IN lv_response WITH '"cost_centre_name"'.

**********************************************************************


  TYPES: BEGIN OF ty_journal_entry,
         company                      TYPE c LENGTH 4,
         glcode                      TYPE c LENGTH 8,
         debit                        TYPE p LENGTH 16 DECIMALS 2,
         credit                       TYPE p LENGTH 16 DECIMALS 2,
         cost_centre                  TYPE c LENGTH 20,
         journal_entry_type_2         TYPE c LENGTH 5,
         ledger_group                 TYPE c LENGTH 10,
         journal_entry_date           TYPE string,
         posting_date                 TYPE string,
         fiscal_period_2              TYPE c LENGTH 10,
         document_header_text_25      TYPE c LENGTH 50,
         transaction_currency_5       TYPE c LENGTH 5,
         currency_translation_date    TYPE string,
         reference_document_number_16 TYPE c LENGTH 20,
         partner_business_area_4      TYPE c LENGTH 10,
         tax_fulfillment_date         TYPE string,
         calculate_tax_automatically_1 TYPE c LENGTH 1,
         company_name                 TYPE c LENGTH 50,
         cost_centre_name             TYPE c LENGTH 50,
       END OF ty_journal_entry.

DATA: lt_journal_entry TYPE table of ty_journal_entry.


**********************************************************************

        TRY.
            /ui2/cl_json=>deserialize(
              EXPORTING
                json         = lv_response
                pretty_name  = /ui2/cl_json=>pretty_mode-camel_case " Auto-converts names
                assoc_arrays = abap_true
              CHANGING
                data         = lt_journal_entry
            ).
            " You can now access the internal table via ls_root-d-results
*            ls_transaction_status = lt_transaction_status[ 1 ].


          CATCH cx_root INTO DATA(lx).
            DATA(lv_err1) = 1.

        ENDTRY.


 CATCH cx_http_dest_provider_error cx_web_http_client_error INTO DATA(lx_error12).
        DATA(lv_12) = 2.

    ENDTRY.

*        zbp_hr_jv_post_rv=>gt_item = VALUE #( for ls in lt_journal_entry INDEX INTO lv  where (  company  = comy )  ( uuid = uuid
*        company = lv
*        glcode = ls-glcode
*        journalentrytype = ls-journal_entry_type_2
*        credit = ls-credit
*        debit = ls-debit
*        transactioncurrency = ls-transaction_currency_5
*        zyears = gt_header[ 1 ]-Zyears
*        zmonth = gt_header[ 1 ]-Zmonth )  )   .
loop at lt_journal_entry ASSIGNING FIELD-SYMBOL(<ls_item>) where company = comy.
*replace all OCCURRENCES OF '-' in <ls_item>-posting_date with ''.
wa_upitem-uuid = uuid.
wa_upitem-company = wa_upitem-company + 1.
wa_upitem-glcode = <ls_item>-glcode.
wa_upitem-credit = <ls_item>-credit.
wa_upitem-debit = <ls_item>-debit.
wa_upitem-transactioncurrency = <ls_item>-transaction_currency_5.
wa_upitem-zyears = gt_header[ 1 ]-Zyears.
        wa_upitem-zmonth = gt_header[ 1 ]-Zmonth.
         data(lv_temp_date) = <ls_item>-posting_date.
  IF lv_temp_date IS NOT INITIAL.
    SPLIT lv_temp_date AT '-' INTO data(lv_day)  data(lv_month)  data(lv_year).
    CONCATENATE lv_year lv_month lv_day INTO <ls_item>-posting_date.
  ENDIF.
  wa_upitem-postingdate = <ls_item>-posting_date.

        append wa_upitem to zbp_hr_jv_post_rv=>gt_item.
ENDLOOP.
  result = value #( for  ls1 in  gt_header (
  %tky = ls1-%tky
  %param = ls1 ) ).

  ENDMETHOD.

  METHOD Accdoc.
  DATA: lt_entry    TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
          ls_entry    LIKE LINE OF lt_entry,
          ls_glitem   LIKE LINE OF ls_entry-%param-_glitems,
          ls_amount   LIKE LINE OF ls_glitem-_currencyamount.

    data: lt_je type table for FUNCTION IMPORT i_journalentrytp~Validate.
    APPEND INITIAL LINE TO lt_je ASSIGNING FIELD-SYMBOL(<je>).
    <je>-%param = VALUE #( DocumentDate = '20251106' ).

    READ ENTITIES OF zhr_jv_post_rv IN LOCAL MODE
        ENTITY _hDR ALL FIELDS WITH CORRESPONDING #( keys ) RESULT FINAL(header)
        ENTITY _hDR BY \_Item ALL FIELDS WITH CORRESPONDING #( keys ) RESULT FINAL(item).

         LOOP AT header REFERENCE INTO DATA(ls_header).
      CLEAR ls_entry.
      ls_entry-%cid = ls_header->uuid. "use UUID as CID
      ls_entry-%param-companycode = ls_header->Companycode.
      ls_entry-%param-businesstransactiontype = 'RFBU'.
      ls_entry-%param-accountingdocumenttype = 'SA'.
      ls_entry-%param-accountingdocumentheadertext = 'TESTING'.
      ls_entry-%param-documentdate = SY-datum.
      ls_entry-%param-postingdate = SY-datum.
      ls_entry-%param-createdbyuser = SY-uname.

      LOOP AT item REFERENCE INTO DATA(ls_item) USING KEY entity WHERE uuid = ls_header->uuid.
        CLEAR ls_glitem.
        ls_glitem-glaccountlineitem = ls_item->%data-Company.
        ls_glitem-glaccount         = ls_item->%data-Glcode.
        ls_glitem-costcenter        = ls_item->%data-Costcentre.
        ls_glitem-profitcenter        = 'D_EAAS/AMC'.
        ls_glitem-documentitemtext       = 'TESTING Item'.

        CLEAR ls_amount.
        ls_amount-currencyrole = '00'.
        ls_amount-currency = item[ 1 ]-Transactioncurrency.
        ls_amount-journalentryitemamount = ls_item->%data-Calculatetaxautomatically .
        APPEND ls_amount TO ls_glitem-_currencyamount.
        APPEND ls_glitem TO ls_entry-%param-_glitems.
      ENDLOOP.
      APPEND ls_entry TO lt_entry.
    ENDLOOP.

    IF lt_entry IS NOT INITIAL.
      MODIFY ENTITIES OF i_journalentrytp
      ENTITY journalentry
      EXECUTE post FROM lt_entry
        MAPPED FINAL(ls_post_mapped)
        FAILED FINAL(ls_post_failed)
        REPORTED FINAL(ls_post_reported).

      IF ls_post_failed IS NOT INITIAL.
        LOOP AT ls_post_reported-journalentry INTO DATA(ls_report).
          APPEND VALUE #( uuid = ls_report-%cid
                          %create = if_abap_behv=>mk-on
                          %is_draft = if_abap_behv=>mk-on
                          %msg = ls_report-%msg ) TO reported-_hdr.
        ENDLOOP.
      ENDIF.
       ENDIF.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_zhr_jv_post1_rv DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zhr_jv_post1_rv RESULT result.

    METHODS getitem FOR DETERMINE ON SAVE
      IMPORTING keys FOR zhr_jv_post1_rv~getitem.

ENDCLASS.

CLASS lhc_zhr_jv_post1_rv IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD getitem.
    DATA : gt_itdata TYPE TABLE of zhr_jv_post1,
           gs_itrdata TYPE zhr_jv_post1.

**********************************************************************
    READ ENTITIES OF zhr_jv_post_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_header)
    ENTITY _hDR by \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_item).

**********************************************************************
    LOOP at gt_item INTO DATA(gs_item).

        MOVE-CORRESPONDING gs_item to gs_itrdata.
             gs_itrdata-company  =   gs_itrdata-company + 1.
        APPEND gs_itrdata to gt_itdata.
    ENDLOOP.
        zbp_hr_jv_post_rv=>gt_item = gt_itdata.
**********************************************************************

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zhr_jv_post_rv DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zhr_jv_post_rv IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
    if create-_hdr is not INITIAL.
        if zbp_hr_jv_post_rv=>gt_hdr is not INITIAL.
            data(gt_hd) = zbp_hr_jv_post_rv=>gt_hdr.
            MODIFY zhr_jv_post FROM TABLE @gt_hd.
        ENDIF.
        if zbp_hr_jv_post_rv=>get_item is not INITIAL.
            DATA(gt_item) = zbp_hr_jv_post_rv=>get_item.
            MODIFY zhr_jv_post1 FROM TABLE @gt_item.
        ENDIF.
    endif.
**********************************************************************

        if zbp_hr_jv_post_rv=>gt_upitem is not INITIAL.
            DATA(gt_upitem) = zbp_hr_jv_post_rv=>gt_upitem.
            MODIFY zhr_jv_post1 FROM TABLE @gt_upitem.
        ENDIF.

    if delete-_hdr is NOT INITIAL.
        LOOP AT delete-_hdr INTO DATA(ls_delete).
            DELETE FROM zhr_jv_post WHERE uuid = @ls_delete-Uuid
                                    and zmonth = @ls_delete-Zmonth
                                    and zyears = @ls_delete-Zyears.
        ENDLOOP.
    endif.
**********************************************************************
*    if create-zhr_jv_post1_rv is NOT INITIAL.
         if zbp_hr_jv_post_rv=>gt_item is NOT INITIAL.

          DATA(gt_it) = zbp_hr_jv_post_rv=>gt_item.
          DELETE gt_it WHERE company IS INITIAL.
          MODIFY zhr_jv_post1 FROM TABLE @gt_it.
         ENDIF.
*    ENDIF.

    if delete-zhr_jv_post1_rv is NOT INITIAL.
        LOOP AT delete-zhr_jv_post1_rv INTO DATA(wa_delete).
            DELETE FROM zhr_jv_post1 WHERE company = @wa_delete-Company
                                    and zmonth = @wa_delete-Zmonth
                                    and zyears = @wa_delete-Zyears
                                    and uuid = @wa_delete-Uuid.
        ENDLOOP.
    ENDIF.





  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
