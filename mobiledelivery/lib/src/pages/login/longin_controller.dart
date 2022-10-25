import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobiledelivery/src/models/response_api.dart';
import 'package:mobiledelivery/src/models/user.dart';
import 'package:mobiledelivery/src/providers/users_provider.dart';

class LoginController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {

      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data); // Dados do usuário em sessão
        goToHomePage();
      }
      else {
        Get.snackbar('Login falhou', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.toNamed('/home');
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulário não é válido', 'Deve colocar o email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulário não é válido', 'O email não é válido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulário não é válido', 'Deve colocar o password');
      return false;
    }

    return true;
  }

}