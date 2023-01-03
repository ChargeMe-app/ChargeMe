// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      connectors: (json['connectors'] as List<dynamic>)
          .map((e) => $enumDecode(_$ConnectorTypeEnumMap, e))
          .toSet(),
      minScore: (json['min_score'] as num?)?.toDouble() ?? 0,
      maxScore: (json['max_score'] as num?)?.toDouble() ?? 10,
      showPublic: json['show_public'] as bool? ?? true,
      showPublicFast: json['show_public_fast'] as bool? ?? true,
      showHome: json['show_home'] as bool? ?? true,
      showComingSoon: json['show_coming_soon'] as bool? ?? true,
      showPaid: json['show_paid'] as bool? ?? true,
      showWithCheckin: json['show_with_checkin'] as bool? ?? true,
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'connectors':
          instance.connectors.map((e) => _$ConnectorTypeEnumMap[e]!).toList(),
      'min_score': instance.minScore,
      'max_score': instance.maxScore,
      'show_public': instance.showPublic,
      'show_public_fast': instance.showPublicFast,
      'show_home': instance.showHome,
      'show_coming_soon': instance.showComingSoon,
      'show_paid': instance.showPaid,
      'show_with_checkin': instance.showWithCheckin,
    };

const _$ConnectorTypeEnumMap = {
  ConnectorType.unknown: 0,
  ConnectorType.wall: 1,
  ConnectorType.type1: 2,
  ConnectorType.chademo: 3,
  ConnectorType.teslaRoadster: 4,
  ConnectorType.nema1450: 5,
  ConnectorType.tesla: 6,
  ConnectorType.type2: 7,
  ConnectorType.type3: 8,
  ConnectorType.wallBS1363: 9,
  ConnectorType.wallEuro: 10,
  ConnectorType.commando: 11,
  ConnectorType.cssCombo: 13,
  ConnectorType.threePhase: 14,
  ConnectorType.caravanMainsSocket: 15,
  ConnectorType.gbt: 16,
  ConnectorType.type3a: 24,
};
