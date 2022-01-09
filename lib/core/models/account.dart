class Account {
  bool? status;
  String? message;
  Data? data;

  Account({this.status, this.message, this.data});

  Account.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ProfileInformation? profileInformation;
  NubanVirtualAccount? nubanVirtualAccount;
  List<Wallets>? wallets;

  Data({this.profileInformation, this.nubanVirtualAccount, this.wallets});

  Data.fromJson(Map<String, dynamic> json) {
    profileInformation = json['profile_information'] != null
        ? new ProfileInformation.fromJson(json['profile_information'])
        : null;
    nubanVirtualAccount = json['nuban_virtual_account'] != null
        ? new NubanVirtualAccount.fromJson(json['nuban_virtual_account'])
        : null;
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(new Wallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileInformation != null) {
      data['profile_information'] = this.profileInformation!.toJson();
    }
    if (this.nubanVirtualAccount != null) {
      data['nuban_virtual_account'] = this.nubanVirtualAccount!.toJson();
    }
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileInformation {
  String? firstName;
  String? lastName;
  String? email;
  String? wiretag;
  String? referralCode;
  String? phoneNumber;
  String? avatar;
  int? verificationLevel;
  String? country;
  bool? verified;
  bool? canFundUsdWithBtc;
  bool? canFundUsdWithCard;
  bool? hasNubanVirtualAccount;
  String? lastLogin;
  String? createdAt;

  ProfileInformation(
      {this.firstName,
        this.lastName,
        this.email,
        this.wiretag,
        this.referralCode,
        this.phoneNumber,
        this.avatar,
        this.verificationLevel,
        this.country,
        this.verified,
        this.canFundUsdWithBtc,
        this.canFundUsdWithCard,
        this.hasNubanVirtualAccount,
        this.lastLogin,
        this.createdAt});

  ProfileInformation.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    wiretag = json['wiretag'];
    referralCode = json['referral_code'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    verificationLevel = json['verification_level'];
    country = json['country'];
    verified = json['verified'];
    canFundUsdWithBtc = json['can_fund_usd_with_btc'];
    canFundUsdWithCard = json['can_fund_usd_with_card'];
    hasNubanVirtualAccount = json['has_nuban_virtual_account'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['wiretag'] = this.wiretag;
    data['referral_code'] = this.referralCode;
    data['phone_number'] = this.phoneNumber;
    data['avatar'] = this.avatar;
    data['verification_level'] = this.verificationLevel;
    data['country'] = this.country;
    data['verified'] = this.verified;
    data['can_fund_usd_with_btc'] = this.canFundUsdWithBtc;
    data['can_fund_usd_with_card'] = this.canFundUsdWithCard;
    data['has_nuban_virtual_account'] = this.hasNubanVirtualAccount;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class NubanVirtualAccount {
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? country;
  String? currency;
  var minTransactionAmount;
  bool? isActive;

  NubanVirtualAccount(
      {this.accountNumber,
        this.accountName,
        this.bankName,
        this.country,
        this.currency,
        this.minTransactionAmount,
        this.isActive});

  NubanVirtualAccount.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankName = json['bank_name'];
    country = json['country'];
    currency = json['currency'];
    minTransactionAmount = json['min_transaction_amount'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['bank_name'] = this.bankName;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['min_transaction_amount'] = this.minTransactionAmount;
    data['is_active'] = this.isActive;
    return data;
  }
}

class Wallets {
  String? icon;
  String? code;
  String? name;
  var balance;
  var walletBalanceUsd;
  var exchangeRateToUsd;
  var exchangeRateToNgn;
  String? btcFundAddress;

  Wallets(
      {this.icon,
        this.code,
        this.name,
        this.balance,
        this.walletBalanceUsd,
        this.exchangeRateToUsd,
        this.exchangeRateToNgn,
        this.btcFundAddress});

  Wallets.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    code = json['code'];
    name = json['name'];
    balance = json['balance'];
    walletBalanceUsd = json['wallet_balance_usd'];
    exchangeRateToUsd = json['exchange_rate_to_usd'];
    exchangeRateToNgn = json['exchange_rate_to_ngn'];
    btcFundAddress = json['btc_fund_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['code'] = this.code;
    data['name'] = this.name;
    data['balance'] = this.balance;
    data['wallet_balance_usd'] = this.walletBalanceUsd;
    data['exchange_rate_to_usd'] = this.exchangeRateToUsd;
    data['exchange_rate_to_ngn'] = this.exchangeRateToNgn;
    data['btc_fund_address'] = this.btcFundAddress;
    return data;
  }
}
