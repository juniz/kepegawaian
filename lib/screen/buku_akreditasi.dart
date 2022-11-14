import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sdm_handal/controller/buku_akreditasi_controller.dart';

class BukuAkreditasi extends StatelessWidget {
  const BukuAkreditasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BukuAkreditasiController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('BUKU SAKU AKREDITASI',
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
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      PdfViewPinch(
                        controller: controller.pdfController,
                        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                          options: const DefaultBuilderOptions(
                            loaderSwitchDuration: Duration(seconds: 1),
                            transitionBuilder: SomeWidget.transitionBuilder,
                          ),
                          documentLoaderBuilder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          pageLoaderBuilder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          errorBuilder: (_, error) =>
                              Center(child: Text(error.toString())),
                          builder: SomeWidget.builder,
                        ),
                      ).flexible(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.pdfController.previousPage(
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 100));
                            },
                            child: const Icon(Icons.arrow_back),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.bottomSheet(
                                Container(
                                  width: Get.width,
                                  height: Get.height,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        height: 50,
                                        decoration:
                                            boxDecorationWithRoundedCorners(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                        child: Row(
                                          children: [
                                            8.width,
                                            const Icon(Icons.search),
                                            8.width,
                                            Expanded(
                                              child: TextField(
                                                controller: controller.query,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Cari halaman',
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value) =>
                                                    controller.search(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      16.height,
                                      Obx(
                                        () => ListView.builder(
                                          itemBuilder: ((context, index) {
                                            return Container(
                                                margin: const EdgeInsets.all(2),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text(
                                                  controller
                                                      .daftarIsi[index].judul!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ).onTap(
                                                  () {
                                                    Get.back();
                                                    controller.pdfController
                                                        .animateToPage(
                                                      pageNumber: controller
                                                              .daftarIsi[index]
                                                              .halaman! +
                                                          1,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                    );
                                                  },
                                                ),
                                                decoration:
                                                    boxDecorationRoundedWithShadow(
                                                        2));
                                          }),
                                          itemCount:
                                              controller.daftarIsi.length,
                                        ).expand(),
                                      ),
                                    ],
                                  ),
                                  decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: Colors.grey.shade200,
                                    boxShape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.bookmark),
                            label: const Text('DAFTAR ISI'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.pdfController.nextPage(
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 100));
                            },
                            child: const Icon(Icons.arrow_forward),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

//  Need static methods for builders arguments
class SomeWidget {
  static Widget builder(
    BuildContext context,
    PdfViewPinchBuilders builders,
    PdfLoadingState state,
    WidgetBuilder loadedBuilder,
    PdfDocument? document,
    Exception? loadingError,
  ) {
    final Widget content = () {
      switch (state) {
        case PdfLoadingState.loading:
          return KeyedSubtree(
            key: const Key('pdfx.root.loading'),
            child: builders.documentLoaderBuilder?.call(context) ??
                const SizedBox(),
          );
        case PdfLoadingState.error:
          return KeyedSubtree(
            key: const Key('pdfx.root.error'),
            child: builders.errorBuilder?.call(context, loadingError!) ??
                Center(child: Text(loadingError.toString())),
          );
        case PdfLoadingState.success:
          return KeyedSubtree(
            key: Key('pdfx.root.success.${document!.id}'),
            child: loadedBuilder(context),
          );
      }
    }();

    final defaultBuilder =
        builders as PdfViewPinchBuilders<DefaultBuilderOptions>;
    final options = defaultBuilder.options;

    return AnimatedSwitcher(
      duration: options.loaderSwitchDuration,
      transitionBuilder: options.transitionBuilder,
      child: content,
    );
  }

  static Widget transitionBuilder(Widget child, Animation<double> animation) =>
      FadeTransition(opacity: animation, child: child);

  static PhotoViewGalleryPageOptions pageBuilder(
    BuildContext context,
    Future<PdfPageImage> pageImage,
    int index,
    PdfDocument document,
  ) =>
      PhotoViewGalleryPageOptions(
        imageProvider: PdfPageImageProvider(
          pageImage,
          index,
          document.id,
        ),
        minScale: PhotoViewComputedScale.contained * 1,
        maxScale: PhotoViewComputedScale.contained * 3.0,
        initialScale: PhotoViewComputedScale.contained * 1.0,
        heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
      );
}
