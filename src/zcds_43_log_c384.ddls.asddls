@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Transient - Analytical Query'
@ObjectModel.modelingPattern: #ANALYTICAL_QUERY
@ObjectModel.supportedCapabilities: [#ANALYTICAL_QUERY]
define transient view entity zcds_43_log_c384
  provider contract analytical_query
  as projection on zcds_42_log_c384
{
          @AnalyticsDetails.query.axis: #FREE
          SoKey                                                          as SalesOrderKey,

          @AnalyticsDetails.query.axis: #ROWS
          LifecycleStatus,

          @AnalyticsDetails.query.axis: #COLUMNS
          QuantitySum,
          UomSum,

          @ObjectModel.text.element: [ 'CurrencyDescription' ]
          CurrencySum,
          _Currency._Text.CurrencyName                                   as CurrencyDescription : localized ,

          @Aggregation.default: #FORMULA
          abap.decfloat34'0.05'                                          as discount,

          @Semantics.quantity.unitOfMeasure: 'AmPerQuanUnit'
          @Aggregation.default: #FORMULA
          curr_to_decfloat_amount( AmountSum ) / $projection.quantitysum as AmountPerQuantity,

  virtual AmPerQuanUnit  : dd_cds_calculated_unit,

          @Semantics.amount.currencyCode: 'TargetCurrency'
          @Aggregation.default: #FORMULA
          currency_conversion( amount => curr_to_decfloat_amount( AmountSum ),
                               source_currency => CurrencySum,
                               target_currency => abap.cuky'EUR',
                               exchange_rate_date => CreatedOn )         as ConvertedAmount,

  virtual TargetCurrency : abap.cuky

}
