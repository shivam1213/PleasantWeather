import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../CustomWidgets/Constant.dart';
import '../CustomWidgets/CustomWidget.dart';

class Sensor extends StatefulWidget {
  const Sensor({super.key});

  @override
  State<Sensor> createState() => _SensorState();
}

class _SensorState extends State<Sensor> {
  Map getLiveSensorData = {};
  Map predictionSensorData = {};
  List getRecentSensorList = [];
  List predictionSensorList = [];
  List<String> imageList = [
    'assets/images/nature.jpg',
    'assets/images/sensorsnow.jpg',
    'assets/images/thunderstrom.jpg',
  ];

  @override
  void initState() {
    setState(() {
      liveSensorData();
      predictionData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomWidget.appBars('Sensor'),
        body: SingleChildScrollView(
          child: Scrollbar(
            trackVisibility: true,
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
                        'Live Sensor Data')),
                const SizedBox(
                  height: 10,
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
                          const Text('Date'),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('|'),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(getLiveSensorData['Date'].toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Time '),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('|'),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(getLiveSensorData['TimeOfDay'].toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Temperature'),
                          const SizedBox(
                            width: 18,
                          ),
                          const Text('|'),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(getLiveSensorData['Temp'] == null
                              ? '-'
                              : getLiveSensorData['Temp'].toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Humidity'),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text('|'),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(getLiveSensorData['Humidity'] == null
                              ? '-'
                              : getLiveSensorData['Humidity']
                                  .toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const Text('Barometric Pressure'),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text('|'),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(getLiveSensorData['Barometric_pressure']
                              .toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Co2 Sensor Temperature'),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text('|'),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(getLiveSensorData['Co2_sensor_temperature'] ==
                                  null
                              ? '-'
                              : getLiveSensorData['Co2_sensor_temperature']
                                  .toStringAsFixed(2)),
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
                        itemCount: getRecentSensorList.length,
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
                                      boxShadow: [
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
                                              const Text('Date'),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const Text('|'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(getLiveSensorData['Date']
                                                  .toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Text('Time '),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const Text('|'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                  getLiveSensorData['TimeOfDay']
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
                                                width: 18,
                                              ),
                                              const Text('|'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(getLiveSensorData['Temp'] ==
                                                      null
                                                  ? '-'
                                                  : getLiveSensorData['Temp']
                                                      .toStringAsFixed(2)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Text('Humidity'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const Text('|'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(getLiveSensorData[
                                                          'Humidity'] ==
                                                      null
                                                  ? '-'
                                                  : getLiveSensorData[
                                                          'Humidity']
                                                      .toStringAsFixed(2)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            children: [
                                              const Text('Barometric Pressure'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const Text('|'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(getLiveSensorData[
                                                      'Barometric_pressure']
                                                  .toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                  'Co2 Sensor Temperature'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const Text('|'),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(getLiveSensorData[
                                                          'Co2_sensor_temperature'] ==
                                                      null
                                                  ? '-'
                                                  : getLiveSensorData[
                                                          'Co2_sensor_temperature']
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
                          Text('Temperature'),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            color: Colors.blue,
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
                          Text('Humidity'),
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
                  height: 40,
                ),
                AspectRatio(
                  aspectRatio: 2,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getRecentSensorList
                              .asMap()
                              .entries
                              .map((entry) => FlSpot(
                            entry.key.toDouble(),
                            entry.value['Temp'].toDouble(),
                          ))
                              .toList(),
                          isCurved: true,
                          colors: [Colors.blue],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: getRecentSensorList
                              .asMap()
                              .entries
                              .map((entry) => FlSpot(
                            entry.key.toDouble(),
                            entry.value['Humidity'].toDouble(),
                          ))
                              .toList(),
                          isCurved: true,
                          colors: [Colors.red],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      minX: 0,
                      maxX: 120, // Set the maximum value for X-axis
                      minY: 0,
                      maxY: 100, // Set the maximum value for Y-axis
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: CustomWidget.headerTextforAllContent(
                        'Prediction Graph')),
                AspectRatio(
                  aspectRatio: 2,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(show: true),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 1),
                      ),
                      minX: 0,
                      maxX: 25,
                      minY: 0,
                      maxY: 100,
                      lineBarsData: [
                        LineChartBarData(
                          spots:
                              predictionSensorList.asMap().entries.map((entry) {
                            final humidityValue = double.tryParse(
                                entry.value['predicted_humidity']);

                            if (humidityValue != null &&
                                !humidityValue.isNaN &&
                                !humidityValue.isInfinite) {
                              return FlSpot(
                                entry.key.toDouble(),
                                humidityValue,
                              );
                            } else {
                              // Handle the case where the value is NaN or Infinity
                              return FlSpot(entry.key.toDouble(),
                                  0.0); // Replace with an appropriate default value
                            }
                          }).toList(),
                          isCurved: true,
                          colors: [Colors.blue],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: predictionSensorList.asMap().entries.map((entry) {
                            final temperatureValue =
                            double.tryParse(entry.value['predicted_temp']);
                            if (temperatureValue != null &&
                                !temperatureValue.isNaN &&
                                !temperatureValue.isInfinite) {
                              // Convert temperature to Celsius
                              double celsiusTemperature = (temperatureValue - 32) * 5 / 9;
                              print(celsiusTemperature);
                              return FlSpot(
                                entry.key.toDouble(),
                                celsiusTemperature,
                              );
                            } else {
                              // Handle the case where the value is NaN or Infinity
                              return FlSpot(entry.key.toDouble(), 0.0); // Replace with an appropriate default value
                            }
                          }).toList(),
                          isCurved: true,
                          colors: [Colors.orange],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ), // Add prediction lines here
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }

  Future<void> liveSensorData() async {
    try {
      var res = await http.get(Uri.parse(Constant.sensorUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      var getDataResponse = jsonDecode(res.body);
      var response = getDataResponse;
      print(getDataResponse);

      // Filter data for the current date
      DateTime currentDate = DateTime.now();
      String formattedCurrentDate =
          "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";

      setState(() {
        getRecentSensorList = response['data']
            .where((data) => data['Date'] == formattedCurrentDate)
            .toList();
        if (getRecentSensorList.isNotEmpty) {
          getLiveSensorData = getRecentSensorList.first;
        }
      });
      print(getRecentSensorList.length);
    } catch (e) {
      // Handle the error
      print('Error fetching data: $e');
    }
  }


  Future<void> predictionData() async {
    try {
      var res = await http.get(Uri.parse(Constant.predictionUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      var getPredictionResponse = jsonDecode(res.body);
      var prediction = getPredictionResponse['predictions'];
      print(getPredictionResponse);
      setState(() {
        predictionSensorList = prediction;
      });
    } catch (e) {
      //print('error');
    }
  }
}
