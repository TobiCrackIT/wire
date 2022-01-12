import 'package:moovy/core/constants/api_route.dart';
import 'package:moovy/core/models/account.dart';
import 'package:moovy/core/models/login_request.dart';
import 'package:moovy/core/models/transactions.dart';
import 'package:moovy/core/models/user.dart';
import 'package:moovy/core/services/http_service.dart';
import 'package:moovy/core/utils/exceptions.dart';

class UserService {
  HttpService _httpService = HttpService();

  User? currentUser;

  Future<dynamic> login(LoginRequest request) async {
    try {
      final response = await _httpService.post(
          '${ApiRoute.BASE}/v1/user/auth/login?version=2.0.0',
          {"email": request.email, "password": request.password},
          null);
      currentUser = User.fromJson(response!);
      return currentUser;
    } on Exception catch (e) {
      print("ERROR - ${e.toString()}");
      throw ApiException(e.toString());
    }
  }

  Future<Account> getAccount(String token) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };

    try {
      final response = await _httpService.get(
          '${ApiRoute.BASE}/v1/user/wallet/mobile/banking',
          headers: header);
      return Account.fromJson(response);
    } on Exception catch (e) {
      print("ERROR - ${e.toString()}");
      throw ApiException(e.toString());
    }
  }

  Future<Transactions> getTransactions(String token) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };

    try {
      final response = await _httpService.get(
          '${ApiRoute.BASE}/v1/user/wallet/transactions/',
          headers: header);

      print("${response.toString()}");

      return Transactions.fromJson(response);
    } on Exception catch (e) {
      print("ERROR - ${e.toString()}");
      throw ApiException(e.toString());
    }
  }
}
