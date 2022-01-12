class Transactions {
  bool? status;
  String? message;
  List<Transaction>? data;

  Transactions({this.status, this.message, this.data});

  Transactions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Transaction>[];
      json['data'].forEach((v) {
        data!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? id;
  String? status;
  String? transactionType;
  String? transactionEntry;
  String? reference;
  String? memo;
  String? failedReason;
  String? createdAt;
  String? type;
  String? title;
  var amount;
  String? currency;

  Transaction(
      {this.id,
        this.status,
        this.transactionType,
        this.transactionEntry,
        this.reference,
        this.memo,
        this.failedReason,
        this.createdAt,
        this.type,
        this.title,
        this.amount,
        this.currency});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    transactionType = json['transaction_type'];
    transactionEntry = json['transaction_entry'];
    reference = json['reference'];
    memo = json['memo'];
    failedReason = json['failed_reason'];
    createdAt = json['created_at'];
    type = json['type'];
    title = json['title'];
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['transaction_type'] = this.transactionType;
    data['transaction_entry'] = this.transactionEntry;
    data['reference'] = this.reference;
    data['memo'] = this.memo;
    data['failed_reason'] = this.failedReason;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}
