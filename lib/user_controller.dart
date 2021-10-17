import 'package:alga/repositories/app_repo.dart';
import 'package:get/get.dart';

import 'utils/app_box.dart';

class UserController extends GetxController {
  static final I = Get.find<UserController>();

  final isLoading = false.obs;
  final isLogin = AppBox.isLogin.obs;

  final _appRepo = Get.find<AppRepo>();

  @override
  void onInit() {
    super.onInit();
    AppBox.listen(AppBox.IS_LOGIN_KEY, _loginListener);
  }

  _loginListener() {
    isLogin.value = AppBox.isLogin;
  }

  login(
    String login,
    String password, {
    Function? onSuccess,
    Function? onError,
  }) async {
    isLoading.value = true;
    final result = await _appRepo.login(login, password);
    if (result)
      onSuccess?.call();
    else
      onError?.call();
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    isLogin.close();
    AppBox.removeListener(AppBox.IS_LOGIN_KEY, _loginListener);
  }
}
