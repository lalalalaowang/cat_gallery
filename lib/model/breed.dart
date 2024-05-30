import 'package:cat_gallery/model/cat_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'breed.g.dart';

@JsonSerializable(explicitToJson: true)
class Breed {
  final String id;
  final String name;
  final String? description;
  final String? temperament;
  @JsonKey(name: "life_span")
  final String lifeSpan;
  final CatImage? image;

  const Breed(
      {required this.id,
      required this.name,
      required this.description,
      required this.temperament,
      required this.lifeSpan,
      required this.image});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return _$BreedFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BreedToJson(this);
}
