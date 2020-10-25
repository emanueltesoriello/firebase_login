class User {
  final String objectId, userName, fcmToken, companyVatNumber;
  final bool isCompanyAdmin;

  User(
      {this.objectId,
      this.userName,
      this.fcmToken,
      this.companyVatNumber,
      this.isCompanyAdmin});

  factory User.fromJSON(Map<String, dynamic> json) {
    print('JSON: ' + json.toString());
    return User(
        objectId: json['objectId'],
        userName: json['userName'],
        companyVatNumber: json['companyVatNumber'],
        fcmToken: json['fcmToken'],
        isCompanyAdmin: json['companyAdmins'] != null
            ? json['companyAdmins'].contains(json['objectId'])
            : false);
  }
}
