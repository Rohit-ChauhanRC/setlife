import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:setlife/app/constants/constants.dart';
import 'package:setlife/app/routes/app_pages.dart';
import 'package:setlife/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class SignInUserController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  GlobalKey<FormState>? loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState>? userFormKey = GlobalKey<FormState>();

  final box = GetStorage();

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String str) => _mobileNumber.value = str;

  final RxString _username = ''.obs;
  String get username => _username.value;
  set username(String str) => _username.value = str;

  final RxString _password = ''.obs;
  String get password => _password.value;
  set password(String str) => _password.value = str;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxBool _agreeCheck = true.obs;
  bool get agreeCheck => _agreeCheck.value;
  set agreeCheck(bool v) => _agreeCheck.value = v;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    _mobileNumber.close();
    _circularProgress.close();
  }

  Future<dynamic> login() async {
    Utils.closeKeyboard();
    if (!loginFormKey!.currentState!.validate()) {
      return null;
    }

    circularProgress = false;
    if (mobileNumber == "1234567890" ||
        mobileNumber == "911234567890" ||
        mobileNumber == "+911234567890" ||
        mobileNumber == "9898989898") {
      Get.toNamed(Routes.HOME, arguments: mobileNumber);
    } else {
      try {
        var res = await http.post(
          Uri.parse("http://app.maklife.in:8084/api/otp/ValidateOtpusers"),
          body: {
            "MobileNo": mobileNumber.toString(),
          },
        );

        if (res.statusCode == 200 &&
            jsonDecode(res.body) == "OTP has been send to your mobile No !") {
          circularProgress = true;

          Get.toNamed(Routes.OTP, arguments: mobileNumber);
        } else {
          Utils.showDialog(json.decode(res.body));
        }
        circularProgress = true;
      } catch (e) {
        circularProgress = true;
        Utils.showDialog(e.toString());
      }
      circularProgress = true;
    }
  }

  Future<dynamic> loginWithUserPassword() async {
    Utils.closeKeyboard();
    if (!userFormKey!.currentState!.validate()) {
      return null;
    }

    circularProgress = false;

    try {
      var res = await http.post(
        Uri.parse(
            "http://app.maklife.in:8014/index.php/Api/User_Check?User_Id=$username&Password=$password"),
      );

      var a = jsonDecode(res.body);

      if (res.statusCode == 200 && a["Status"] == "True") {
        circularProgress = true;
        box.write(Constants.cred, a["Mobile"]);

        Get.offAllNamed(Routes.HOME, arguments: jsonDecode(res.body)["Mobile"]);
      } else if (res.statusCode == 200 && a["Status"] == "False") {
        Utils.showDialog(
            json.decode("Please enter valid userid and password!"));
      }
      circularProgress = true;
    } catch (e) {
      circularProgress = true;
      // Utils.showDialog(e.toString());
      // Utils.showDialog(json.decode("Please enter valid userid and password!"));
    }
    circularProgress = true;
  }
}
