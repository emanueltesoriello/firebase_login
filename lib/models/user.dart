class User {
  final String objectId, name, fcmToken, companyVatNumber;

  User({this.objectId, this.name, this.fcmToken, this.companyVatNumber});

  factory User.fromJSON(Map<String, dynamic> json) {
    print('JSON: ' + json.toString());
    return User(
        objectId: json['objectId'],
        name: json['name'],
        companyVatNumber: json['companyVatNumber'],
        fcmToken: json['fcmToken']);
  }
}
