import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sports_news/shared/models/article_model.dart';
import 'package:sports_news/shared/models/pagination_model.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  const NewsModel({
    @required this.pagination,
    @required this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  final PaginationModel pagination;

  @JsonKey(name: 'data')
  final List<ArticleModel> articles;

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
