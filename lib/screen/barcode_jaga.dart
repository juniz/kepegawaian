import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/controller/barcode_jaga_controller.dart';
import 'package:intl/intl.dart';

class BarcodeJaga extends StatelessWidget {
  const BarcodeJaga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarcodeJagaController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('PATROLI',
              style: boldTextStyle(color: Colors.black, size: 20)),
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ).onTap(() {
            finish(context);
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () async {
                  await controller.scanQR();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: TextFormField(
                    controller: controller.tanggalController,
                    readOnly: true,
                    onTap: () {
                      controller.selectDate(context);
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                      contentPadding: EdgeInsets.only(left: 16),
                      hintText: 'Pilih tanggal',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.patroli.value.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Center(
                                          child: Text(
                                              controller
                                                      .patroli
                                                      .value
                                                      .data?[index]
                                                      .departementId ??
                                                  '',
                                              style: boldTextStyle(
                                                  size: 12,
                                                  color: Colors.white)),
                                        ),
                                      )),
                                  title: Text(
                                    controller.patroli.value.data?[index]
                                            .pegawaiId ??
                                        '',
                                    style: boldTextStyle(),
                                  ),
                                  subtitle: Text(
                                    controller.patroli.value.data?[index]
                                            .keterangan ??
                                        '',
                                    style: secondaryTextStyle(),
                                  ),
                                  trailing: Text(
                                    controller.patroli.value.data?[index].jam ??
                                        '',
                                    style: secondaryTextStyle(
                                        weight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KeteranganWidget extends GetWidget<BarcodeJagaController> {
  const KeteranganWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.white70,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller.keteranganController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  hintText: 'Isikan keterangan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            GFButton(
              onPressed: () {
                Get.back();
                controller.kirimPatroli();
              },
              text: "Simpan",
              icon: const Icon(
                Icons.save,
                color: GFColors.PRIMARY,
              ),
              type: GFButtonType.outline,
            ),
          ],
        ),
      ),
    );
  }
}
