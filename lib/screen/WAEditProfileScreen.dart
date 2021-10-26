import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kepegawaian/controller/profile_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kepegawaian/screen/WAAddCreditionalScreen.dart';
import 'package:kepegawaian/utils/WAColors.dart';
import 'package:kepegawaian/utils/WADataGenerator.dart';
import 'package:kepegawaian/utils/WAWidgets.dart';

class WAEditProfileScreen extends StatefulWidget {
  static String tag = '/WAEditProfileScreen';
  final isEditProfile;

  WAEditProfileScreen({this.isEditProfile});

  @override
  WAEditProfileScreenState createState() => WAEditProfileScreenState();
}

class WAEditProfileScreenState extends State<WAEditProfileScreen> {
  final c = Get.find<ProfileController>();
  var fullNameController = TextEditingController();
  var contactNumberController = TextEditingController();
  var tglLahirController = TextEditingController();
  var jnsKelaminController = TextEditingController();
  var alamatController = TextEditingController();
  var pendidikanController = TextEditingController();
  var departmentController = TextEditingController();
  var bidangController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode tglLahirFocusNode = FocusNode();
  FocusNode jnsKelaminFocusNode = FocusNode();
  FocusNode alamatFocusNode = FocusNode();
  FocusNode pendidikanFocusNode = FocusNode();
  FocusNode departementFocusNode = FocusNode();
  FocusNode bidangFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    fullNameController.text = c.dataBiodata.value.nama!;
    contactNumberController.text = c.dataBiodata.value.noKtp!;
    tglLahirController.text = c.dataBiodata.value.tmpLahir! +
        ', ' +
        DateFormat('d MMMM yyyy').format(c.dataBiodata.value.tglLahir!);
    jnsKelaminController.text = c.dataBiodata.value.jk!;
    alamatController.text = c.dataBiodata.value.alamat!;
    pendidikanController.text = c.dataBiodata.value.pendidikan!;
    departmentController.text = c.dataBiodata.value.departemen!;
    bidangController.text = c.dataBiodata.value.bidang!;
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(Icons.arrow_back),
          ).onTap(() {
            finish(context);
          }),
          centerTitle: true,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/walletApp/wa_bg.jpg'),
                  fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                padding:
                    EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                width: Get.width,
                height: Get.height,
                decoration: boxDecorationWithShadow(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Biodata', style: boldTextStyle(size: 18)),
                      16.height,
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Lengkap',
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your full name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: fullNameController,
                              focus: fullNameFocusNode,
                              readOnly: true,
                            ),
                            16.height,
                            Text('Alamat', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Alamat',
                              ),
                              textFieldType: TextFieldType.ADDRESS,
                              keyboardType: TextInputType.name,
                              maxLines: 2,
                              controller: alamatController,
                              focus: alamatFocusNode,
                              readOnly: true,
                            ),
                            16.height,
                            Text('No KTP', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your full name here',
                              ),
                              textFieldType: TextFieldType.PHONE,
                              keyboardType: TextInputType.phone,
                              controller: contactNumberController,
                              focus: contactNumberFocusNode,
                              readOnly: true,
                            ),
                            16.height,
                            Text('Tanggal Lahir',
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Tanggal Lahir',
                              ),
                              textFieldType: TextFieldType.OTHER,
                              keyboardType: TextInputType.datetime,
                              controller: tglLahirController,
                              focus: tglLahirFocusNode,
                              readOnly: true,
                            ),
                            // Row(
                            //   children: [
                            //     DropdownButtonFormField(
                            //       isExpanded: true,
                            //       decoration: waInputDecoration(hint: "Date"),
                            //       items: List.generate(31, (index) {
                            //         return DropdownMenuItem(
                            //             child: Text('${index + 1}',
                            //                 style: secondaryTextStyle()),
                            //             value: index + 1);
                            //       }),
                            //       onChanged: (value) {},
                            //     ).expand(),
                            //     16.width,
                            //     DropdownButtonFormField(
                            //       isExpanded: true,
                            //       decoration: waInputDecoration(hint: "Month"),
                            //       items: waMonthList.map((String? value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(value!,
                            //               style: secondaryTextStyle()),
                            //         );
                            //       }).toList(),
                            //       onChanged: (value) {
                            //         //
                            //       },
                            //     ).expand(),
                            //     16.width,
                            //     DropdownButtonFormField(
                            //       isExpanded: true,
                            //       decoration: waInputDecoration(hint: "Year"),
                            //       items: waYearList.map((String? value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(value!,
                            //               style: secondaryTextStyle()),
                            //         );
                            //       }).toList(),
                            //       onChanged: (value) {
                            //         //
                            //       },
                            //     ).expand(),
                            //   ],
                            // ),
                            16.height,
                            Text('Jenis Kelamin', style: boldTextStyle()),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your full name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: jnsKelaminController,
                              focus: jnsKelaminFocusNode,
                              readOnly: true,
                            ),
                            Text('Pendidikan', style: boldTextStyle()),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Pendidikan',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: pendidikanController,
                              focus: pendidikanFocusNode,
                              readOnly: true,
                            ),
                            16.height,
                            Text('Departement', style: boldTextStyle()),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Departement',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: departmentController,
                              focus: departementFocusNode,
                              readOnly: true,
                            ),
                            16.height,
                            Text('Bidang', style: boldTextStyle()),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Bidang',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: bidangController,
                              focus: bidangFocusNode,
                              readOnly: true,
                            ),
                            16.height,
                            // DropdownButtonFormField(
                            //   isExpanded: true,
                            //   decoration:
                            //       waInputDecoration(hint: "Select your gender"),
                            //   items: <String>['Pria', 'Wanita']
                            //       .map((String value) {
                            //     return new DropdownMenuItem<String>(
                            //       value: c.dataBiodata.value.jk,
                            //       child:
                            //           Text(value, style: secondaryTextStyle()),
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     //
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      16.height,
                      // AppButton(
                      //   color: WAPrimaryColor,
                      //   width: Get.width,
                      //   child: Text('Continue',
                      //       style: boldTextStyle(color: Colors.white)),
                      //   onTap: () {
                      //     if (widget.isEditProfile) {
                      //       finish(context);
                      //     } else {
                      //       WAAddCredentialScreen().launch(context);
                      //     }
                      //   },
                      // ).cornerRadiusWithClipRRect(30).paddingOnly(
                      //     left: Get.width * 0.1, right: Get.width * 0.1),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        color: WAPrimaryColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Icon(Icons.person, color: WAPrimaryColor, size: 60),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                      decoration: BoxDecoration(
                          color: WAPrimaryColor, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingTop(60),
        ),
      ),
    );
  }
}
