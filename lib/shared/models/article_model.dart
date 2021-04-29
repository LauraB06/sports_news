import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  const ArticleModel({
    @required this.title,
    @required this.description,
    @required this.content,
    @required this.author,
    @required this.publishedAt,
    @required this.highlight,
    @required this.url,
    @required this.imageUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  final String title;
  final String description;
  final String content;
  final String author;

  @JsonKey(name: 'published_at')
  final DateTime publishedAt;

  final bool highlight;
  final String url;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
