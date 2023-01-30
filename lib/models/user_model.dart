class UserModel {
  UserModel({
    this.fullname,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.country,
    this.city,
    this.pincode,
    this.token,
    this.id,
    this.userid,
    this.addedon,
    this.v,
  });

  String? fullname;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? country;
  String? city;
  String? pincode;
  String? token;
  String? id;
  String? userid;
  DateTime? addedon;
  int? v;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        pincode: json["pincode"],
        token: json["token"],
        id: json["_id"],
        userid: json["userid"],
        addedon: DateTime.parse(json["addedon"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "password": password,
        "address": address,
        "country": country,
        "city": city,
        "pincode": pincode,
        "token": token,
        "_id": id,
        "userid": userid,
        "addedon": addedon?.toIso8601String(),
        "__v": v,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        pincode: json["pincode"],
        token: json["token"],
        id: json["_id"],
        userid: json["userid"],
        addedon: DateTime.parse(json["addedon"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "password": password,
        "address": address,
        "country": country,
        "city": city,
        "pincode": pincode,
        "token": token,
        "_id": id,
        "userid": userid,
        "addedon": addedon?.toIso8601String(),
        "__v": v,
      };
}
