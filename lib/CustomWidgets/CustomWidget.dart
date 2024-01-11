import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CustomWidget {
  static AppBar appBars(String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.white10, Colors.lightBlueAccent],
          ),
        ),
      ),
    );
  }

  static Container backGroundColor(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height ,
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.white, Colors.lightBlueAccent])),
    );
  }

  static Container forDashboardTabs(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomWidget.forDashboardTabs (text),
              ],
            ),
            const Row(
              children: [
                Icon(
                  LineIcons.angleRight,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ],
        ));
  }
  static Column headerTextforAllContent(
      String text,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            //color: MainColor.HeaderTextColor,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          color: Colors.grey,
          width: double.infinity,
          height: 0.5,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

}
