import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/constants/app_colors.dart';
import 'package:moovy/core/models/transactions.dart';
import 'package:moovy/core/utils/formatter.dart';
import 'package:moovy/ui/views/transactions/transactions_view_model.dart';
import 'package:moovy/ui/widgets/loader.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            transactions.maybeWhen(
              orElse: () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Loader()
                ],
              ),
              data: (transaction) => Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (_, index) {
                    final _currentTransaction = transaction[index];
                    return _TransactionTile(
                      transaction: _currentTransaction,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return Divider();
                  },
                  itemCount: transaction.length,
                ),
              ),
              error: (e, s) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("An error occurred: ${e.toString()}"),
                ],
              ),
            )
          ],
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
        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
      ),
    );
  }
}
