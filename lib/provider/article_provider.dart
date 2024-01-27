import 'package:flutter/cupertino.dart';
import 'package:my_news_app/controller/article_controller.dart';
import 'package:my_news_app/repository/article_repository.dart';

import '../model/article_model.dart';

enum HomeState { Initial, Loading, Loaded, Error }

class ArticleModel extends ChangeNotifier {
  //Dependency Injection
  var _articleController = ArticleController(ArticleRepository());
  //State Define
  HomeState _homeState = HomeState.Initial;

  List<Article> _articles = [];
  List<Article> _temp = [];

  HomeState get homeState => _homeState;
  List<Article> get articles => _articles;
  ArticleModel();
  void setArticles(query) async {
    _homeState = HomeState.Loading;
    try {
      _homeState = HomeState.Loaded;
      final articles = await _articleController.getArticlesByCategory(query);
      _articles = articles;
      _temp = articles;
    } catch (e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  void searchArticles(keyword) async {
    _homeState = HomeState.Loading;
    try {
      _homeState = HomeState.Loaded;
      final results = _temp
          .where((element) => element.content!
              .toLowerCase()
              .contains(keyword.toString().toLowerCase()))
          .toList();
      _articles = results;
    } catch (e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  bool sortingSlug = false;
  void sort() {
    sortingSlug = !sortingSlug;
    if (sortingSlug == false) {
      _articles.sort((a, b) => DateTime.parse(a.publishAt.toString())
          .compareTo(DateTime.parse(b.publishAt.toString())));
    } else {
      _articles.sort((a, b) => DateTime.parse(b.publishAt.toString())
          .compareTo(DateTime.parse(a.publishAt.toString())));
    }
    notifyListeners();
  }

  void searchAll(keyword) async {
    _homeState = HomeState.Loading;
    try {
      final response = await _articleController.getArticlesByKeyword(keyword);
      _articles = response;
      _homeState = HomeState.Loaded;
    } catch (e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
}
