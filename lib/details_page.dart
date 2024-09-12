import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:networking_lesson/model/crypto_model.dart';

class DetailsPage extends StatefulWidget {
  final CryptoModel crypto;
  String image;
  String name;
  double price;
  final double priceChange24H;

  DetailsPage(
      {super.key,
      required this.name,
      required this.image,
      required this.crypto,
      required this.price,
        required this.priceChange24H,});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<FlSpot> historicalData = [];
  int selectDurationIndex = 0;
  final List<Map<String, dynamic>> chartDuration = [
    {'label': '12 Month', 'days': 365},
    {'label': '6 Month', 'days': 180},
    {'label': '1 Month', 'days': 30},
    {'label': '1 Hours', 'days': 1}
  ];

  void changeChartDuration(int durationIndex) {
    setState(() {
      selectDurationIndex = durationIndex;
    });
  }

  Future<void> fetchCryptoPrices(int duration) async {
    final response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/${widget.crypto.id}/market_chart?vs_currency=usd&days=$duration&interval=daily&precision=0"));
    if (response.statusCode == 200) {
      final List<dynamic> cryptoPrice =
          jsonDecode(response.body.toString())['prices'];
      setState(() {
        historicalData = cryptoPrice
            .map((price) => FlSpot(
                cryptoPrice.indexOf(price).toDouble(), price[1].toDouble()))
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
    fetchCryptoPrices(365);
    print(historicalData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF141239),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF141239),
          // dark background color
          centerTitle: true,
          title: Row(
            children: [
              SizedBox(width: 50,),
              Text(
                "${widget.name.toString()}",
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              SizedBox( width: 10,),
              Image(
                height: 40,
                width: 40,
                image: NetworkImage(widget.image),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                // handle notification icon press
              },
            ),
            SizedBox(
              width: 2,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Real time price",
                  style: TextStyle(color: Colors.white60, fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.trending_up, color: Colors.greenAccent),
              ],
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
                          Colors.red,
                          Colors.green.shade400,
                          Colors.green.shade700
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
            ),
            SizedBox(
              height: 15,
            ), // SizedBox
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < chartDuration.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: ElevatedButton(
                        onPressed: () => changeChartDuration(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: i == selectDurationIndex
                              ? Colors.green
                              : Colors.white12,
                        ),
                        child: Text(
                          chartDuration[i]['label'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ), // ElevatedButton
                    ), // Padding
                ],
              ), // Row
            ), // SingleChildScrollView
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Price',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Text(
                        "\$ ${widget.price.toString()}",  // Hozirgi narx, bu ma'lumotni API bilan integratsiyalash mumkin
                        style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Change (24h)',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Text(
                        '${widget.priceChange24H.toStringAsFixed(2)}%',
                        style: TextStyle(fontSize: 18, color: widget.priceChange24H >= 0 ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

}
