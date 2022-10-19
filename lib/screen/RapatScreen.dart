import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sdm_handal/controller/jadwal_rapat_controller.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../utils/uppercase_formater.dart';

class RapatScreen extends StatelessWidget {
  const RapatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JadwalRapatController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Form Absensi Rapat',
              style: boldTextStyle(color: Colors.black, size: 20)),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ).onTap(() {
            finish(context);
          }),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Container(
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Obx(
                    () => ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          lg: 3,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: Alignment.centerLeft,
                            child: Text('Tanggal', style: boldTextStyle()),
                          ).paddingAll(10),
                        ),
                        ResponsiveGridCol(
                          lg: 9,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: const Alignment(0, 0),
                            child: AppTextField(
                              controller: controller.tanggal, // Optional
                              textFieldType: TextFieldType.NAME,
                              readOnly: true,
                              // onTap: () => controller.dateWidget(context),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ).paddingBottom(10),
                        ),
                        ResponsiveGridCol(
                          lg: 3,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: Alignment.centerLeft,
                            child: Text('Rapat', style: boldTextStyle())
                                .paddingAll(10),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 9,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: const Alignment(0, 0),
                            child: AppTextField(
                              controller: controller.rapat, // Optional
                              textFieldType: TextFieldType.NAME,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              validator: (value) {
                                if (value.isEmptyOrNull) {
                                  return 'Rapat tidak boleh kosong';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ).paddingBottom(10),
                        ),
                        ResponsiveGridCol(
                          lg: 3,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: Alignment.centerLeft,
                            child: Text('Nama', style: boldTextStyle())
                                .paddingAll(10),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 9,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: const Alignment(0, 0),
                            child: AppTextField(
                              controller: controller.nama, // Optional
                              textFieldType: TextFieldType.NAME,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              validator: (value) {
                                if (value.isEmptyOrNull) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ).paddingBottom(10),
                        ),
                        ResponsiveGridCol(
                          lg: 3,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: Alignment.centerLeft,
                            child: Text('NRP/Instansi/Jabatan',
                                    style: boldTextStyle())
                                .paddingAll(10),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 9,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: const Alignment(0, 0),
                            child: AppTextField(
                              controller: controller.instansi, // Optional
                              textFieldType: TextFieldType.NAME,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              validator: (value) {
                                if (value.isEmptyOrNull) {
                                  return 'Instansi / Jabatan tidak boleh kosong';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ).paddingBottom(10),
                        ),
                        ResponsiveGridCol(
                          lg: 3,
                          child: Container(
                            // height: Get.height * 0.05,
                            alignment: Alignment.centerLeft,
                            child: Text('Tanda Tangan', style: boldTextStyle())
                                .paddingAll(10),
                          ),
                        ),
                        controller.isSigned.value
                            ? ResponsiveGridCol(
                                lg: 9,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.memory(
                                      controller.image.value as Uint8List),
                                  alignment: Alignment.centerLeft,
                                ).onTap(
                                  () => Get.defaultDialog(
                                    backgroundColor: Colors.grey.shade200,
                                    title: 'Tanda Tangan',
                                    content: Container(
                                      color: Colors.grey.shade200,
                                      child: SfSignaturePad(
                                        key: controller.signaturePadKey,
                                        backgroundColor: Colors.white,
                                        minimumStrokeWidth: 2,
                                        maximumStrokeWidth: 2,
                                      ),
                                      height: 200,
                                      width: 300,
                                    ),
                                    confirm: ElevatedButton(
                                      child: const Text('OK'),
                                      onPressed: () async {
                                        controller.handleSaveButtonPressed();
                                      },
                                    ),
                                    cancel: OutlinedButton(
                                      child: const Text('Batal'),
                                      onPressed: () => Get.back(),
                                      style: OutlinedButton.styleFrom(
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ).copyWith(
                                          elevation:
                                              ButtonStyleButton.allOrNull(0.0)),
                                    ),
                                  ),
                                ),
                              )
                            : ResponsiveGridCol(
                                lg: 9,
                                child: DottedBorderWidget(
                                  child: Container(
                                    color: Colors.grey.shade200,
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Text('Tanda Tangan Disini',
                                          style: boldTextStyle()),
                                    ),
                                  ),
                                ).onTap(
                                  () => Get.defaultDialog(
                                    backgroundColor: Colors.grey.shade200,
                                    title: 'Tanda Tangan',
                                    content: Container(
                                      child: SfSignaturePad(
                                        key: controller.signaturePadKey,
                                        backgroundColor: Colors.white,
                                        minimumStrokeWidth: 2,
                                        maximumStrokeWidth: 2,
                                      ),
                                      height: 200,
                                      width: 300,
                                    ),
                                    confirm: ElevatedButton(
                                      child: const Text('OK'),
                                      onPressed: () async {
                                        controller.handleSaveButtonPressed();
                                      },
                                    ),
                                    cancel: OutlinedButton(
                                      child: const Text('Batal'),
                                      onPressed: () => Get.back(),
                                      style: OutlinedButton.styleFrom(
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ).copyWith(
                                          elevation:
                                              ButtonStyleButton.allOrNull(0.0)),
                                    ),
                                  ),
                                ),
                              ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Container(
                            height: context.isLargeTablet
                                ? Get.height * 0.025
                                : Get.height * 0.025,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              label: const Text('HADIR'),
                              icon: const Icon(LineIcons.file),
                              onPressed: () {
                                if (controller.formKey.currentState!
                                        .validate() &&
                                    !controller.imageBlob.value.isEmptyOrNull) {
                                  controller.kirimRapat();
                                }
                              },
                            ).paddingSymmetric(horizontal: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).paddingSymmetric(
              vertical: 60,
              horizontal:
                  context.isLargeTablet ? Get.width * 0.15 : Get.width * 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
