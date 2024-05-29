// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Breed _$BreedFromJson(Map<String, dynamic> json) => Breed(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      temperament: json['temperament'] as String,
      lifeSpan: json['life_span'] as String,
      image: CatImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BreedToJson(Breed instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'temperament': instance.temperament,
      'life_span': instance.lifeSpan,
      'image': instance.image.toJson(),
    };
