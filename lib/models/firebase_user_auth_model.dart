//User Model
class FirebaseUserAuthModel {
  String uid;
  String email;
  String displayName;
  String phoneNumber;
  String photoUrl;

  FirebaseUserAuthModel(
      {this.uid,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl});

  factory FirebaseUserAuthModel.fromMap(Map data) {
    return FirebaseUserAuthModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      displayName: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "photoUrl": photoUrl
      };
}
