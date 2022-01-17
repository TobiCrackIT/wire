import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/models/transactions.dart';
import 'package:moovy/core/services/local_storage_service.dart';
import 'package:moovy/core/services/user_service.dart';
import 'package:moovy/core/utils/exceptions.dart';

final transactionsProvider = FutureProvider<List<Transaction>>((ref) async {
  UserService _userService = UserService();
  final localStorageService = ref.watch(localStorageServiceProvider);

  try {
    var transactions =
        await _userService.getTransactions(localStorageService.token);

    return transactions.data!;
  } on ApiException catch (e) {
    throw ApiException(e.toString());
  }
});

final cachedTransactionsProvider =
    StateProvider<List<Transaction>>((ref) => []);

final transactionsNotifier =
    ChangeNotifierProvider<TransactionsViewModel>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return TransactionsViewModel(localStorageService);
});

class TransactionsViewModel extends ChangeNotifier {
  final LocalStorageService localStorageService;
  TransactionsViewModel(this.localStorageService);

  UserService _userService = UserService();

  List<Transaction> _allTransactions = [];
  List<Transaction> get allTransactions => _allTransactions;

  bool _isFreshLoading = true;
  bool get isFreshLoading => _isFreshLoading;

  bool _isBusy=false;
  bool get isBusy=>_isBusy;

  void getTransactions() async {

    debugPrint("Fetching transactions");
    _isBusy=true;
    notifyListeners();
    try {
      var transactions =
          await _userService.getTransactions(localStorageService.token);
      _allTransactions = transactions.data!;
      _isBusy=true;
      notifyListeners();
    } on ApiException catch (e) {
      _isBusy=true;
      notifyListeners();
      throw ApiException(e.toString());
    }
  }

  Future<void> refresh()async{
    try {
      var transactions =
          await _userService.getTransactions(localStorageService.token);
      _allTransactions=[];
      _allTransactions = transactions.data!;
      notifyListeners();
    } on ApiException catch (e) {
      _isBusy=true;
      notifyListeners();
      throw ApiException(e.toString());
    }
  }
}
