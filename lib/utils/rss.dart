import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;

abstract class Api {
  static const _baseUrl = 'https://lenta.ru/rss/';
  final _client = http.Client();

  Future<List<RssItem>> getNews();
}

class ApiBaseException implements Exception {
  final String? msg;
  const ApiBaseException([this.msg]);

  @override
  String toString() => msg ?? 'ApiBaseException';
}

class RssNewsException extends ApiBaseException {
  @override
  const RssNewsException([String? msg]);
  @override
  String toString() => msg ?? 'RssNewsException';
}

class LentaLastNewsProvider extends Api {
  final _lastNews = 'top7';
  @override
  Future<List<RssItem>> getNews() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _client.get(Uri.parse(Api._baseUrl + _lastNews));

      final rssFeed = RssFeed.parse(response.body);

      if (response.statusCode == 200) {
        return RssFeed.parse(response.body).items;
      }
      throw const RssNewsException();
    } on http.ClientException {
      throw const RssNewsException('ClientException');
    }
  }
}

class LentaLastNews24Provider extends Api {
  final _last24News = 'last24';

  @override
  Future<List<RssItem>> getNews() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await _client.get(Uri.parse(Api._baseUrl + _last24News));
      final rssFeed = RssFeed.parse(response.body);

      if (response.statusCode == 200) {
        return RssFeed.parse(response.body).items;
      }
      throw const RssNewsException();
    } on http.ClientException {
      throw const RssNewsException('ClientException');
    }
  }
}
