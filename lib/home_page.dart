import 'dart:io';

import 'package:flutter/material.dart';
import 'package:networking_lesson/service/http_request.dart';
import 'package:networking_lesson/utils/logger.dart';

import 'model/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  void apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response =
        await HTTPRequest.GET(HTTPRequest.API_List, HTTPRequest.paramsEmpty());

    if (response != null) {
      isLoading = false;
      items = HTTPRequest.parsePostList(response);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(items[index].title.toString()),
            Text(items[index].albumId.toString()),
            //
            Text(items[index].id.toString()),
            Image.network(items[index].url!),
          ],
        );
      },
    ));
  }
}
