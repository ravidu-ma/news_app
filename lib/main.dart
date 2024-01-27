import 'package:flutter/material.dart';
import 'package:my_news_app/controller/article_controller.dart';
import 'package:my_news_app/model/article_model.dart';
import 'package:my_news_app/presentation/screens/all_article_screen.dart';
import 'package:my_news_app/presentation/screens/article_screen.dart';
import 'package:my_news_app/presentation/screens/home_screen.dart';
import 'package:my_news_app/presentation/screens/search_screen.dart';
import 'package:my_news_app/presentation/screens/splash_screen.dart';
import 'package:my_news_app/provider/article_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ArticleModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/splash',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ArticleScreen.routeName: (context) => const ArticleScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        AllArticlesScreen.routeName: (context) => const AllArticlesScreen(),
        SplashScreen.routeName: (context) => const SplashScreen()
      },
    );
  }
}
