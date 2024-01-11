import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../CustomWidgets/CustomWidget.dart';
import '../LiveWeather/LiveWeather.dart';
import '../SensorScreens/Sensor.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  List<String> imageList = [
    'assets/images/dashboardsnow.jpg',
    'assets/images/dashboardthunderstrom.jpg',
    'assets/images/irelandtheme.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.appBars('Mt. Pleasant Weather'),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: imageList.map((String imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 5.0, // Border width
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.transparent, // Shadow color
                        offset: Offset(0, 3), // Offset of the shadow (X, Y)
                        blurRadius: 6, // Blur radius
                        spreadRadius: 0, // Spread radius
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const Sensor());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(5, 5, 10, 5)),
                        Text(
                          'Sensor',
                          style: TextStyle(fontSize: 25),
                        ),

                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 5.0, // Border width
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.transparent, // Shadow color
                        offset: Offset(0, 3), // Offset of the shadow (X, Y)
                        blurRadius: 6, // Blur radius
                        spreadRadius: 0, // Spread radius
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const LiveWeather());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(5, 5, 10, 5)),
                        Text(
                          'Live Weather',
                          style: TextStyle(fontSize: 25),
                        ),

                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
