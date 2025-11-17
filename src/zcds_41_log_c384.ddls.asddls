@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VDM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
        serviceQuality: #D,
        sizeCategory: #S,
        dataClass: #MIXED }

//From the Heard and McDonald Islands

//0.0 - Error
//0.1
//0.2
//0.3
//...
//0.8
//0.9
//1.0 - Exact

//From - From
//the
//Heard
//and
//McDon
//ald
//Islan
//ds


@Search.searchable: true

@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION

define view entity zcds_41_log_c384
  as select from I_Currency

  association [0..*] to I_CurrencyText as _Text on _Text.Currency = $projection.Currency                                            

{
  key Currency,

      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      CurrencyISOCode,
      AlternativeCurrencyKey,
      IsPrimaryCurrencyForISOCrcy,

      /* Associations */
      _Text
}
