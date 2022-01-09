import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/enums/login_status.dart';
import 'package:moovy/core/models/login_request.dart';
import 'package:moovy/core/models/user.dart';
import 'package:moovy/core/services/local_storage_service.dart';
import 'package:moovy/core/services/user_service.dart';
import 'package:moovy/core/utils/exceptions.dart';

final loginNotifier = ChangeNotifierProvider<LoginViewModel>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return LoginViewModel(localStorageService);
});

final userProvider = ScopedProvider<User>((_) => throw UnimplementedError());

class LoginViewModel extends ChangeNotifier {
  final LocalStorageService localStorageService;
  LoginViewModel(this.localStorageService);

  UserService _userService = UserService();

  User? currentUser;

  LoginStatus _loginStatus = LoginStatus.idle;
  LoginStatus get loginStatus => _loginStatus;

  String _emailAddress = "";
  String _password = "";

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _hidePassword = true;
  bool get hidePassword => _hidePassword;

  bool _canContinue = false;
  bool get canContinue => _canContinue;

  setEmailAddress(String? value) {
    if (value == "" || value == null) {
      return;
    }
    _emailAddress = value.trim();
    checkValidEmailAndPasswordLength();
    notifyListeners();
  }

  setPassword(String? value) {
    if (value == "" || value == null) {
      return;
    }
    _password = value.trim();
    checkValidEmailAndPasswordLength();
    notifyListeners();
  }
  
  togglePasswordVisibility(){
    _hidePassword=!_hidePassword;
    notifyListeners();
  }

  checkValidEmailAndPasswordLength() {
    if (EmailValidator.validate(_emailAddress) && _password.length >= 3) {
      _canContinue = true;
    } else {
      _canContinue = false;
    }
  }

  login() async {
    _loginStatus = LoginStatus.loading;
    notifyListeners();
    try {
      currentUser = await _userService
          .login(LoginRequest(email: _emailAddress, password: _password));
      localStorageService.setToken(currentUser!.data!.token!);
      _loginStatus = LoginStatus.success;
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = "${e.toString()}";
      _loginStatus = LoginStatus.failed;
      notifyListeners();
    }
  }

  reset() {
    _loginStatus = LoginStatus.idle;
    _errorMessage = "";
    notifyListeners();
  }
}
