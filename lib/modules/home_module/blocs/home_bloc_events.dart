import 'package:flutter/foundation.dart';
import 'package:sports_news/shared/models/article_model.dart';

abstract class HomeBlocEvent {}

class HomeBlocEventInitialLoad implements HomeBlocEvent {}

class HomeBlocEventLoadMore implements HomeBlocEvent {}

class HomeBlocEventHighlight implements HomeBlocEvent {
  const HomeBlocEventHighlight({@required this.article});

  final ArticleModel article;
}

class HomeBlocEventFilter implements HomeBlocEvent {
  const HomeBlocEventFilter({
    @required this.time,
    @required this.onlyHighlighted,
  });

  final List<DateTime> time;
  final bool onlyHighlighted;
}
