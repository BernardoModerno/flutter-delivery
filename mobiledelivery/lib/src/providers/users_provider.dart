import 'package:get/get.dart';
import 'package:mobiledelivery/src/environment/environment.dart';
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
} 