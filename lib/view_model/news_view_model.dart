import 'package:newsa_app/models/categories_news_model.dart';
import 'package:newsa_app/models/news_channel_headlines_model.dart';
import 'package:newsa_app/repository/news_repository.dart';

class NewsViewModel {
  final rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String catagory) async {
    final response = await rep.fetchNewsChannelHeadlinesApi(catagory);
    return response;
  }

  Future<CategoriesNewsModel> fatchCategoriesNewsApi(String catagories) async {
    final response = await rep.fatchCategoriesNewsApi(catagories);
    return response;
  }
}
