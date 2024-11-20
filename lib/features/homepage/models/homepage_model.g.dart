// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomepageModel _$HomepageModelFromJson(Map<String, dynamic> json) =>
    HomepageModel(
      json['pictureId'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$HomepageModelToJson(HomepageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pictureId': instance.pictureId,
    };
