import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdm_handal/controller/rekap_presensi_controller.dart';
import 'package:sdm_handal/model/rekap_presensi_model.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class WACategoriesComponent extends StatefulWidget {
  static String tag = '/WACategoriesComponent';

  final RekapPresensiData? categoryModel;

  WACategoriesComponent({this.categoryModel});

  @override
  WACategoriesComponentState createState() => WACategoriesComponentState();
}

class WACategoriesComponentState extends State<WACategoriesComponent> {
  final c = Get.find<RekapPresensiController>();
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration:
          boxDecorationRoundedWithShadow(16, backgroundColor: Colors.white),
      child: ListTile(
        tileColor: Colors.red,
        enabled: true,
        contentPadding: EdgeInsets.zero,
        title: Text(widget.categoryModel!.nama!, style: boldTextStyle()).onTap(
          () async {
            await c.getGeo(
              id: widget.categoryModel!.id!.toString(),
              tanggal: DateFormat('yyyy-MM-dd').format(
                widget.categoryModel!.jamDatang!,
              ),
            );
          },
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                DateFormat("dd-MM-yyyy HH:mm:ss")
                    .format(widget.categoryModel!.jamDatang!),
                style: secondaryTextStyle()),
            Text(
                DateFormat("dd-MM-yyyy HH:mm:ss")
                    .format(widget.categoryModel!.jamPulang!),
                style: secondaryTextStyle())
          ],
        ).onTap(
          () async {
            await c.getGeo(
              id: widget.categoryModel!.id!.toString(),
              tanggal: DateFormat('yyyy-MM-dd').format(
                widget.categoryModel!.jamDatang!,
              ),
            );
          },
        ),
        leading: waCommonCachedNetworkImage(
          widget.categoryModel!.photo,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ).cornerRadiusWithClipRRect(30).onTap(
          () async {
            await showDialog(
              context: context,
              builder: (_) => imageDialog(
                widget.categoryModel?.nama,
                widget.categoryModel!.photo,
                context,
              ),
            );
          },
        ),
        trailing: Container(
          width: 80,
          height: 35,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(30),
            backgroundColor: widget.categoryModel!.status == 'Tepat Waktu'
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
          ),
          child: Text(
            widget.categoryModel!.shift!,
            maxLines: 1,
            style: boldTextStyle(
                size: 12,
                color: widget.categoryModel!.status == 'Tepat Waktu'
                    ? Colors.green
                    : Colors.red),
          ),
        ),
      ),
    );
  }
}

Widget imageDialog(text, path, context) {
  return Dialog(
    // backgroundColor: Colors.transparent,
    // elevation: 0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: boldTextStyle(),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        waCommonCachedNetworkImage(
          '$path',
          width: 300, height: 500, fit: BoxFit.contain,
          // child: Image.network(
          //   '$path',
          //   fit: BoxFit.contain,
          // ),
        ),
      ],
    ),
  );
}
