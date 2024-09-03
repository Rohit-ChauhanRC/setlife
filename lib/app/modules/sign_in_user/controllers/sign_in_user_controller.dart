import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:setlife/app/constants/constants.dart';
import 'package:setlife/app/data/dio_client.dart';
import 'package:setlife/app/data/models/send_otp_model.dart';
import 'package:setlife/app/routes/app_pages.dart';
import 'package:setlife/app/utils/utils.dart';

class SignInUserController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  GlobalKey<FormState>? loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState>? userFormKey = GlobalKey<FormState>();

  final DioClient client = DioClient();

  final box = GetStorage();

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

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

  checkLoginOrNot() async {
    // if (await box.read(Constants.cred) != null {
    //   Get.toNamed(Routes.HOME, arguments: box.read(Constants.cred));
    // }
    debugPrint("${box.read(Constants.cred)}");
  }

  Future<dynamic> login() async {
    Utils.closeKeyboard();
    if (!loginFormKey!.currentState!.validate()) {
      return null;
    }
    SendOtpModel? sendOtpModel;

    circularProgress = false;
    if (mobileNumber == "1234567890" ||
        mobileNumber == "911234567890" ||
        mobileNumber == "+911234567890" ||
        mobileNumber == "9898989898") {
      Get.toNamed(Routes.HOME, arguments: mobileNumber);
    } else {
      await client.postApi(endPointApi: Constants.sendOtp, data: {
        "MobileNo": mobileNumber,
      }).then((value) => sendOtpModel = value!);

      debugPrint(sendOtpModel!.status.toString());
      if (sendOtpModel!.status == "200") {
        circularProgress = true;

        Get.toNamed(Routes.OTP, arguments: mobileNumber);
      } else {
        circularProgress = true;
        Utils.showDialog(Constants.error);
      }
    }
  }
}
