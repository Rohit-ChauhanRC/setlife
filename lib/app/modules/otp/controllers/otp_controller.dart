import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:setlife/app/constants/constants.dart';
import 'package:setlife/app/routes/app_pages.dart';
import 'package:setlife/app/utils/utils.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  //
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final box = GetStorage();

  final RxString _otp = ''.obs;
  String get otp => _otp.value;
  set otp(String str) => _otp.value = str;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxInt _count = 0.obs;
  int get count => _count.value;
  set count(int i) => _count.value = i;

  final RxBool _resend = true.obs;
  bool get resend => _resend.value;
  set resend(bool v) => _resend.value = v;

  @override
  void onInit() async {
    super.onInit();
    mobileNumber = Get.arguments.toString();
    await counter();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _mobileNumber.close();
    _count.close();
    _otp.close();
  }

  Future<void> counter() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (count <= 80) count += 1;
        if (count == 80) {
          resend = true;
          count = 0;
          await resendOtp();
        }
      },
    );
  }

  Future<dynamic> resendOtp() async {
    Utils.closeKeyboard();
    // otp/ValidateOtpusers

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
    count = 0;
    resend = false;
    await counter();
  }

  Future<dynamic> otpVerify() async {
    // otp/OTPValidation
    Utils.closeKeyboard();
    if (!loginFormKey!.currentState!.validate()) {
      return null;
    }

    try {
      var res = await http.post(
        Uri.parse("http://app.maklife.in:8084/api/otp/OTPValidation"),
        body: {
          "MobileNo": mobileNumber,
          "OtpNo": otp,
        },
      );
      // "Login success !"
      if (res.statusCode == 200) {
        circularProgress = true;

        Get.toNamed(Routes.HOME, arguments: mobileNumber);
      } else {
        Utils.showDialog(json.decode(res.body));
      }
      circularProgress = true;
    } catch (e) {
      circularProgress = true;
      Utils.showDialog(e.toString());
    }

    circularProgress = true;
    box.write(Constants.cred, mobileNumber);
    Get.offAllNamed(
      Routes.HOME,
      arguments: mobileNumber,
    );
  }
}
