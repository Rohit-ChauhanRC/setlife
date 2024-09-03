import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:setlife/app/constants/app_colors.dart';
import 'package:setlife/app/constants/constants.dart';
import 'package:setlife/app/widgets/check_box_widget.dart';

import '../controllers/sign_in_user_controller.dart';

class SignInUser extends GetView<SignInUserController> {
  const SignInUser({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: Get.height,
        width: Get.width,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       "assets/images/bg3.jpg",
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/setlife.png",
              height: 150,
              width: 200,
              // color: AppColor.kLogoColor,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: controller.userFormKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: TextFormField(
                          validator: (value) => value!.length < 3
                              ? "Please enter valid username"
                              : null,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (val) {
                            controller.mobileNumber = val;
                          },
                          decoration: InputDecoration(
                            label: const Text("Please enter username"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: TextFormField(
                          validator: (value) => value!.length < 3
                              ? "Please enter valid password"
                              : null,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (val) {
                            controller.mobileNumber = val;
                          },
                          decoration: InputDecoration(
                            label: const Text("Please enter password"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(() => CheckBoxWidget(
                            onChanged: (val) {
                              controller.agreeCheck = val!;
                              debugPrint("${controller.agreeCheck}");
                              debugPrint("${controller.agreeCheck}");
                            },
                            title: Constants.agreeTerms,
                            value: controller.agreeCheck,
                            width: Get.width * .6,
                            onTap: () {},
                          )),
                      controller.circularProgress
                          ? Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                              ),
                              width: Get.width / 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.purple_700,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fixedSize: const Size(120, 30),
                                ),
                                onPressed: () async {
                                  // Get.toNamed(Routes.OTP);

                                  if (controller.agreeCheck) {
                                    await controller.login();
                                  }
                                  // Get.toNamed(Routes.HOME);
                                },
                                child: const Text(
                                  Constants.login,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
