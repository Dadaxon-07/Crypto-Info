import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/news_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> news = [];

  Future<void> getNewsApi() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2024-08-07&sortBy=publishedAt&apiKey=b59d0a82dda64146aff3dfda726de7ff"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List<dynamic> articleData = data['articles'];
      setState(() {
        news = articleData.map((e) => Article.fromJson(e)).toList();
      });
    } else {
      print("xato response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getNewsApi(),
          builder: (context, index) {
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.network(news[index].urlToImage.toString()),
                    Text(
                      news[index].title,
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    Text(news[index].publishedAt.toString())
                  ],
                );
              },
            );
          }),
    );
  }

  Widget story({img}) {
    return Container(
      height: 100,
      width: 100,
    );
  }
}
