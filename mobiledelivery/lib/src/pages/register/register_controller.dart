import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiledelivery/src/models/user.dart';
import 'package:mobiledelivery/src/providers/users_provider.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {

      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      Response response = await usersProvider.create(user);

      Get.snackbar('Formulario válido', 'Estas listas para enviar a petição Http');
    }
  }

  bool isValidForm(
      String email,
      String name,
      String lastname,
      String phone,
      String password,
      String confirmPassword
  ) {

    if (email.isEmpty) {
      Get.snackbar('Formulário não válido', 'Deve preencher o email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulário não válido', 'O email não á válido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulário não válido', 'Deve preencher o nome');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulário não válido', 'Deve preencher o sobrenome');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulário não válido', 'Deve preencher o telefone');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulário não válido', 'Deve preencher o password');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulário não válido', 'Deve preencher a confirmação do password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulário não válido', 'Senhas não coincidem');
      return false;
    }

    return true;
  }

}