// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
    title: json['title'] as String,
    description: json['description'] as String,
    content: json['content'] as String,
    author: json['author'] as String,
    publishedAt: json['published_at'] == null
        ? null
        : DateTime.parse(json['published_at'] as String),
    highlight: json['highlight'] as bool,
    url: json['url'] as String,
    imageUrl: json['image_url'] as String,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'author': instance.author,
      'published_at': instance.publishedAt?.toIso8601String(),
      'highlight': instance.highlight,
      'url': instance.url,
      'image_url': instance.imageUrl,
    };
