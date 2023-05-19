import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/utils/WAColors.dart';

import '../controller/helpdesk_controller.dart';

class HelpDesk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(HelpdeskController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Helpdesk IT',
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
          centerTitle: true,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/walletApp/wa_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: boxDecorationRoundedWithShadow(16),
                child: Form(
                  key: c.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppTextField(
                        controller: c.permintaanController, // Optional
                        textFieldType: TextFieldType.NAME,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Permintaan Perbaikan tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Permintaan Perbaikan',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppTextField(
                        controller: c.langkahController, // Optional
                        textFieldType: TextFieldType.ADDRESS,
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Langkah sudah dilakukan tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Langkah sudah dilakukan',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppButton(
                        text: 'Kirim',
                        textStyle: boldTextStyle(color: Colors.white),
                        color: WAPrimaryColor,
                        enableScaleAnimation: true,
                        onTap: () {
                          if (c.formKey.currentState!.validate()) {
                            showInDialog(
                              context,
                              builder: (context) => SizedBox(
                                width: Get.width * 0.7,
                                height: Get.height * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'Loading...',
                                      style: boldTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            c.simpanData();
                          }
                        },
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: radius(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.42,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: boxDecorationRoundedWithShadow(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Permintaan Perbaikan',
                      style: boldTextStyle(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => c.isLoading.value
                          ? const Center(
                              child: LoadingData(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: c.helpdeskRes.value.data?.length ?? 0,
                              itemBuilder: ((context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                        c.helpdeskRes.value.data?[index].nama ??
                                            ''),
                                    subtitle: Text(c.helpdeskRes.value
                                            .data?[index].permintaan ??
                                        ''),
                                    trailing: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration:
                                          boxDecorationWithRoundedCorners(
                                        backgroundColor: c.helpdeskRes.value
                                                    .data?[index].status ==
                                                'Selesai'
                                            ? Colors.green
                                            : c.helpdeskRes.value.data?[index]
                                                        .status ==
                                                    'Perbaikan'
                                                ? Colors.greenAccent
                                                : Colors.yellow,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        c.helpdeskRes.value.data?[index]
                                                .status ??
                                            '',
                                        style: boldTextStyle(
                                            color: c.helpdeskRes.value
                                                        .data?[index].status ==
                                                    'Perbaikan'
                                                ? Colors.white
                                                : c
                                                            .helpdeskRes
                                                            .value
                                                            .data?[index]
                                                            .status ==
                                                        'Selesai'
                                                    ? Colors.white
                                                    : Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingData extends StatelessWidget {
  const LoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Loader(),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Sedang memuat data ....',
          style: secondaryTextStyle(),
        ),
      ],
    );
  }
}
