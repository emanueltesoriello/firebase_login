class User {
  final userName, fcmToken, associatedCompany, associatedLocation, associatedTechincalRoles, gender, address, postalCode, city, orders, sizes, magicCode;
  final bool isCompanyAdmin;

  User(
      {this.userName,
      this.fcmToken,
      this.isCompanyAdmin,
      this.associatedCompany,
      this.associatedLocation,
      this.associatedTechincalRoles,
      this.gender,
      this.address,
      this.postalCode,
      this.city,
      this.orders,
      this.sizes,
      this.magicCode});

  factory User.fromJSON(Map<String, dynamic> json) {
    print('JSON: ' + json.toString());
    return User(
        userName: json['userName'],
        isCompanyAdmin: json['isCompanyAdmin'],
        magicCode: json['magicCode'],
        associatedCompany: json['associatedCompany'],
        address:  json['address'],
        postalCode:  json['postalCode'],
        city: json['city'],
        fcmToken: json['fcmToken']);
  }
}
