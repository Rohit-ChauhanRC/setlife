import 'package:get/get.dart';

import '../controllers/sign_in_user_controller.dart';

class SignInUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInUserController>(
      () => SignInUserController(),
    );
  }
}
