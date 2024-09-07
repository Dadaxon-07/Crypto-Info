import 'package:flutter/material.dart';
import 'package:networking_lesson/service/http_request.dart';

import 'model/Adreess.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Welcome> items = [];

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
        appBar: AppBar(
          title: Text("photos"),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Body : ${items[index].status}"),
                Text("Body : ${items[index].data}"),
              ],
            );
          },
        ));
  }
}
