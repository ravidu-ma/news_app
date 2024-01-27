import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_news_app/model/category_model.dart';
import 'package:my_news_app/presentation/molecules/bottom_nav_bar.dart';
import 'package:my_news_app/presentation/screens/article_screen.dart';
import 'package:my_news_app/provider/article_provider.dart';
import 'package:provider/provider.dart';

import '../atoms/custom_input.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';
  //Controllers
  final _searchController = TextEditingController();
  static List<Category> categories = [
    Category(
        flag: "business",
        name: "Business",
        img:
            "https://hbr.org/resources/images/article_assets/2022/08/Hero-Image.png"),
    Category(
        flag: "entertainment",
        name: "Entertainment",
        img:
            "https://dailytrust.com/wp-content/uploads/2019/09/entertainment-tech1-931x400.jpg"),
    Category(
        flag: "general",
        name: "General",
        img:
            "https://d2v9ipibika81v.cloudfront.net/uploads/sites/149/Image-2-15-1140x684.jpg"),
    Category(
        flag: "health",
        name: "Health",
        img:
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fresh-vegetables-fruits-and-nuts-royalty-free-image-943001868-1550249117.jpg"),
    Category(
        flag: "science",
        name: "Science",
        img:
            "https://arc.losrios.edu/shared/img/programs-940-529/general-science.jpg"),
    Category(
        flag: "sports",
        name: "Sports",
        img:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Youth-soccer-indiana.jpg/360px-Youth-soccer-indiana.jpg"),
    Category(
        flag: "technology",
        name: "Technology",
        img:
            "https://www.netscribes.com/wp-content/uploads/2019/06/Technology-Watch.jpg"),
  ];
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
                "Discover",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Text("Discover the News from your Favorite Category"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  print(value);
                  context.read<ArticleModel>().searchArticles(value);
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
              _categoryList(categories),
              const SizedBox(
                height: 10,
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
        height: 300,
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
                                " ${DateTime.now().difference(DateTime.parse(article.publishAt.toString())).inMinutes > 60 ? DateTime.now().difference(DateTime.parse(article.publishAt.toString())).inHours : DateTime.now().difference(DateTime.parse(article.publishAt.toString())).inMinutes} ${DateTime.now().difference(DateTime.parse(article.publishAt.toString())).inMinutes > 60 ? "hours ago" : "minutes ago"}"),
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

  _categoryList(List<Category> list) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.read<ArticleModel>().setArticles(list[index].flag);
              _searchController.clear();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width * 0.35,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                    image: NetworkImage("${list[index].img}"),
                    fit: BoxFit.cover,
                    opacity: 90),
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
              child: Center(
                  child: Text(
                list[index].name.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          );
        },
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
