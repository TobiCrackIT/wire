import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/constants/app_colors.dart';
import 'package:moovy/ui/views/base/base_view_model.dart';

class BaseView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(baseNotifier);

    return  Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: model.screens[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.blue,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 14),
              selectedLabelStyle: TextStyle(color: AppColors.blue,fontSize: 14),
              onTap: (index) => model.setIndex(index),
              currentIndex: model.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_balance_wallet_outlined,
                  ),
                  label: "Wallets",
                  activeIcon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.blue,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                  label: "Cards",
                  activeIcon: Icon(
                    Icons.credit_card,
                    color: AppColors.blue,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.trending_up_outlined,
                  ),
                  label: "Transactions",
                  activeIcon: Icon(
                    Icons.trending_up_outlined,
                    color: AppColors.blue,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.supervised_user_circle,
                  ),
                  label: "Profile",
                  activeIcon: Icon(
                    Icons.supervised_user_circle,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
