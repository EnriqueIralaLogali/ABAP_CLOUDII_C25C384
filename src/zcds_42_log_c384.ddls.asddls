@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cube'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
        serviceQuality: #D,
        sizeCategory: #S,
        dataClass: #MIXED }

@Analytics.dataCategory: #CUBE

define view entity zcds_42_log_c384
  as select from zso_lgl as SalesOrder

  association [0..1] to zcds_41_log_c384 as _Currency on _Currency.Currency = $projection.CurrencySum

{
  key SalesOrder.so_key           as SoKey,
      SalesOrder.lifecycle_status as LifecycleStatus,
      company_code                as CompanyCode,

      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'CurrencySum'
      amount_sum                  as AmountSum,

      @ObjectModel.foreignKey.association: '_Currency'
      currency_sum                as CurrencySum,

      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'UomSum'
      quantity_sum                as QuantitySum,
      uom_sum                     as UomSum,

      @DefaultAggregation: #NONE
      created_by                  as CreatedBy,

      @DefaultAggregation: #NONE
      created_on                  as CreatedOn,

      _Currency

}
