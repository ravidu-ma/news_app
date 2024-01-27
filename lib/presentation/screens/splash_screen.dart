import 'package:flutter/material.dart';
import 'package:my_news_app/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/news-logo.png'),
              width: 200,
            ),
            // Text("MY NEWS APP",
            //     style: TextStyle(
            //       fontSize: 25,
            //     )),
            // Text(
            //   "News From all Over the World",
            //   style: TextStyle(fontSize: 10, color: Colors.blueAccent),
            // )
          ],
        ),
      ),
    );
  }

  _splash() async {
    await Future.delayed(const Duration(milliseconds: 1555), () {});
    Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
