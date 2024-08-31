
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

          Container(height: 100, color: Colors.cyan, child: Center(child: Text("albumId : ${items[index].albumId.toString()}", style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),)), ),
          Container(height: 100, color: Colors.deepPurpleAccent, child: Center(child: Text("Id : ${items[index].id.toString()}", style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),)), ),
            Container(padding: EdgeInsets.all(20), height: 100, color: Colors.blueAccent, child: Center(child:Text("Title : ${items[index].title}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),),),
            Container(padding: EdgeInsets.all(20), height: 100, color: Colors.red, child: Center(child:Text("Url : ${items[index].url}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),),),
            Container(padding: EdgeInsets.all(20), height: 100, color: Colors.blueAccent, child: Center(child:Text("thumbnailUrl : ${items[index].thumbnailUrl}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),),),
       //     Container(padding: EdgeInsets.all(15), height: 100, color: Colors.indigo, child: Center(child:Text("Body : ${items[index].body}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),),),

          ],
        );
      },
    ));
  }
}
