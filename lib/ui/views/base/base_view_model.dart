import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/ui/views/card/card_view.dart';
import 'package:moovy/ui/views/profile/profile_view.dart';
import 'package:moovy/ui/views/transactions/transactions_view.dart';
import 'package:moovy/ui/views/wallet/wallet_view.dart';

final baseNotifier = ChangeNotifierProvider<BaseViewModel>((ref) {
  return BaseViewModel();
});


class BaseViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<Widget> _screens = [
    WalletView(),
    TransactionsView(),
    CardView(),
    ProfileView()
  ];
  List<Widget> get screens => _screens;

  setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
