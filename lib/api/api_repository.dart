import 'dart:async';

import 'package:ICare/models/response_top_headlinews_news.dart';

import 'api_provider.dart';


class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<List<News>> fetchTopHeadlinesNews() =>
      _apiProvider.getTopHeadlinesNews();

  Future<List<News>> tinTucNong() =>
      _apiProvider.getTinTucTheoLoai(1);

  Future<List<News>> tinTucKhoeDep() =>
      _apiProvider.getTinTucTheoLoai(2);

  Future<List<News>> tinTucYHoc() =>
      _apiProvider.getTinTucTheoLoai(3);

  Future<List<News>> tinTucDinhDuong() =>
      _apiProvider.getTinTucTheoLoai(4);

  Future<List<News>> tinTucGioitinh() =>
      _apiProvider.getTinTucTheoLoai(5);

  Future<List<News>> tinTucDichBenh() =>
      _apiProvider.getTinTucTheoLoai(6);

  Future<List<News>> tinTucMeoCanBiet() =>
      _apiProvider.getTinTucTheoLoai(7);
}
