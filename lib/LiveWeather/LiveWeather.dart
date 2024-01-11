import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../CustomWidgets/Constant.dart';
import '../CustomWidgets/CustomWidget.dart';

class LiveWeather extends StatefulWidget {
  const LiveWeather({super.key});

  @override
  State<LiveWeather> createState() => _LiveWeatherState();
}

class _LiveWeatherState extends State<LiveWeather> {
  Map getLiveWeather = {};
  List getRecentWeatherList = [];
  Map getCurrentData = {};

  List<String> imageList = [
    'assets/images/liveSnow.jpg',
    'assets/images/liveweatherthunderstrom.jpg',
    'assets/images/trees.jpg',
  ];

  @override
  void initState() {
    setState(() {
      liveWeather();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomWidget.appBars('Live Weather'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: imageList.map((String imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          // Adjust the value as needed
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: CustomWidget.headerTextforAllContent(
                      'Live Weather Data')),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Date'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getLiveWeather['datetime'].toString() + ''),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Time'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getCurrentData['datetime'].toString() +
                            ' ' +
                            'hrs'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Temperature'),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getCurrentData['temp'].toString() +
                            ' ' +
                            '\u00B0' +
                            'C'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Humidity'),
                        const SizedBox(
                          width: 18,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getCurrentData['humidity'] == null
                            ? '-'
                            : getCurrentData['humidity'].toStringAsFixed(2)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Precipitation '),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getCurrentData['precip'] == null
                            ? '-'
                            : getCurrentData['precip'].toStringAsFixed(2)),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Text('Snow'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getCurrentData['snow'].toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Pressure'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(getCurrentData['pressure'] == null
                            ? '-'
                            : getCurrentData['pressure'].toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: CustomWidget.headerTextforAllContent('Recent Data')),
              Scrollbar(
                trackVisibility: true,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      shrinkWrap: true,
                      itemCount: getRecentWeatherList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Stack(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 3.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Hours'),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Text('|'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(getRecentWeatherList[index]
                                                    ['datetime']
                                                .toString()),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Temperature'),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Text('|'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                                '${getRecentWeatherList[index]['temp']} \u00B0C'),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Humidity'),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            const Text('|'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(getRecentWeatherList[index]
                                                        ['humidity'] ==
                                                    null
                                                ? '-'
                                                : getRecentWeatherList[index]
                                                        ['humidity']
                                                    .toStringAsFixed(2)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Precipitation'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text('|'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(getRecentWeatherList[index]
                                                        ['precip'] ==
                                                    null
                                                ? '-'
                                                : getRecentWeatherList[index]
                                                        ['precip']
                                                    .toStringAsFixed(2)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Snow'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text('|'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(getRecentWeatherList[index]
                                                    ['snow']
                                                .toString()),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Text('Pressure'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text('|'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(getRecentWeatherList[index]
                                                        ['pressure'] ==
                                                    null
                                                ? '-'
                                                : getRecentWeatherList[index]
                                                        ['pressure']
                                                    .toStringAsFixed(2)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: CustomWidget.headerTextforAllContent('Graph')),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('X-Axis '),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Humidity'),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.lightBlueAccent,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Y-Axis '),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('|'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Temperature'),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 450,
                height: 300,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(showTitles: true, margin: 8, reservedSize: 30),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          margin: 8,
                          reservedSize: 30,
                          getTitles: (value) {
                            // Customize X-axis labels based on your data
                            int xindex = value.toInt();
                            if (xindex >= 0 && xindex < getRecentWeatherList.length) {
                              return getRecentWeatherList[xindex]['humidity'].toString();
                            }
                            return '';
                          },
                        ),
                        rightTitles: SideTitles(
                          showTitles: true,
                          margin: 8,
                          reservedSize: 30,
                          getTitles: (value) {
                            // Customize Y-axis labels based on your data
                            int yindex = value.toInt();
                            if (yindex >= 0 && yindex < getRecentWeatherList.length) {
                              return getRecentWeatherList[yindex]['temp'].toString();
                            }
                            return value.toString();
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getRecentWeatherList
                              .asMap()
                              .entries
                              .map((entry) => FlSpot(entry.key.toDouble(), entry.value['humidity'].toDouble()))
                              .toList(),
                          isCurved: true,
                          colors: [Colors.blue],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: getRecentWeatherList
                              .asMap()
                              .entries
                              .map((entry) => FlSpot(entry.key.toDouble(), entry.value['temp'].toDouble()))
                              .toList(),
                          isCurved: true,
                          colors: [Colors.red],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                // child: LineChart(
                //   swapAnimationDuration: const Duration(milliseconds: 500),
                //   swapAnimationCurve: Curves.linear,
                //   LineChartData(
                //     gridData: FlGridData(show: true),
                //     titlesData: FlTitlesData(show: true),
                //     borderData: FlBorderData(
                //       show: true,
                //       border: Border.all(
                //           color: const Color(0xff37434d), width: 1),
                //     ),
                //     minX: 0,
                //     maxX: getRecentWeatherList.length.toDouble(),
                //     minY: 0,
                //     maxY: 100,
                //     lineBarsData: [
                //       LineChartBarData(
                //         spots: getRecentWeatherList
                //             .asMap()
                //             .entries
                //             .where((entry) {
                //               final humidityValue = entry.value['humidity'];
                //
                //               // Filter out non-finite values
                //               return humidityValue != null &&
                //                   humidityValue is double &&
                //                   humidityValue.isFinite;
                //             })
                //             .map((entry) => FlSpot(
                //                   entry.key.toDouble(),
                //                   double.parse(entry.value['humidity']
                //                       .toStringAsFixed(2)),
                //                 ))
                //             .toList(),
                //         isCurved: true,
                //         colors: [Colors.blue],
                //         dotData: FlDotData(show: false),
                //         belowBarData: BarAreaData(show: false),
                //       ),
                //       LineChartBarData(
                //         spots: getRecentWeatherList
                //             .asMap()
                //             .entries
                //             .map((entry) {
                //           final tempValue = entry.value['temp'];
                //
                //           // Check if humidityValue is a finite number
                //           if (tempValue is double && tempValue.isFinite) {
                //             return FlSpot(
                //               entry.key.toDouble(),
                //               double.parse(tempValue.toStringAsFixed(2)),
                //             );
                //           } else {
                //             // Handle cases where humidityValue is Infinity or NaN
                //             // You might want to set a default value or handle it in a way that suits your application
                //             return FlSpot(entry.key.toDouble(),
                //                 0.0); // Change 0.0 to your desired default value
                //           }
                //         }).toList(),
                //         isCurved: true,
                //         colors: [Colors.yellow],
                //         dotData: FlDotData(show: false),
                //         belowBarData: BarAreaData(show: false),
                //       ),
                //
                //       // Add prediction lines here
                //     ],
                //   ),
                // ),
            ],
          ),
        ));
  }

  Future<void> liveWeather() async {
    try {
      var res = await http.get(Uri.parse(Constant.weatherUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      var getDataResponse = jsonDecode(res.body);
      setState(() {
        getLiveWeather = getDataResponse['data']['days'][0];
        getRecentWeatherList = getLiveWeather['hours'];
        getCurrentData = getDataResponse['data']['currentConditions'];
      });
    } catch (e) {}
  }
}
