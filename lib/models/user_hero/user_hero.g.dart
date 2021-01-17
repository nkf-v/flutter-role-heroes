// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHero _$UserHeroFromJson(Map<String, dynamic> json) {
  return UserHero(
    id: json['id'] as int,
    name: json['name'] as String,
    characteristics: (json['characteristics'] as List)
        ?.map((e) => e == null
            ? null
            : Characteristic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attributes: (json['attributes'] as List)
        ?.map((e) =>
            e == null ? null : Attribute.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$UserHeroToJson(UserHero instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'characteristics': instance.characteristics,
      'attributes': instance.attributes,
    };
