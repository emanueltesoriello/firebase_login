class User {
  final objectId,
      userName,
      email,
      fcmToken,
      associatedCompany,
      associatedLocation,
      associatedContract,
      associatedRole,
      associatedTechincalRole,
      gender,
      address,
      postalCode,
      city,
      orders,
      sizes,
      magicCode,
      phoneNumber;
  final bool isCompanyAdmin;

  User(
      {this.objectId,
      this.userName,
      this.email,
      this.fcmToken,
      this.isCompanyAdmin,
      this.associatedCompany,
      this.associatedLocation,
      this.associatedContract,
      this.associatedRole,
      this.associatedTechincalRole,
      this.gender,
      this.address,
      this.postalCode,
      this.city,
      this.orders,
      this.sizes,
      this.magicCode,
      this.phoneNumber});

  factory User.fromJSON(Map<String, dynamic> json) {
    print('JSON: ' + json.toString());
    return User(
        objectId: json['objectId'],
        userName: json['userName'],
        email: json['email'],
        isCompanyAdmin: json['isCompanyAdmin'],
        magicCode: json['magicCode'],
        associatedCompany: json['associatedCompany'],
        associatedRole: json['associatedRole'],
        associatedLocation: json['associatedLocation'],
        associatedContract: json['associatedContract'],
        associatedTechincalRole: json['associatedTechicalRole'],
        address: json['address'],
        postalCode: json['postalCode'],
        city: json['city'],
        fcmToken: json['fcmToken'],
        phoneNumber: json['phoneNumber']);
  }
}
