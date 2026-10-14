CLASS zcl_edoc_zero_tax DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_edoc_adaptor_cloud .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EDOC_ZERO_TAX IMPLEMENTATION.


  METHOD if_edoc_adaptor_cloud~change_edocument_type.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~change_form.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~change_invoice_type.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~get_variable_key.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~is_relevant.

    " 1. Restrict execution strictly to Sales and Billing Documents (SD_INVOICE)
    IF iv_source_type = 'SD_INVOICE'.
      " Validate that this is localized for an Indian Company / Tax Jurisdiction
      IF is_source_data-billing_header-landtx = 'IN'.

        IF is_source_data-billing_header-mwsbk = 0.

          " 2. Target your client's specific business documents: Debit Notes (L2) & Credit Notes (G2)
          IF is_source_data-billing_header-fkart = 'L2' OR
             is_source_data-billing_header-fkart = 'G2'.

            " CRITICAL FIX: Force eInvoice generation to satisfy the GST portal requirement
            cv_relevant = abap_true.

          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~restrict_cancel.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~set_output_data.

*    " 1. Ensure we only modify data for Sales/Billing Documents in India
    IF iv_source_type = 'SD_INVOICE' AND
       is_source_data-billing_header-landtx = 'IN'.

      " 2. Target the same custom criteria (Zero tax for  L2, and G2 documents)
      IF                                                        "is_source_data-billing_header-mwsbk = 0 AND
         ( is_source_data-billing_header-fkart = 'L2' OR
           is_source_data-billing_header-fkart = 'G2' ).

        " 3. CRITICAL BYPASS FOR EWAY BILL:
        " Wipe out transportation parameters in the mutable changing output structure.
        " This ensures the SAP eDocument framework skips validation routines.

        "-- used proxy structure is edo_ubl_standard_business_doc2
*        DATA: ls_source_data     TYPE if_edoc_cloud_datatypes=>mty_source_data.
*        ls_source_data = is_source_data.


        " Field symbols to navigate the generic ANY structure safely
        FIELD-SYMBOLS: <ls_output_data1> TYPE any,
                       <ls_output_data2> TYPE any,
                       <fv_field>        TYPE any.

        " 1. Safely assign the sub-structure 'CS_OUTPUT_DATA' out of the generic cs_output_data




        ASSIGN COMPONENT 'REQUEST' OF STRUCTURE cs_output_data TO <ls_output_data1>.
        ASSIGN COMPONENT 'DOC_DATA' OF STRUCTURE <ls_output_data1> TO <ls_output_data2>.
        IF <ls_output_data2> IS ASSIGNED.
*
*          " 2. Clear out the respective fields to bypass the eWay bill verification
          ASSIGN COMPONENT 'TRANS_MODE' OF STRUCTURE <ls_output_data2> TO <fv_field>.
          IF <fv_field> IS ASSIGNED. CLEAR <fv_field>. UNASSIGN <fv_field>. ENDIF.

          ASSIGN COMPONENT 'TRANS_DISTANCE' OF STRUCTURE <ls_output_data2> TO <fv_field>.
          IF <fv_field> IS ASSIGNED. CLEAR <fv_field>. UNASSIGN <fv_field>. ENDIF.

          ASSIGN COMPONENT 'TRANSPORTER_NAME' OF STRUCTURE <ls_output_data2> TO <fv_field>.
          IF <fv_field> IS ASSIGNED. CLEAR <fv_field>. UNASSIGN <fv_field>. ENDIF.

          ASSIGN COMPONENT 'VEHICLE_NO' OF STRUCTURE <ls_output_data2> TO <fv_field>.
          IF <fv_field> IS ASSIGNED. CLEAR <fv_field>. UNASSIGN <fv_field>. ENDIF.

          ASSIGN COMPONENT 'VEHICLE_TYPE' OF STRUCTURE <ls_output_data2> TO <fv_field>.
          IF <fv_field> IS ASSIGNED. CLEAR <fv_field>. UNASSIGN <fv_field>. ENDIF.

*          ASSIGN COMPONENT 'TRANSPORTER_ID' OF STRUCTURE <ls_output_data2> TO <fv_field>.
*          IF <fv_field> IS ASSIGNED. CLEAR <fv_field>. UNASSIGN <fv_field>. ENDIF.

        ENDIF.

      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
