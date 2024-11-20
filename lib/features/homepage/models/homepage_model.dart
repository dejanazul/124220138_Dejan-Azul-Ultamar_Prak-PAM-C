import 'package:json_annotation/json_annotation.dart';

part 'homepage_model.g.dart';

@JsonSerializable()
class HomepageModel {
  final String id;
  final String name;
  final String pictureId;

  HomepageModel(this.pictureId, {required this.id, required this.name});

  factory HomepageModel.fromJson(Map<String, dynamic> json) =>
      _$HomepageModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomepageModelToJson(this);
}
