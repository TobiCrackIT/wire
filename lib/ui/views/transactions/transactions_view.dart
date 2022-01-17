import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/constants/app_colors.dart';
import 'package:moovy/core/models/transactions.dart';
import 'package:moovy/core/utils/formatter.dart';
import 'package:moovy/ui/views/transactions/transactions_view_model.dart';
import 'package:moovy/ui/widgets/loader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final transactions = watch(transactionsProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: Text("Transactions"),
        ),
        body: transactions.maybeWhen(
          orElse: () => Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.hourglass_empty,
                color: AppColors.blue,
                size: 40,
              ),
              Text("No transaction(s) yet."),
            ],
          )),
          loading: () {
            final cachedTransactions = watch(cachedTransactionsProvider).state;
            return cachedTransactions.isNotEmpty
                ? _UserTransactionsView(transactions: cachedTransactions)
                : Center(child: Loader());
          },
          data: (transaction) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              watch(cachedTransactionsProvider).state = transaction;
            });
            return _UserTransactionsView(transactions: transaction);
          },
          error: (e, s) =>
              Center(child: Text("An error occurred: ${e.toString()}")),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.palette,
      ),
      title: Text("${transaction.title}"),
      subtitle: Text(
        "${transaction.status!.toUpperCase()}",
        style: TextStyle(
            color: transaction.status!.toUpperCase() == "FAILED"
                ? Colors.red
                : Colors.green),
      ),
      trailing: Text(
        "${transaction.currency} ${Formatter.toMoney(transaction.amount.toString())}",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}

class _UserTransactionsView extends ConsumerWidget {
  final List<Transaction> transactions;

  _UserTransactionsView({Key? key, required this.transactions})
      : super(key: key);

  final controller = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context, watch) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () {
        context.refresh(transactionsProvider);
        //Future.delayed(Duration(milliseconds: 5000));
        controller.refreshCompleted();
      },
      controller: controller,
      child: transactions.isEmpty
          ? ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.hourglass_empty,
                  color: AppColors.blue,
                  size: 60,
                ),
                Text("No transaction(s) yet.",textAlign: TextAlign.center,),
              ],
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (_, index) {
                final _currentTransaction = transactions[index];
                return _TransactionTile(
                  transaction: _currentTransaction,
                );
              },
              separatorBuilder: (_, index) {
                return Divider();
              },
              itemCount: transactions.length,
            ),
    );
  }
}
