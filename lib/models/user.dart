class User {
  final String username;
  final String password;
  final bool isBusiness;
  final String? businessName;
  final String? businessAddress;

  User({
    required this.username,
    required this.password,
    required this.isBusiness,
    this.businessName,
    this.businessAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'isBusiness': isBusiness,
      'businessName': businessName,
      'businessAddress': businessAddress,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
      isBusiness: map['isBusiness'],
      businessName: map['businessName'],
      businessAddress: map['businessAddress'],
    );
  }
}
