import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  const PaginationModel({
    @required this.currentPage,
    @required this.perPage,
    @required this.totalPages,
    @required this.totalItems,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'per_page')
  final int perPage;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_items')
  final int totalItems;

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
