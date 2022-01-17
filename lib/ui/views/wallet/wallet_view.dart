import 'package:eve/eve.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moovy/core/constants/app_colors.dart';
import 'package:moovy/core/constants/asset_paths.dart';
import 'package:moovy/core/models/account.dart';
import 'package:moovy/core/utils/formatter.dart';
import 'package:moovy/ui/views/login/login_view_model.dart';
import 'package:moovy/ui/views/wallet/wallet_view_model.dart';
import 'package:moovy/ui/widgets/currency.dart';
import 'package:moovy/ui/widgets/loader.dart';

class WalletView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final wallets = watch(walletsProvider);
    final user = watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserInfo(
            userName: user.data!.hasWalletUsername!
                ? "${user.data!.wirepayTag}"
                : "${user.data!.firstName}",
            hasUserName: user.data!.hasWalletUsername!,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            color: Colors.grey[300],
            child: Text(
              "WALLETS",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          wallets.maybeWhen(
            orElse: () => Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Loader(),
            )),
            data: (userWallets) => Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (_, index) {
                  final wallet = userWallets[index];
                  return _WalletTile(wallet: wallet);
                },
                separatorBuilder: (_, index) {
                  return Divider();
                },
                itemCount: userWallets.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String userName;
  final bool hasUserName;
  const _UserInfo({Key? key, required this.userName, this.hasUserName: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      padding: EdgeInsets.fromLTRB(8, 0, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Hello \$$userName,",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              hasUserName
                  ? SvgPicture.asset(
                      AssetPaths.qr,
                      height: 36,
                      width: 36,
                      color: Colors.white,
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "What would you like to do today?",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: EveButton(
                  title: 'FUND WALLET',
                  bgColor: Color(0xFF0A1172),
                  busy: false,
                  disabled: false,
                  onTap: () {},
                  borderRadius: 10,
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: EveButton(
                  title: 'WITHDRAW',
                  bgColor: Color(0xFF0A1172),
                  busy: false,
                  disabled: false,
                  borderRadius: 10,
                  onTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

class _WalletTile extends StatelessWidget {
  final Wallets wallet;
  const _WalletTile({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      dense: true,
      leading: Currency(path: wallet.icon!),
      title: Text(
        "${wallet.name}",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
      ),
      trailing: Text(
        "${Formatter.toMoney(wallet.balance.toString())} ${wallet.code}",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
