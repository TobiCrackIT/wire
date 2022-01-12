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
                    Icons.home,
                  ),
                  label: "Wallets",
                  activeIcon: Icon(
                    Icons.home,
                    color: AppColors.blue,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.card_giftcard,
                  ),
                  label: "Transactions",
                  activeIcon: Icon(
                    Icons.wallet_travel,
                    color: AppColors.blue,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.transfer_within_a_station,
                  ),
                  label: "Cards",
                  activeIcon: Icon(
                    Icons.transfer_within_a_station,
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
