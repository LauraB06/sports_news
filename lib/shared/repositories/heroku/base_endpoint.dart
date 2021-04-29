import 'package:sports_news/shared/repositories/abstract/base_endpoint.dart';

class BaseEndpointHeroku implements BaseEndpoint {
  @override
  String get baseEndpoint => 'https://sports-news-api.herokuapp.com/';
}
