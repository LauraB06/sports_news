import 'package:flutter/foundation.dart';
import 'package:sports_news/shared/models/article_model.dart';

abstract class HomeBlocState {}

class HomeBlocStateLoading implements HomeBlocState {}

class HomeBlocStateLoaded implements HomeBlocState {
  HomeBlocStateLoaded({
    @required this.articles,
    @required this.highlights,
    this.highlightedArticles = const <ArticleModel>[],
    this.viewedArticles = const <String>[],
  });

  final List<ArticleModel> articles;
  final List<ArticleModel> highlights;
  final List<ArticleModel> highlightedArticles;
  final List<String> viewedArticles;
}

class HomeBlocStateError implements HomeBlocState {}
