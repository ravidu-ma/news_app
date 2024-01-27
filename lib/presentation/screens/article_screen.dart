import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_news_app/model/source_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/article_model.dart';
import '../atoms/custom_tag.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);
  static const routeName = '/article';

  @override
  Widget build(BuildContext context) {
    //Argument Handling
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage("${article.urlToImage.toString()}"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: ListView(children: [
          _newsHeading(
            article: article,
            source: article.source,
          ),
          _newsBody(
            source: article.source,
            article: article,
          ),
        ]),
      ),
    );
  }
}

class _newsBody extends StatelessWidget {
  _newsBody({Key? key, required this.source, required this.article})
      : super(key: key);

  final Source source;
  final Article article;
  final FlutterTts speaker = FlutterTts();
  bool speach = false;
  @override
  Widget build(BuildContext context) {
    Future _speack(String note) async {
      if (speach == false) {
        speach = !speach;
        await speaker.setLanguage("en-US");
        await speaker.setPitch(1);
        await speaker.speak(note);
      } else {
        await speaker.stop();
      }
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomTag(children: [
                    const SizedBox(
                        height: 30,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                        )),
                    Text(source.name.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)),
                  ], backgroundColor: Colors.black),
                  IconButton(
                    icon: const Icon(Icons.record_voice_over),
                    onPressed: () {
                      _speack(
                          " ${article.title.toString()} ${article.description.toString()}   ${article.content.toString()}");
                    },
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    Share.share("${article.url}");
                  },
                  icon: const Icon(Icons.share))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                article.title.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                article.description.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: NetworkImage("${article.urlToImage}"),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                article.content.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _newsHeading extends StatelessWidget {
  _newsHeading({Key? key, required this.article, required this.source})
      : super(key: key);

  final Article article;
  Source source;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomTag(children: [
            Text(source.name.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
          ], backgroundColor: Colors.black.withAlpha(150)),
          Text(
            article.title.toString(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white, height: 1.25),
          ),
        ],
      ),
    );
  }
}
