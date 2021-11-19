import 'package:flutter/material.dart';
import 'package:sdm_handal/model/riwayat_cuti_model.dart';
import 'package:nb_utils/nb_utils.dart';

class RiwayatComponent extends StatelessWidget {
  final RiwayatCutiDataModel? cuti;

  RiwayatComponent({this.cuti});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration:
          boxDecorationRoundedWithShadow(16, backgroundColor: Colors.white),
      child: ListTile(
        tileColor: Colors.red,
        enabled: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            boxShape: BoxShape.circle,
            backgroundColor: cuti!.status == 'Disetujui'
                ? Colors.green.withOpacity(0.1)
                : cuti!.status == 'Proses Pengajuan'
                    ? Colors.yellow.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
          ),
          child: Icon(
            cuti!.status == 'Disetujui'
                ? Icons.add_task
                : cuti!.status == 'Proses Pengajuan'
                    ? Icons.alarm_add
                    : Icons.cancel,
            size: 24,
            color: cuti!.status == 'Disetujui'
                ? Colors.green
                : cuti!.status == 'Proses Pengajuan'
                    ? Colors.black87
                    : Colors.red,
          ),
        ),
        title: RichTextWidget(
          list: [
            TextSpan(
              text: '${cuti!.kepentingan}',
              style: primaryTextStyle(color: Colors.black54, size: 14),
            ),
            // TextSpan(
            //   text: '\t${widget.transactionModel!.name!}',
            //   style: boldTextStyle(size: 14),
            // ),
          ],
          maxLines: 1,
        ),
        subtitle: Text('${cuti!.noPengajuan}',
            style: primaryTextStyle(color: Colors.black54, size: 14)),
        trailing: Container(
          width: 80,
          height: 35,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
          child: Text(
            '${cuti!.status}',
            style: boldTextStyle(
                size: 12,
                color: cuti!.status == 'Disetujui'
                    ? Colors.green
                    : cuti!.status == 'Proses Pengajuan'
                        ? Colors.black
                        : Colors.red),
          ),
        ),
      ),
    );
  }
}
