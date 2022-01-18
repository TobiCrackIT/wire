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

