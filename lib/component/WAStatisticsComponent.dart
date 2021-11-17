import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';

class WAStatisticsComponent extends StatefulWidget {
  static String tag = '/WAStatisticsComponent';

  @override
  WAStatisticsComponentState createState() => WAStatisticsComponentState();
}

class WAStatisticsComponentState extends State<WAStatisticsComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widgetMenuButton(
          title: "Cuti",
          image: 'images/walletApp/wa_up_right.png',
          color: const Color(0xFF6C56F9),
          page: '/cuti',
        ).expand(),
        16.width,
        widgetMenuButton(
          title: "Izin",
          image: 'images/walletApp/wa_down_left.png',
          color: const Color(0xFFFF7426),
          page: '/izin',
        ).expand(),
      ],
    ).paddingOnly(left: 16, right: 16);
  }
}
