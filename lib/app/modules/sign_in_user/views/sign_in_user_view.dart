import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:setlife/app/constants/app_colors.dart';
import 'package:setlife/app/modules/sign_in_user/views/sign_in_mobile.dart';

import '../controllers/sign_in_user_controller.dart';
import 'sign_in_user.dart';

class SignInUserView extends GetView<SignInUserController> {
  const SignInUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const [
            Text("Sign In Mobile No."),
            Text("Sign In Username"),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          // dragStartBehavior: DragStartBehavior.down,
          controller: controller.tabController,
          children: const [
            Center(child: SignInMobile()),
            Center(child: SignInUser()),
          ],
        ),
      ),
    );
  }
}
