// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Degree _$TemperatureFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Temperature',
      json,
      ($checkedConvert) {
        final val = Degree(
          value: $checkedConvert('value', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$TemperatureToJson(Degree instance) => <String, dynamic>{
      'value': instance.value,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
          lastUpdated: $checkedConvert(
              'last_updated', (v) => DateTime.parse(v as String)),
          location: $checkedConvert('location', (v) => v as String),
          degree: $checkedConvert(
              'temperature', (v) => Degree.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'lastUpdated': 'last_updated'},
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'last_updated': instance.lastUpdated.toIso8601String(),
      'location': instance.location,
      'temperature': instance.degree.toJson(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};
