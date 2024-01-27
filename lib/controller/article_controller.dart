import 'package:my_news_app/repository/article_service.dart';

import '../model/article_model.dart';

class ArticleController {
  final ArticleService service;

  ArticleController(this.service);
  Future<List<Article>> getArticles() {
    return service.getArticles();
  }

  Future<List<Article>> getArticlesByCategory(query) {
    return service.getArticlesByCategory(query);
  }

  Future<List<Article>> getArticlesByKeyword(keyword) {
    return service.getArticlesByKeyword(keyword);
  }
}
