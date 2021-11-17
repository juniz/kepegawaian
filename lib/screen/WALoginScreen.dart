import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sdm_handal/controller/login_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sdm_handal/screen/WARegisterScreen.dart';
import 'package:sdm_handal/utils/WAColors.dart';
import 'package:sdm_handal/utils/WAWidgets.dart';

import 'WAEditProfileScreen.dart';

class WALoginScreen extends StatefulWidget {
  static String tag = '/WALoginScreen';

  @override
  WALoginScreenState createState() => WALoginScreenState();
}

class WALoginScreenState extends State<WALoginScreen> {
  final c = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/walletApp/wa_bg.jpg'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              60.height,
              Text("SDM Handal", style: boldTextStyle(size: 24)),
              Container(
                margin: EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      margin: EdgeInsets.only(top: 55.0),
                      decoration: boxDecorationWithShadow(
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Text("Username",
                                    style: boldTextStyle(size: 14)),
                                8.height,
                                AppTextField(
                                  decoration: waInputDecoration(
                                      hint: 'Masukkan username',
                                      prefixIcon: Icons.person_outline),
                                  textFieldType: TextFieldType.EMAIL,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: c.emailController,
                                  focus: c.emailFocusNode,
                                  nextFocus: c.passWordFocusNode,
                                ),
                                16.height,
                                Text("Password",
                                    style: boldTextStyle(size: 14)),
                                8.height,
                                AppTextField(
                                  decoration: waInputDecoration(
                                      hint: 'Masukkan password',
                                      prefixIcon: Icons.lock_outline),
                                  suffixIconColor: WAPrimaryColor,
                                  textFieldType: TextFieldType.PASSWORD,
                                  isPassword: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: c.passwordController,
                                  focus: c.passWordFocusNode,
                                ),
                                16.height,
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: Text("Forgot password?",
                                //       style: primaryTextStyle()),
                                // ),
                                30.height,
                                AppButton(
                                        text: "Masuk",
                                        color: WAPrimaryColor,
                                        textColor: Colors.white,
                                        shapeBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        width: Get.width,
                                        onTap: () async {
                                          if (c.emailController.text.isEmpty) {
                                            CoolAlert.show(
                                              context: context,
                                              backgroundColor: WAPrimaryColor,
                                              confirmBtnColor: WAPrimaryColor,
                                              type: CoolAlertType.warning,
                                              title:
                                                  'Username tidak boleh kosong',
                                            );
                                          } else if (c.passwordController.text
                                              .isEmpty) {
                                            CoolAlert.show(
                                              context: context,
                                              backgroundColor: WAPrimaryColor,
                                              confirmBtnColor: WAPrimaryColor,
                                              type: CoolAlertType.warning,
                                              title:
                                                  'Password tidak boleh kosong',
                                            );
                                          } else {
                                            await c.login();
                                          }
                                          // WAEditProfileScreen(
                                          //         isEditProfile: false)
                                          //     .launch(context);
                                        })
                                    .paddingOnly(
                                        left: Get.width * 0.1,
                                        right: Get.width * 0.1),
                                30.height,
                                // Container(
                                //   width: 200,
                                //   child: Row(
                                //     children: [
                                //       Divider(thickness: 2).expand(),
                                //       8.width,
                                //       Text('or',
                                //           style: boldTextStyle(
                                //               size: 16, color: Colors.grey)),
                                //       8.width,
                                //       Divider(thickness: 2).expand(),
                                //     ],
                                //   ),
                                // ).center(),
                                // 30.height,
                                // Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       decoration:
                                //           boxDecorationRoundedWithShadow(16),
                                //       padding: EdgeInsets.all(16),
                                //       child: Image.asset(
                                //           'images/walletApp/wa_facebook.png',
                                //           width: 40,
                                //           height: 40),
                                //     ),
                                //     30.width,
                                //     Container(
                                //       decoration:
                                //           boxDecorationRoundedWithShadow(16),
                                //       padding: EdgeInsets.all(16),
                                //       child: Image.asset(
                                //           'images/walletApp/wa_google_logo.png',
                                //           width: 40,
                                //           height: 40),
                                //     ),
                                //   ],
                                // ).center(),
                                // 30.height,
                                // Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text('Don\'t have an account?',
                                //         style: primaryTextStyle(
                                //             color: Colors.grey)),
                                //     4.width,
                                //     Text('Register here',
                                //         style:
                                //             boldTextStyle(color: Colors.black)),
                                //   ],
                                // ).onTap(() {
                                //   WARegisterScreen().launch(context);
                                // }).center(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: boxDecorationRoundedWithShadow(30),
                      child: Image.asset(
                        'images/walletApp/logo_rsbnganjuk.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
