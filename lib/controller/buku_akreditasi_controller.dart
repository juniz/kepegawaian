import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:internet_file/internet_file.dart';

import '../api/api_connection.dart';
import '../model/buku_akreditasi_model.dart';

class BukuAkreditasiController extends GetxController {
  final provider = Get.put(ApiConnection());
  late PdfControllerPinch pdfController;
  var bukuAkreditasi = BukuAkreditasi().obs;
  final isLoading = true.obs;
  var daftarIsi = <DaftarIsi>[].obs;
  var tempDaftarIsi = <DaftarIsi>[].obs;
  late TextEditingController query;

  @override
  Future<void> onInit() async {
    await getBuku();

    query = TextEditingController();

    super.onInit();
  }

  void search() {
    if (query.text.isNotEmpty) {
      daftarIsi.value = tempDaftarIsi.value
          .where((element) =>
              element.judul!.toLowerCase().contains(query.text.toLowerCase()))
          .toList();
    } else {
      daftarIsi.value = tempDaftarIsi;
    }
  }

  Future<void> getBuku() async {
    // isLoading(true);
    Future.delayed(
      Duration.zero,
      () => provider.getBukuAkreditasi().then((value) {
        bukuAkreditasi.value = bukuAkreditasiFromJson(value.bodyString!);
        daftarIsi.value = bukuAkreditasi.value.daftarIsi!;
        tempDaftarIsi.value = daftarIsi.value;
        pdfController = PdfControllerPinch(
          document: PdfDocument.openData(
              InternetFile.get(bukuAkreditasi.value.file!)),
          viewportFraction: 1.0,
        );
        isLoading(false);
      }),
    );
  }

  //function search list
  List<DaftarIsi> searchList(String query) {
    List<DaftarIsi> searchList = [];
    searchList.addAll(bukuAkreditasi.value.daftarIsi!);
    if (query.isNotEmpty) {
      List<DaftarIsi> dummyListData = [];
      for (var item in searchList) {
        if (item.judul!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      searchList.clear();
      searchList.addAll(dummyListData);
    }
    return searchList;
  }
}
