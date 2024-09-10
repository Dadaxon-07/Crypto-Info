import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:networking_lesson/model/crypto_model.dart';
import 'package:http/http.dart' as http;

import 'details_page.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  List<CryptoModel> list = [];

  Future<void> fetchCrypto() async {
    final response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1"));
    if (response.statusCode == 200) {
      List<dynamic> crypto = jsonDecode(response.body);
      setState(() {
        list = crypto.map((e) => CryptoModel.fromJson(e)).toList();
      });
    } else {
      //dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Crypto  \$",
          style: TextStyle(color: Colors.white60),
        ),
        backgroundColor: Color.fromARGB(255, 25, 23, 59),
      ),
      body: FutureBuilder(
          future: fetchCrypto(),
          builder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 22, 21, 58),
                    Color.fromARGB(255, 34, 32, 72),
                    Color.fromARGB(255, 48, 44, 72),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.2,
                    0.5,
                    0.99,
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DetailsPage(
                          name: list[index].name,
                          image: list[index].image,
                          price: list[index].currentPrice.toDouble(),
                          crypto: list[index],
                        );
                      }));
                    },
                    leading: Container(
                      height: 80,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(list[index].image.toString()),
                              fit: BoxFit.cover)),
                    ),
                    title: Text(
                      list[index].name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      list[index].symbol,
                      style: TextStyle(color: Colors.white60),
                    ),
                    trailing: Text(
                      "${list[index].currentPrice.toString()} \$",
                      style: TextStyle(fontSize: 17, color: Colors.white54),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
