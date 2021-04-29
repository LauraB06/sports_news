import 'package:flutter/foundation.dart';
import 'package:sports_news/shared/models/article_model.dart';

class HomeArticles {
  const HomeArticles({
    @required this.articles,
    @required this.highlights,
  });

  final List<ArticleModel> articles;
  final List<ArticleModel> highlights;
}
