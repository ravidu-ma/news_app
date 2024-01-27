import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_news_app/repository/article_service.dart';
import 'package:my_news_app/services/api_service.dart';

import '../model/article_model.dart';

class ArticleRepository implements ArticleService {
  //API Injection
  final ApiService _service = ApiService();
  @override
  Future<List<Article>> getArticles() async {
    Response res = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=all&sortBy=publishedAt&language=en&apiKey=62224834af934ee4986281adfbbf65eb"));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json["articles"];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }

  @override
  Future<List<Article>> getArticlesByCategory(query) async {
    Response res = await get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=$query&language=en&apiKey=62224834af934ee4986281adfbbf65eb"));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json["articles"];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }

  @override
  Future<List<Article>> getArticlesByKeyword(keyword) async {
    Response res = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$keyword&sortBy=publishedAt&apiKey=b49277679077461da0b93b707a9a6057"));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json["articles"];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
