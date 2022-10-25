import 'package:get/get.dart';
import 'package:mobiledelivery/src/environment/environment.dart';
import 'package:mobiledelivery/src/models/response_api.dart';
import 'package:mobiledelivery/src/models/user.dart';

class UsersProvider extends GetConnect {

  String url = Environment.API_URL + 'api/users';
  
  
  Future<Response> create(User user) async {
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    ); // ESPERAR ATÉ QUE O SERVIDOR NOS RETORNE A RESPOSTA

    return response;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    ); // ESPERAR ATÉ QUE O SERVIDOR NOS RETORNE A RESPOSTA

    if (response.body == null) {
      Get.snackbar('Error', 'Não foi possível executar a petição');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
} 