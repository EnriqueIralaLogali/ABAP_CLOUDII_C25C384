CLASS zcl_gen_data_c384 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  inTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gen_data_c384 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    delete from ztravel_c384_a.
    delete from ztravel_c384_d.

    insert ztravel_c384_a from (
          select from /dmo/travel
                 fields uuid(  ) as travel_uuid,
                        travel_id,
                        agency_id,
                        customer_id,
                        begin_date,
                        end_date,
                        booking_fee,
                        total_price,
                        currency_code,
                        description,
                        case status
                          when 'B' then 'A'
                          when 'P' then 'O'
                          when 'N' then 'O'
                          else 'X'
                        end as overall_status,
                      createdby     as local_created_by,
                      createdat     as local_created_at,
                      lastchangedby as local_last_changed_by,
                      lastchangedat as local_last_changed_at
                      where travel_id between 1 and 3000 ).

    if sy-subrc eq 0.
      out->write( |Travel......{ sy-dbcnt } rows inserted.| ).
    endif.

  ENDMETHOD.

ENDCLASS.
