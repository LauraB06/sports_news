import 'package:bloc/bloc.dart';
import 'package:catcher/core/catcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc_events.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc_states.dart';
import 'package:sports_news/shared/models/article_model.dart';
import 'package:sports_news/shared/models/home_articles_model.dart';
import 'package:sports_news/shared/services/news_service.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc({@required this.newsService}) : super(HomeBlocStateLoading());

  final NewsService newsService;

  List<ArticleModel> articles = <ArticleModel>[];
  List<ArticleModel> highlights = <ArticleModel>[];
  List<ArticleModel> userHighlighted = <ArticleModel>[];

  @override
  Stream<HomeBlocState> mapEventToState(HomeBlocEvent event) async* {
    switch (event.runtimeType) {
      case HomeBlocEventInitialLoad:
        try {
          final HomeArticles homeArticles = await newsService.getNews();

          articles = homeArticles.articles;
          highlights = homeArticles.highlights;

          yield HomeBlocStateLoaded(
            articles: articles,
            highlights: highlights,
            highlightedArticles: userHighlighted,
          );
        } catch (e) {
          if (e is DioError) {
            Catcher.reportCheckedError(
                e.response.data['message'] ?? e.message, null);
            yield HomeBlocStateError();
          } else {
            rethrow;
          }
        }
        break;

      case HomeBlocEventLoadMore:
        try {
          final List<ArticleModel> newArticles =
              await newsService.getMoreNews();
          articles.addAll(newArticles);

          yield HomeBlocStateLoaded(
            articles: articles,
            highlights: highlights,
            highlightedArticles: userHighlighted,
          );
        } catch (e) {
          if (e is DioError) {
            Catcher.reportCheckedError(
                e.response.data['message'] ?? e.message, null);
            yield HomeBlocStateError();
          } else {
            rethrow;
          }
        }
        break;

      case HomeBlocEventFilter:
        final HomeBlocEventFilter eventFilter = event as HomeBlocEventFilter;
        try {
          HomeBlocStateLoaded(
            highlights: highlights,
            articles: articles.where((ArticleModel model) {
              if (eventFilter.onlyHighlighted) {
                return model.highlight || userHighlighted.contains(model);
              } else if (eventFilter.time.isNotEmpty) {
                return model.publishedAt.isAfter(eventFilter.time.first) &&
                    model.publishedAt.isBefore(eventFilter.time.last);
              }
              return false;
            }).toList(),
            highlightedArticles: userHighlighted,
          );
        } catch (e) {
          if (e is DioError) {
            Catcher.reportCheckedError(
                e.response.data['message'] ?? e.message, null);
            yield HomeBlocStateError();
          } else {
            rethrow;
          }
        }
        break;

      case HomeBlocEventHighlight:
        if (userHighlighted
            .contains((event as HomeBlocEventHighlight).article)) {
          userHighlighted.remove((event as HomeBlocEventHighlight).article);
        } else {
          userHighlighted.add((event as HomeBlocEventHighlight).article);
        }

        yield HomeBlocStateLoaded(
          articles: articles,
          highlights: highlights,
          highlightedArticles: userHighlighted,
        );
        break;
    }
  }
}
