import 'package:sports_news/shared/repositories/abstract/base_endpoint.dart';

class BaseEndpointNewsApi implements BaseEndpoint {
  @override
  String get baseEndpoint => 'https://newsapi.org/v2/';
}
