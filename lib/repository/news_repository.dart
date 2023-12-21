import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsa_app/models/categories_news_model.dart';
import 'package:newsa_app/models/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String catagory) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$catagory&apiKey=b106e40bab834092a45bcca2b5cdf9c8';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModel> fatchCategoriesNewsApi(String catagories) async {
    String url =
        'https://newsapi.org/v2/everything?q=$catagories &apiKey=b106e40bab834092a45bcca2b5cdf9c8';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
