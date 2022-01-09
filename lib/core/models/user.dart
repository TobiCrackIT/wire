class User {
  bool? success;
  String? message;
  Data? data;

  User({this.success, this.message, this.data});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? firstName;
  String? lastName;
  String? email;
  String? active;
  bool? verified;
  int? verificationLevel;
  bool? hasWalletUsername;
  String? wirepayTag;
  String? createdAt;

  Data(
      {this.token,
        this.firstName,
        this.lastName,
        this.email,
        this.active,
        this.verified,
        this.verificationLevel,
        this.hasWalletUsername,
        this.wirepayTag,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    active = json['active'];
    verified = json['verified'];
    verificationLevel = json['verification_level'];
    hasWalletUsername = json['has_wallet_username'];
    wirepayTag = json['wirepay_tag'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['active'] = this.active;
    data['verified'] = this.verified;
    data['verification_level'] = this.verificationLevel;
    data['has_wallet_username'] = this.hasWalletUsername;
    data['wirepay_tag'] = this.wirepayTag;
    data['created_at'] = this.createdAt;
    return data;
  }
}


