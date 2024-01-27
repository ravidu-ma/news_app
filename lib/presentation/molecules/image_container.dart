import 'package:flutter/material.dart';
import 'package:my_news_app/model/article_model.dart';
import 'package:my_news_app/presentation/atoms/custom_tag.dart';

import '../screens/article_screen.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.article, this.child})
      : super(key: key);

  final Article article;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(article.urlToImage.toString()),
          fit: BoxFit.cover,
        ),
      ),
      child: ContainerContent(
        article: article,
        tag: "Latest News of the Day",
      ),
    );
  }
}

class ContainerContent extends StatelessWidget {
  const ContainerContent({Key? key, required this.article, required this.tag})
      : super(key: key);

  final Article article;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTag(children: [
          Text("$tag",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white)),
        ], backgroundColor: Colors.black.withAlpha(150)),
        Text("${article.title}",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.25)),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ArticleScreen.routeName,
                  arguments: article);
            },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Row(
              children: [
                Text("Learn More",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white)),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.arrow_circle_right),
              ],
            )),
      ],
    );
  }
}
