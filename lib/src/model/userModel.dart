class AppUser {
  final String userId;
  final String email;

  AppUser({this.email, this.userId});

  Map<String,dynamic> toMap(){
    return {
      'userId': userId,
      'email': email
    };
  }
AppUser.fromFirestore(Map<String,dynamic> firestore)
    : userId = firestore['userId'],
      email = firestore['email'];
}

