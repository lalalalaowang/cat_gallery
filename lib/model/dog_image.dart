import 'package:json_annotation/json_annotation.dart';

part "dog_image.g.dart";

@JsonSerializable()
class DogImage {
  final String id;
  final String url;

  DogImage({required this.id, required this.url});

  factory DogImage.formJson(Map<String, dynamic> json) {
    return _$DogImageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DogImageToJson(this);
}
