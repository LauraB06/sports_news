import 'package:flutter/foundation.dart';
import 'package:sports_news/shared/models/article_model.dart';
import 'package:sports_news/shared/models/home_articles_model.dart';
import 'package:sports_news/shared/models/pagination_model.dart';
import 'package:sports_news/shared/repositories/abstract/news_repository.dart';

class NewsService {
  NewsService({
    @required this.newsRepository,
  });

  final NewsRepository newsRepository;

  int _currentPage = 1;
  final int _perPage = 20;
  int _totalPages;
  int _totalItems;

  Future<HomeArticles> getNews() async {
    List<Map<String, dynamic>> results = await Future.wait(
      <Future<Map<String, dynamic>>>[
        newsRepository.getHighlights(),
        newsRepository.getNews(),
      ],
    );

    // print(results);

    // return HomeArticles(articles: [], highlights: []);

    if (results.length == 2) {
      final Map<String, dynamic> highlightResult = results[0];
      final Map<String, dynamic> articleResult = results[1];

      // _currentPage += 1;

      // final PaginationModel pagination = PaginationModel.fromJson(
        // articleResult['pagination'] as Map<String, dynamic>,
      // );

      // _totalItems = pagination.totalItems;
      // _totalPages = pagination.totalPages;

      final List<ArticleModel> highlights =
          (highlightResult['articles'] as List<dynamic>)
              .map((dynamic model) =>
                  ArticleModel.fromJson(model as Map<String, dynamic>))
              .toList();

      final List<ArticleModel> articles =
          (articleResult['articles'] as List<dynamic>)
              .map((dynamic model) =>
                  ArticleModel.fromJson(model as Map<String, dynamic>))
              .toList();

      return HomeArticles(articles: articles, highlights: highlights);
    } else {
      return null;
    }
  }

  Future<List<ArticleModel>> getMoreNews() async {
    if (_currentPage < _totalPages) {
      final Map<String, dynamic> result = await newsRepository.getNews(
        currentPage: _currentPage,
        perPage: _perPage,
      );

      if (result != null) {
        final List<ArticleModel> articles = (result['data']
                as List<dynamic>)
            .map((dynamic model) => ArticleModel.fromJson(model as Map<String, dynamic>))
            .toList();

        _currentPage += 1;
        return articles;
      }
    }
    return null;
  }
}
