import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  const ArticleModel({
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.content,
    @required this.publishedAt,
    @required this.highlight,
    @required this.url,
    @required this.urlToImage,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  final String author;
  final String title;
  final String description;
  final String url;

  final String urlToImage;

  @JsonKey(name: 'publishedAt')
  final DateTime publishedAt;
  final String content;


  final bool highlight;

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
