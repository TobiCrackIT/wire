import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/models/account.dart';
import 'package:moovy/core/services/local_storage_service.dart';
import 'package:moovy/core/services/user_service.dart';
import 'package:moovy/core/utils/exceptions.dart';


final walletsNotifier = ChangeNotifierProvider<WalletsViewModel>((ref) {
  return WalletsViewModel();
});

class WalletsViewModel extends ChangeNotifier{



}

final walletsProvider = FutureProvider<List<Wallets>>((ref)async{
  UserService _userService = UserService();
  final localStorageService = ref.watch(localStorageServiceProvider);

  try {
    final account=await _userService.getAccount(localStorageService.token);
    return account.data!.wallets!;
  } on ApiException catch (e) {
    print("${e.toString()}");
    throw ApiException(e.toString());
  }

});