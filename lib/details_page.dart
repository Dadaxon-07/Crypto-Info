import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:networking_lesson/model/crypto_model.dart';

class DetailsPage extends StatefulWidget {
  final CryptoModel crypto;
  String image;
  String name;
  double price;

  DetailsPage(
      {super.key,
      required this.name,
      required this.image,
      required this.crypto,
      required this.price});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<FlSpot> historicalData = [];

  Future<void> fetchCryptoPrices() async {
    final response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/${widget.crypto.id}/market_chart?vs_currency=usd&days=365&interval=daily&precision=0"));
    if (response.statusCode == 200) {
      final List<dynamic> cryptoPrice =
          jsonDecode(response.body.toString())['prices'];
      setState(() {
        historicalData = cryptoPrice
            .map((price) =>
                FlSpot(cryptoPrice.indexOf(price).toDouble(), price[1]))
            .toList();
        print(historicalData);
      });
    } else {
      //dialog
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCryptoPrices();
    print(historicalData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                height: 100,
                width: 100,
                image: NetworkImage(widget.image),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${widget.price.toString()}  \$",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: LineChart(
                LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        gradient: LinearGradient(colors: [
                          Colors.blue.withOpacity(.7),
                          Colors.blue.withOpacity(.3),
                        ]),
                        spots: historicalData,
                        isCurved: false,
                        color: Colors.white,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      )
                    ],
                    titlesData: const FlTitlesData(
                      show: false,
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              reservedSize: 50,
                              showTitles: true,
                              interval: 100000)),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                        reservedSize: 44,
                        showTitles: false,
                      )),
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(
                        reservedSize: 44,
                        showTitles: false,
                      )),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                        reservedSize: 44,
                        showTitles: false,
                      )),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: true)),
              ),
            )
          ],
        ));
  }
}
