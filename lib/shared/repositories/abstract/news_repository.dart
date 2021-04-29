import 'package:flutter/foundation.dart';

abstract class NewsRepository {
  Future<Map<String, dynamic>> getNews({
    int currentPage = 1,
    int perPage = 20,
    String publishedAt,
  });

  Future<Map<String, dynamic>> getHighlights();
}
