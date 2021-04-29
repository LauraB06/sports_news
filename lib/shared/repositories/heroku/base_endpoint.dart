import 'package:sports_news/shared/repositories/abstract/base_endpoint.dart';

class BaseEndpointHeroku implements BaseEndpoint {
  @override
  String get baseEndpoint => 'https://mesa-news-api.herokuapp.com/';
}
