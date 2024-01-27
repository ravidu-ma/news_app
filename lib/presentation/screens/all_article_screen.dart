import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/article_provider.dart';
import '../molecules/bottom_nav_bar.dart';
import 'article_screen.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({Key? key}) : super(key: key);
  static const routeName = '/all';
  @override
  Widget build(BuildContext context) {
    context.read<ArticleModel>().setArticles("business");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search News",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Text("News from all over the world"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  if (value.length > 0) {
                    context.read<ArticleModel>().searchAll(value);
                  } else {
                    context.read<ArticleModel>().searchAll("all");
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ArticleModel>().sort();
                      },
                      icon: const Icon(Icons.sort),
                      splashRadius: 2,
                    ),
                    hintText: "Search",
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              _resultList()
            ],
          ),
        ],
      ),
    );
  }

  _resultList() {
    return Builder(builder: (context) {
      var _state = context.watch<ArticleModel>().homeState;
      if (_state == HomeState.Loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (_state == HomeState.Error) {
        return const Center(child: Text("An Error Occurred!"));
      }
      final articles = context.watch<ArticleModel>().articles;
      return SizedBox(
        height: 400,
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ArticleScreen.routeName,
                  arguments: article,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage("${article.urlToImage}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          article.title.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.schedule),
                            Text(
                                " ${DateTime.now().difference(DateTime.parse(article.publishAt.toString())).inMinutes} minutes ago"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
